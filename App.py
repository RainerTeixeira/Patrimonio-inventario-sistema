# Importações necessárias para o código
from flask import Flask, render_template, request, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy

# Inicialização da aplicação Flask
app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

# Configurações do SQLAlchemy para a conexão com o banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/crud'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Inicialização do SQLAlchemy
db = SQLAlchemy(app)

# Definição do modelo de dados para SQLAlchemy
class Data(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))
    phone = db.Column(db.String(100))

    def __init__(self, name, email, phone):
        self.name = name
        self.email = email
        self.phone = phone

# Definição de rota para a página inicial da aplicação
@app.route('/')
def Index():
    return render_template('index.html', bootstrap=bootstrap)


@app.route('/insert', methods=['POST'])
def insert():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']

        my_data = Data(name, email, phone)
        db.session.add(my_data)
        db.session.commit()

        return redirect (url_for('Index'))
            

# Execução da aplicação
if __name__ == '__main__':
    app.run(debug=True)
