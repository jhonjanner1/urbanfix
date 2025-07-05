from flask import Flask, jsonify, render_template, request, redirect, url_for, session
from pywebpush import webpush, WebPushException
import json

from flaskext.mysql import MySQL 
import pymysql
import smtplib


app = Flask(__name__, template_folder='templates')

# Clave secreta para que Flask pueda usar sesiones
app.secret_key = 'urbanfix'
mysql = MySQL()

# Configuración básica
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_DB'] = 'urbanfix'
mysql.init_app(app)

# Configuración VAPID (REEMPLAZA CON TUS CLAVES)
VAPID_PRIVATE_KEY = "xHfHfiRs_ys6mgkcZKprHkQ7WKR3XA6tnn5aZjSzB9E"
VAPID_PUBLIC_KEY = "BJjKJhmzxW3aq7gRM8uarPZhT6IAMMPvnW9PBHY5ljpz8RFFoqAOU5BIqbsAntljdiyGkDL6EDq4yPaFj7q_Iu0"
VAPID_CLAIMS = {
    "sub": "mailto:giovannyurigod655@gmail.com"
}


# Crear tabla para suscripciones (ejecutar una sola vez)
def create_subscriptions_table():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS subscriptions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            endpoint TEXT NOT NULL,
            p256dh TEXT NOT NULL,
            auth TEXT NOT NULL,
            user_id INT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
        """)
        conn.commit()
    except Exception as e:
        print(f"Error creando tabla: {e}")
    finally:
        cursor.close()
        conn.close()


# Ruta para suscribir usuarios
@app.route('/subscribe', methods=['POST'])
def subscribe():
    if not request.json or 'endpoint' not in request.json:
        return jsonify({'error': 'Datos incompletos'}), 400

    subscription = request.json
    user_id = request.args.get('user_id', type=int)  # Opcional

    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO subscriptions (endpoint, p256dh, auth, user_id)
            VALUES (%s, %s, %s, %s)
            """,
            (
                subscription['endpoint'],
                subscription['keys']['p256dh'],
                subscription['keys']['auth'],
                user_id
            )
        )
        conn.commit()
        return jsonify({'success': True}), 201
    except Exception as e:
        print(f"Error en /subscribe: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()

    
# Ruta para enviar notificaciones
@app.route('/send-notification', methods=['POST'])
def send_notification():
    if not request.json or 'title' not in request.json:
        return jsonify({'error': 'Datos incompletos'}), 400

    notification = request.json

    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT endpoint, p256dh, auth FROM subscriptions")
        subscriptions = cursor.fetchall()
        cursor.close()
        conn.close()

        for sub in subscriptions:
            try:
                webpush(
                    subscription_info={
                        "endpoint": sub['endpoint'],
                        "keys": {
                            "p256dh": sub['p256dh'],
                            "auth": sub['auth']
                        }
                    },
                    data=json.dumps({
                        "title": notification['title'],
                        "body": notification.get('body', ''),
                        "icon": notification.get('icon', 'http://127.0.0.1:5000/static/icon.png')
                    }),
                    vapid_private_key=VAPID_PRIVATE_KEY,
                    vapid_claims=VAPID_CLAIMS
                )
            except WebPushException as e:
                print(f"Error enviando notificación: {e}")

        return jsonify({'success': True, 'sent_to': len(subscriptions)}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500



if __name__ == '__main__':
    create_subscriptions_table()
    app.run(debug=True)

@app.route('/')
def home():
    return render_template('index.html', public_key=VAPID_PUBLIC_KEY)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # obtienes correo y contraseña
        correo = request.form.get('correo').strip().lower()
        contrasena = request.form.get('contrasena').strip()

        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute(
                "SELECT * FROM usuarios WHERE correo = %s AND contrasena = %s",
                (correo, contrasena)
            )
            usuario = cursor.fetchone()

            if usuario:
                session['usuario_id'] = usuario['id_usuario']
                session['nombre'] = usuario['nombre']
                session['tipo_usuario'] = usuario['tipo_usuario']

                # Aquí va tu redirección según tipo_usuario:
                if usuario['tipo_usuario'] == 'admin':
                    return redirect(url_for('admin_dashboard'))
                elif usuario['tipo_usuario'] == 'JAC':
                    return redirect(url_for('jac_dashboard'))
                elif usuario['tipo_usuario'] == 'ciudadano':
                    return redirect(url_for('ciudadano_dashboard'))
                else:
                    return "Tipo de usuario desconocido"
            else:
                return "Correo o contraseña incorrectos"

        except Exception as e:
            return f"Error al iniciar sesión: {str(e)}"
        finally:
            cursor.close()
            conn.close()

    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombre = request.form.get('nombre')
        correo = request.form.get('correo')
        contrasena = request.form.get('contrasena')
        telefono = request.form.get('telefono')
        tipo_usuario = request.form.get('tipo_usuario')
        id_junta = request.form.get('id_junta')
        fecha_registro = request.form.get('fecha_registro')

        # Si id_junta está vacío o None, guardamos NULL en la BD
        if not id_junta or id_junta.strip() == '':
            id_junta = None
        else:
            try:
                id_junta = int(id_junta)
            except ValueError:
                id_junta = None

        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute(
                "INSERT INTO usuarios (nombre, correo, contrasena, telefono,  tipo_usuario, id_junta, fecha_registro) "
                "VALUES (%s, %s, %s, %s, %s, %s, %s)",
             (nombre, correo, contrasena, telefono,  tipo_usuario, id_junta, fecha_registro)
            )
            conn.commit()
            return redirect('/login')
        except Exception as e:
            return f"Error al registrar usuario: {str(e)}"
        finally:
            cursor.close()
            conn.close()

    return render_template('register.html')

@app.route('/ciudadano')
def ciudadano_dashboard():
    print(session)  # Verifica qué hay en sesión
    if 'usuario_id' not in session or session.get('tipo_usuario') != 'ciudadano':
        return redirect(url_for('login'))
    return render_template('ciudadano.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)



class Mensaje:

  CARRIERS = {
      "gmail": "@gmail.com"
  }
  #email de prueba o proyecto w
  EMAIL = "giovannyurigod655@gmail.com"
  #contraseña de app generada desde gmail
  PASSWORD = "ekptlvyayayvhmot"


  def __init__(self, email):
        self.email = email

  def enviar_correo(self, destinatario, texto): #definicion metodo para envio de correo
        recipient = destinatario
        if not recipient:
            return "Carrier no válido."

        message = f"Subject: Notificacion\n\n{texto}"

        try:
            enviar = smtplib.SMTP("smtp.gmail.com", 587)
            enviar.starttls()
            print(self.EMAIL, self.PASSWORD)
            enviar.login(self.EMAIL, self.PASSWORD)
            enviar.sendmail(self.EMAIL,recipient, message)
            enviar.quit()
            return f"Correo enviado a {recipient}"
        except Exception as e:
            return f"Error al enviar el correo: {e}"

  def recibir(self):
        return f"Este es el método recibir mensaje"

  def marcar_leido(self):
        return f"Este es el método marcar mensaje"

# Crear una instancia
mi_mensaje = Mensaje("tucorreo@gmail.com")

# uso de metodos
print(mi_mensaje.enviar_correo("giovannyurigod655@gmail.com", "Este mensaje es una prueba de funciono y ahora urbanfix es el cambio del mundo :P, reparar calles"))
print(mi_mensaje.recibir())
print(mi_mensaje.marcar_leido())


    