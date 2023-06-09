from flask import Flask, flash, redirect, render_template, request, url_for, make_response
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_
from sqlalchemy import text
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib import colors
from flask_ckeditor import CKEditor

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

# Configurações do SQLAlchemy para a conexão com o banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/empresa'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Instância do CKEditor
ckeditor = CKEditor(app)

db = SQLAlchemy(app)

class Funcionario(db.Model):
    __tablename__ = 'funcionarios'
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    ativo = db.Column(db.Enum('Ativo', 'Desligado'), nullable=False)
    ramal = db.Column(db.Integer)
    login = db.Column(db.String(45))
    senha = db.Column(db.String(45))
    nivel_permissao = db.Column(db.Enum('Administrador', 'Usuário'))
    funcao = db.Column(db.Integer, db.ForeignKey('setor_funcao.id'), nullable=False)
    setor = db.relationship('SetorFuncao', backref=db.backref('funcionarios', lazy=True))

class Setor(db.Model):
    __tablename__ = 'setor'
    id = db.Column(db.Integer, primary_key=True)
    nome_setor = db.Column(db.String(45))

class SetorFuncao(db.Model):
    __tablename__ = 'setor_funcao'
    id = db.Column(db.Integer, primary_key=True)
    nome_funcao = db.Column(db.String(45))
    setor_id = db.Column(db.Integer, db.ForeignKey('setor.id'), nullable=False)

class Manual(db.Model):
    __tablename__ = 'manual'
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=True)

@app.route('/')
def index():
    manuais = Manual.query.all()
    return render_template('index.html', bootstrap=bootstrap, manuais=manuais)

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
        funcao = request.form['funcao']

        funcionario = Funcionario(nome=nome, ativo=ativo, ramal=ramal, login=login, senha=senha,
                                  nivel_permissao=nivel_permissao, funcao=funcao)
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
        funcao = request.form['funcao']

        funcionario = Funcionario.query.get(id)
        if funcionario:
            funcionario.nome = nome
            funcionario.ativo = ativo
            funcionario.ramal = ramal
            funcionario.login = login
            funcionario.senha = senha
            funcionario.nivel_permissao = nivel_permissao
            funcionario.funcao = funcao

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

@app.route('/gerar_pdf')
def gerar_pdf():
    funcionarios = Funcionario.query.all()

    data = [["ID", "Nome", "Status", "Ramal", "Login", "Senha", "Nível de Permissão", "Função"]]
    for funcionario in funcionarios:
        data.append([funcionario.id, funcionario.nome, funcionario.ativo, funcionario.ramal, funcionario.login, funcionario.senha, funcionario.nivel_permissao, funcionario.funcao])

    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=letter)

    styles = getSampleStyleSheet()
    title = Paragraph("Inventário, Manual de Procedimentos, Acervo de Conhecimentos e Tecnologia Operacional - IMPACTO", styles["Title"])
    elems = [title]

    table = Table(data)
    
    style = TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 14),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0,0), (-1,-1), 1, colors.black)
    ])
    table.setStyle(style)

    elems.append(table)

    doc.build(elems)

    pdf_data = buffer.getvalue()
    buffer.close()
    response = make_response(pdf_data)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] = 'attachment; filename=relatorio.pdf'

    return response

@app.route('/procedimentos', methods=['GET'])
def procedimentos():
    search_query = request.args.get('search_query')
    if search_query is not None:
        sql = text("""
            SELECT t.titulo, t.conteudo
            FROM topico t
            WHERE t.titulo LIKE :search_query
        """)
        result = db.session.execute(sql, {'search_query': f"%{search_query}%"})
    else:
        sql = text("SELECT t.titulo, t.conteudo FROM topico t")
        result = db.session.execute(sql)
        
    topicos = [{'titulo': row[0], 'conteudo': row[1]} for row in result]

    manuais = Manual.query.all()  # Adicione esta linha para buscar os dados da tabela manual

    return render_template('procedimentos.html', topicos=topicos, manuais=manuais)











if __name__ == '__main__':
    app.run(debug=True)
