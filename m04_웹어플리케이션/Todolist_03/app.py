from flask import Flask, render_template, redirect, url_for, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, DateField
from wtforms.validators import DataRequired
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz

app = Flask(__name__)
app.config.from_pyfile("config.py")

db = SQLAlchemy(app)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)

class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.Date, nullable=False, default=datetime.utcnow)
    due_date = db.Column(db.Date, nullable=False)

class TaskForm(FlaskForm):
    title = StringField('제목', validators=[DataRequired()]) # 짧은 입력 텍스트 필드
    contents = TextAreaField("내용", validators=[DataRequired()]) # 길이 제한 없는 텍스트 필드
    due_date= DateField("마감일", format="%Y-%m-%d", validators=[DataRequired()])
    # input_date 만들지 않는 이유. 입력하는게 아니라 pytz로 가져오는 것임)
 
@app.route('/')
def index():
    form = TaskForm()
    csrf_token = form.csrf_token._value() # 유저가 서버에 데이터를 요청할때 해당 기능에 대한 최초 SECRET_KEY를 사용하여 고유한 CSRF 토큰 발행하여 암호화하여 서버에 저장.
    return render_template("index.html", form=form, csrf_token=csrf_token) # (서버가 csrf 보관&검증하여 기능을 차단하거나, 공격하는걸 방지)


@app.route('/tasks')
def tasks():
    tasks = Task.query.all()
    return jsonify( # json 형식으로 데이터 전환.
        [
            {
                'id': task.id, 
                'title': task.title,
                'contents': task.contents,
                'input_date':task.input_date.strftime("%Y-%m-%d"),
                "due_date":task.due_date.strftime("%Y-%m-%d")
            }
            for task in tasks])

@app.route("/", methods=['POST']) # POST 방식 html <body> 부분에 출력하는 것.
def add_task():
    form = TaskForm()
    if form.validate_on_submit():
        title = form.title.data # TaskForm에서 title 가져옴.
        contents = form.contents.data # contents 가져옴

        # 한국 시간으로 현재 날짜 설정
        kst = pytz.timezone('Asia/Seoul')
        input_date = datetime.now(kst).date()
        due_date = form.due_date.data

        new_task = Task(title=title, contents=contents, input_date=input_date, due_date=due_date)
        
        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()
    return render_template('index.html', form=form, csrf_token=csrf_token)

@app.route("/edit/<int:task_id>", methods=["GET", "POST"])
def edit(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm(obj=task)
    if request.method == "POST" and form.validate_on_submit(): # html에서 'Edit Taks' 입력하면 서버에 요청해서 이걸 실행. (POST 방식)
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.comit() # 수정한 title,contents, due_date 저장.
        return redirect(url_for('index'))
    csrf_token = form.csrf_token._value()
    return render_template(
        "edit_task.html",
        form=form,
        task_id=task_id,
        csrf_token=csrf_token,
        task_title=task.title,
        task_contents=task.contents,
        task_input_date = task.input_date.strftime("%Y-%m-%d"),
        task_due_date = task.due_date.strftime("%Y-%m-%d")
    )
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