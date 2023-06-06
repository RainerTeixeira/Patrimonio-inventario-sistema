from flask import Flask, flash, redirect, render_template, request, url_for, make_response
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_, text
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib import colors

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

# Configurações do SQLAlchemy para a conexão com o banco de dados
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/empresa'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

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
    setor_id = db.Column(db.Integer, db.ForeignKey('setor.id'), nullable=False)

    setor = db.relationship('Setor', backref=db.backref('funcionarios', lazy=True))

class Setor(db.Model):
    __tablename__ = 'setor'

    id = db.Column(db.Integer, primary_key=True)
    setor_nome = db.Column(db.String(45))
    departamento = db.Column(db.String(45))

class Topico(db.Model):
    __tablename__ = 'topicos'

    id = db.Column(db.Integer, primary_key=True)
    id_topico = db.Column(db.Integer, nullable=False)
    conteudo_topicos = db.Column(db.Text)
    imagem_url = db.Column(db.String(255))
    video_url = db.Column(db.String(255))

funcionarios_possui_manual = db.Table('funcionarios_possui_manual',
    db.Column('funcionarios_id', db.Integer, db.ForeignKey('funcionarios.id')),
    db.Column('topicos_id', db.Integer, db.ForeignKey('topicos.id'))
)

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

@app.route('/gerar_pdf')
def gerar_pdf():
    funcionarios = Funcionario.query.all()

    data = [["ID", "Nome", "Status", "Ramal", "Login", "Senha", "Nível de Permissão", "Setor ID"]]
    for funcionario in funcionarios:
        data.append([funcionario.id, funcionario.nome, funcionario.ativo, funcionario.ramal, funcionario.login, funcionario.senha, funcionario.nivel_permissao, funcionario.setor_id])

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

@app.route('/consulta_procedimentos', methods=['GET'])
def consulta_procedimentos():
    setor_id = request.args.get('setor_id')
    if setor_id is not None:
        sql = text("""
            SELECT f.nome, t.conteudo_topicos
            FROM funcionarios f
            JOIN funcionarios_possui_manual fm ON f.id = fm.funcionarios_id
            JOIN topicos t ON fm.topicos_id = t.id
            WHERE f.setor_id = :setor_id
        """)
        result = db.session.execute(sql, {'setor_id': setor_id})
        funcionarios = [{"nome": row[0], "topico": row[1]} for row in result]
        return render_template('consulta_procedimentos.html', funcionarios=funcionarios)
    return "Setor não especificado."

@app.route('/procedimentos', methods=['GET'])
def procedimentos():
    search_query = request.args.get('search_query')
    if search_query is not None:
        sql = text("""
            SELECT t.conteudo_topicos
            FROM topicos t
            WHERE t.conteudo_topicos LIKE :search_query
        """)
        result = db.session.execute(sql, {'search_query': f"%{search_query}%"})
    else:
        sql = text("SELECT t.conteudo_topicos FROM topicos t")
        result = db.session.execute(sql)
        
    topicos = [row[0] for row in result]
    return render_template('procedimentos.html', topicos=topicos)

if __name__ == '__main__':
    app.run(port=5000, debug=True)
