from flask import Flask, render_template
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.secret_key = "Secret Key"

app.config['SQLALCHEMY DATABASE_URL'] = 'mysql://root:''@localhost/crud'
app.config['SQLALCHEMY TRACK_MODIFICATIONS'] = False

db = sqlalchemy(app)


class Data(db.model):
    id = db.column(db.innteger, primary_key=True)
    name = db.column(db.String(100))
    email = db.column(db.String(100))
    phone = db.column(db.String(100))

@app.route('/')
def index():
    return render_template('index.html', bootstrap=bootstrap)


if __name__ == '__main__':
    app.run(debug=True)
