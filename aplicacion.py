from flask import Flask, render_template, request, redirect, url_for, session
from flaskext.mysql import MySQL 
import pymysql

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

@app.route('/')
def home():
    return render_template('index.html')

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
