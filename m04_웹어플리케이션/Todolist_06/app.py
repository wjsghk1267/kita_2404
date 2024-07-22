from flask import (
    Flask,
    request,
    jsonify,
    render_template,
    redirect,
    url_for,
    session,
    flash,
)
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz
from form import TaskForm, LoginForm, RegistrationForm
from models import db, Task, User

app = Flask(__name__)
app.config.from_pyfile("config.py")

db.init_app(app)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)

# 애플리케이션 요청 처리 전에 관리자 계정 생성
@app.before_request
def create_admin(): # 관리자 계정이 없으면 생성
    with app.app_context():
        if not User.query.filter_by(username="admin").first():
            admin = User(username="admin", is_admin=True)
            admin.set_password("admin")
            db.session.add(admin)
            db.session.commit()


@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        # 사용자명 중복 확인
        existing_user = User.query.filter_by(username=form.username.data).first()
        if existing_user:
            flash(
                "Username already exists. Please choose a different username.", "danger"
            )
            return render_template("register.html", form=form)
        username = form.username.data
        password = form.password.data
        user = User(username=username)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        flash("Registration successful. Please log in.", "success")
        return redirect(url_for("login"))
    return render_template("register.html", form=form)


@app.route("/login", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user and user.check_password(form.password.data):
            session["user_id"] = user.id
            session["username"] = user.username
            session["is_admin"] = user.is_admin
            flash("Login successful!", "success")
            return redirect(url_for("index"))
        flash("Invalid username or password.", "danger")
    return render_template("login.html", form=form)


@app.route("/logout")
def logout():
    session.clear()
    flash("You have been logged out.", "success")
    return redirect(url_for("login"))


@app.route("/")
def index():
    if "user_id" not in session:
        return redirect(url_for("login"))
    form = TaskForm()
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/tasks")
def tasks():
    if "user_id" not in session:
        return redirect(url_for("login"))
    tasks = Task.query.filter_by(user_id=session["user_id"]).all()
    return jsonify(
        [
            {
                "id": task.id,
                "title": task.title,
                "contents": task.contents,
                "input_date": task.input_date.strftime("%Y-%m-%d"),
                "due_date": task.due_date.strftime("%Y-%m-%d"),
            }
            for task in tasks
        ]
    )

@app.route("/", methods=["POST"])
def add_task():
    if "user_id" not in session:
        return redirect(url_for("login"))
    form = TaskForm()
    if form.validate_on_submit():
        title = form.title.data
        contents = form.contents.data

        # 한국 시간으로 현재 날짜 설정
        kst = pytz.timezone("Asia/Seoul")
        input_date = datetime.now(kst).date()

        due_date = form.due_date.data

        new_task = Task(
            title=title,
            contents=contents,
            input_date=input_date,
            due_date=due_date,
            user_id=session["user_id"],
        )
        db.session.add(new_task)
        db.session.commit()
        return redirect(url_for("index"))
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/edit/<int:task_id>", methods=["GET", "POST"])
def edit_task(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    task = Task.query.get_or_404(task_id)
    if task.user_id != session["user_id"]:
        flash("You are not authorized to edit this task.", "danger")
        return redirect(url_for("index"))
    form = TaskForm(obj=task)
    if request.method == "POST" and form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.commit()
        return redirect(url_for("index"))
    csrf_token = form.csrf_token._value()
    return render_template(
        "edit_task.html",
        form=form,
        task_id=task.id,
        csrf_token=csrf_token,
        task_title=task.title,
        task_contents=task.contents,
        task_input_date=task.input_date.strftime("%Y-%m-%d"),
        task_due_date=task.due_date.strftime("%Y-%m-%d"),
    )


@app.route("/delete/<int:task_id>")
def delete_task(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    task = Task.query.get_or_404(task_id)
    if task.user_id != session["user_id"]:
        flash("You are not authorized to delete this task.", "danger")
        return redirect(url_for("index"))
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for("index"))


@app.route("/admin")
def admin():
    if "user_id" not in session or not session.get("is_admin"):
        return redirect(url_for("login"))
    users = User.query.all()
    return render_template("admin.html", users=users)


if __name__ == "__main__":

    app.run(debug=True)
