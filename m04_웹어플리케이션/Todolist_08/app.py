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
from flask_wtf.csrf import CSRFProtect  # Web Templates Form
from datetime import datetime
import pytz
from form import TaskForm, LoginForm, RegistrationForm
from models import db, Task, User
from form import UserForm, RegistrationForm, UpdateProfileForm
from werkzeug.security import generate_password_hash, check_password_hash
import pymysql
pymysql.install_as_MySQLdb()

app = Flask(__name__)
app.config.from_pyfile("config.py")

db.init_app(app)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)


@app.before_request
def create_admin():
    if not User.query.filter_by(username="admin").first():
        admin_user = User(username="admin", email="admin@example.com", is_admin=True)
        admin_user.set_password("admin_password")
        db.session.add(admin_user)
        db.session.commit()

@app.route("/task_ease_redirect")
def task_ease_redirect():
    if session.get('user_id'):
        return redirect(url_for('task_list'))
    else:
        return redirect(url_for('login'))

@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        # 이메일 중복 확인
        existing_user = User.query.filter_by(email=form.email.data).first()
        if existing_user:
            flash("Email already registered. Please use a different email.", "danger")
            return render_template("register.html", form=form)
        
        # 사용자 이름 중복 확인
        existing_user_username = User.query.filter_by(username=form.username.data).first()
        if existing_user_username:
            flash("Username already taken. Please choose a different username.", "danger")
            return render_template("register.html", form=form)
        
        new_user = User(
            username=form.username.data, email=form.email.data, is_admin=False
        )
        new_user.set_password(form.password.data)
        db.session.add(new_user)
        db.session.commit()
        # flash("You are now registered!", "success")
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
            # flash("Login successful!", "success")
            return redirect(url_for("task_list"))
        # flash("Invalid username or password.", "danger")
    return render_template("login.html", form=form)


@app.route("/logout")
def logout():
    session.clear()
    # flash("You have been logged out.", "success")
    return redirect(url_for("login"))


@app.route("/")
def index():
    if "user_id" not in session:
        return redirect(url_for("login"))
    form = TaskForm()
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/task_list")
def task_list():
    if "user_id" not in session:
        return redirect(url_for("login"))
    tasks = Task.query.filter_by(user_id=session["user_id"]).all()
    return render_template("task_list.html", tasks=tasks)


@app.route("/add_task", methods=["POST"])
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
        # flash("Task added successfully!", "success")
        return redirect(url_for("task_list"))
    csrf_token = form.csrf_token._value()
    return render_template("index.html", form=form, csrf_token=csrf_token)


@app.route("/edit/<int:task_id>", methods=["GET", "POST"])
def edit_task(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    task = Task.query.get_or_404(task_id)
    if task.user_id != session["user_id"]:
        # flash("You are not authorized to edit this task.", "danger")
        return redirect(url_for("index"))
    form = TaskForm(obj=task)
    if request.method == "POST" and form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data

        db.session.commit()
        # flash("Task edited successfully!", "success")
        return redirect(url_for("task_list"))
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
        # flash("You are not authorized to delete this task.", "danger")
        return redirect(url_for("index"))
    db.session.delete(task)
    db.session.commit()
    # flash("Task deleted successfully!", "success")
    return redirect(url_for("task_list"))


@app.route("/profile", methods=["GET", "POST"])
def profile():
    if "user_id" not in session:
        return redirect(url_for("login"))

    user = db.session.get(User, session["user_id"])
    form = UpdateProfileForm(obj=user)
    if form.validate_on_submit():
        user.username = form.username.data
        user.email = form.email.data
        if form.password.data:
            user.set_password(form.password.data)
        db.session.commit()
        # flash("Profile updated successfully!", "success")
        return redirect(url_for("profile"))

    return render_template("profile.html", form=form)


@app.route("/delete_account", methods=["POST"])
def delete_account():
    if "user_id" not in session:
        return redirect(url_for("login"))

    user = db.session.get(User, session["user_id"])
    db.session.delete(user)
    db.session.commit()
    session.clear()
    flash("Account deleted successfully!", "success")
    return redirect(url_for("register"))


@app.route("/admin/delete/<int:user_id>")
def admin_delete_user(user_id):
    if "user_id" not in session or not session.get("is_admin"):
        return redirect(url_for("login"))
    user = db.session.get(User, user_id) or abort(404)
    db.session.delete(user)
    db.session.commit()
    flash("User deleted successfully!", "success")
    return redirect(url_for("admin"))


@app.route("/admin")
def admin():
    if "user_id" not in session or not session.get("is_admin"):
        return redirect(url_for("login"))
    users = User.query.all()
    return render_template("admin.html", users=users)


@app.route("/admin/add", methods=["GET", "POST"])
def add_user():
    if "user_id" not in session or not session.get("is_admin"):
        return redirect(url_for("login"))
    form = UserForm()
    if form.validate_on_submit():
        # 이메일 중복 확인
        existing_user = User.query.filter_by(email=form.email.data).first()
        if existing_user:
            flash("Email already registered. Please use a different email.", "danger")
            return render_template("user_form.html", form=form, title="Add New User")
        new_user = User(
            username=form.username.data,
            email=form.email.data,
            is_admin=form.is_admin.data,
        )
        new_user.set_password(form.password.data)
        db.session.add(new_user)
        db.session.commit()
        flash("User added successfully!", "success")
        return redirect(url_for("admin"))
    return render_template("user_form.html", form=form, title="Add New User")


if __name__ == "__main__":
    app.run(debug=True)
