from flask import Flask, render_template, redirect, url_for, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)
# app.config.from_pyfile('config.py')
app.config['SECRET_KEY'] = 'e1b3600439ece51abb446ca8eff2ad32459ce7b588eef241'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///example.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Task(db.Model): # db 생성
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)

class TaskForm(FlaskForm): # form 생성, 입력한 data를 db에 저장
    title = StringField('Title', validators=[DataRequired()])
    submit = SubmitField('Add Task')

@app.route('/', methods=['GET', 'POST'])  # 아무것도 클라이언트가 요청하지 않으면
def index():                              # route'/' 실행. (즉 idex.route)
    form = TaskForm()
    if form.validate_on_submit():
        new_task = Task(title=form.title.data)
        db.session.add(new_task) # db에 작성
        db.session.commit() # db에 저장
        return redirect(url_for('index')) # 다시 index로 입력할 수 있게 recycle 
    return render_template('index.html', form=form) # 렌더링해서 보여줌.
# 클릭 동적동작은 자바스크립트로 index에 작성함.

@app.route('/tasks')
def tasks():
    tasks = Task.query.all()
    return jsonify([{'id': task.id, 'title': task.title} for task in tasks])
    # tasks가 클라이언트에게 입력되면 json 타입으로 변환되서 리턴해줌. 
    # 보통 db는 json 형식으로 주고받음으로 변환한 것.

@app.route("/edit/<int:task_id>", methods=['GET','POST'])
def deit(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm()
    if form.validate_on_submit():
        task.title = form.title.data
        db.session.commit()
        return redirect(url_for('index'))
    form.title.data = task.title
    return render_template('edit_task.html', form=form, task_id = task_id, task_title = task.title)

@app.route("/delete/<int:task_id>")
def delete(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)