from flask import Flask, flash, redirect, render_template, send_from_directory, request, url_for
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

# Configurações do SQLAlchemy para a conexão com o banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/crud'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Data(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))
    phone = db.Column(db.String(100))

    def __init__(self, name, email, phone):
        self.name = name
        self.email = email
        self.phone = phone

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100))
    password = db.Column(db.String(100))

    def __init__(self, username, password):
        self.username = username
        self.password = password

@app.route('/')
def index():
    return render_template('index.html', bootstrap=bootstrap)

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    if username == 'rainer' and password == 'rainer':
        return redirect(url_for('painel'))

    flash('Falha no login. Tente novamente.', 'error')
    return redirect(url_for('index'))

@app.route('/painel')
def painel():
    data = Data.query.all()
    return render_template('painel.html', bootstrap=bootstrap, data=data)

@app.route('/insert', methods=['GET', 'POST'])
def insert():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']

        my_data = Data(name, email, phone)
        db.session.add(my_data)
        db.session.commit()

        flash('Dados inseridos com sucesso!', 'success')
        return redirect('/funcionarios')

    return "Erro na inserção dos dados."

@app.route('/update', methods=['POST'])
def update():
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']

        data = Data.query.get(id)
        if data:
            data.name = name
            data.email = email
            data.phone = phone
            db.session.commit()
            flash('Dados atualizados com sucesso!', 'success')
            return redirect('/funcionarios')

        else:
            return "Erro ao atualizar os dados."

    return "Erro na atualização dos dados."

@app.route('/delete/<int:id>', methods=['GET', 'POST'])
def delete(id):
    data = Data.query.get(id)
    if data:
        db.session.delete(data)
        db.session.commit()
        flash('Item excluído com sucesso!', 'success')
        return redirect('/funcionarios')
    else:
        return "Erro ao excluir o item."

@app.route('/search')
def search():
    term = request.args.get('term')
    if term:
        data = Data.query.filter(or_(Data.name.contains(term), Data.email.contains(term), Data.phone.contains(term))).all()
        return render_template('funcionarios.html', bootstrap=bootstrap, data=data)
    else:
        return redirect('/funcionarios')

@app.route('/funcionarios')
def funcionarios():
    data = Data.query.all()
    return render_template('funcionarios.html', bootstrap=bootstrap, data=data)

if __name__ == '__main__':
    app.run(port=5000, debug=True)
