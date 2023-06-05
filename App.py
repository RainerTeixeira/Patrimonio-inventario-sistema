from flask import Flask, flash, redirect, render_template, send_from_directory, request, url_for
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

# Configurações do SQLAlchemy para a conexão com o banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/empresa'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Funcionario(db.Model):
    __tablename__ = 'funcionarios'  # Nome correto da tabela

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    ativo = db.Column(db.Enum('Ativo', 'Desligado'), nullable=False)
    ramal = db.Column(db.Integer)
    login = db.Column(db.String(45))
    senha = db.Column(db.String(45))
    nivel_permissao = db.Column(db.Enum('Administrador', 'Usuário'))
    setor_id = db.Column(db.Integer, db.ForeignKey('setor.id'), nullable=False)

    setor = db.relationship('Setor', backref=db.backref('funcionarios', lazy=True))

class Setor(db.Model):
    __tablename__ = 'setor'  # Nome correto da tabela

    id = db.Column(db.Integer, primary_key=True)
    setor_nome = db.Column(db.String(45))
    departamento = db.Column(db.String(45))

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
    return render_template('painel.html', bootstrap=bootstrap)

@app.route('/insert', methods=['GET', 'POST'])
def insert():
    if request.method == 'POST':
        nome = request.form['nome']
        ativo = request.form['ativo']
        ramal = request.form['ramal']
        login = request.form['login']
        senha = request.form['senha']
        nivel_permissao = request.form['nivel_permissao']
        setor_id = request.form['setor_id']

        funcionario = Funcionario(nome=nome, ativo=ativo, ramal=ramal, login=login, senha=senha,
                                  nivel_permissao=nivel_permissao, setor_id=setor_id)
        db.session.add(funcionario)
        db.session.commit()

        flash('Funcionário inserido com sucesso!', 'success')
        return redirect(url_for('funcionarios'))

    return "Erro na inserção do funcionário."

@app.route('/update', methods=['POST'])
def update():
    if request.method == 'POST':
        id = request.form['id']
        nome = request.form['nome']
        ativo = request.form['ativo']
        ramal = request.form['ramal']
        login = request.form['login']
        senha = request.form['senha']
        nivel_permissao = request.form['nivel_permissao']
        setor_id = request.form['setor_id']

        funcionario = Funcionario.query.get(id)
        if funcionario:
            funcionario.nome = nome
            funcionario.ativo = ativo
            funcionario.ramal = ramal
            funcionario.login = login
            funcionario.senha = senha
            funcionario.nivel_permissao = nivel_permissao
            funcionario.setor_id = setor_id

            db.session.commit()
            flash('Funcionário atualizado com sucesso!', 'success')
            return redirect(url_for('funcionarios'))

        else:
            return "Erro ao atualizar o funcionário."

    return "Erro na atualização do funcionário."

@app.route('/delete/<int:id>', methods=['GET', 'POST'])
def delete(id):
    funcionario = Funcionario.query.get(id)
    if funcionario:
        db.session.delete(funcionario)
        db.session.commit()
        flash('Funcionário excluído com sucesso!', 'success')
        return redirect(url_for('funcionarios'))
    else:
        return "Erro ao excluir o funcionário."

@app.route('/search')
def search():
    term = request.args.get('term')
    if term:
        funcionarios = Funcionario.query.filter(or_(Funcionario.nome.contains(term),
                                                    Funcionario.login.contains(term))).all()
        return render_template('funcionarios.html', bootstrap=bootstrap, funcionarios=funcionarios)
    else:
        return redirect(url_for('funcionarios'))

@app.route('/funcionarios')
def funcionarios():
    funcionarios = Funcionario.query.all()
    return render_template('funcionarios.html', bootstrap=bootstrap, funcionarios=funcionarios)

if __name__ == '__main__':
    app.run(port=5000, debug=True)
