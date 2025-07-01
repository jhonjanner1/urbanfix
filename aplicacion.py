from flask import Flask, render_template, request, redirect, url_for, session
from flaskext.mysql import MySQL 
import pymysql

app = Flask(__name__, template_folder='templates')
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
        # Limpiar y normalizar los datos
        correo = request.form.get('correo').strip().lower()
        contrasena = request.form.get('contrasena').strip()

        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        try:
            # Ejecutar la consulta
            cursor.execute(
                "SELECT * FROM usuarios WHERE correo = %s AND contrasena = %s",
                (correo, contrasena)
            )
            usuario = cursor.fetchone()

            if usuario:
                # Guardar información en la sesión
                session['usuario_id'] = usuario['id']
                session['nombre'] = usuario['nombre']
                session['tipo_usuario'] = usuario['tipo_usuario']

                # Redirigir según el rol
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
        telefono = request.form.get('telefono')
        contrasena = request.form.get('contrasena')
        tipo_usuario = request.form.get('tipo_usuario')
        id_junta = request.form.get('id_junta')

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
                "INSERT INTO usuarios (nombre, correo, telefono, contrasena, tipo_usuario, id_junta_accion_comunal) "
                "VALUES (%s, %s, %s, %s, %s, %s)",
             (nombre, correo, telefono, contrasena, tipo_usuario, id_junta)
            )
            conn.commit()
            return redirect('/login')
        except Exception as e:
            return f"Error al registrar usuario: {str(e)}"
        finally:
            cursor.close()
            conn.close()

    return render_template('register.html')

if __name__ == '__main__':
    app.run(debug=True)
