from flask import (
    Flask, request, jsonify, render_template, redirect, url_for, session, flash
)
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_wtf.csrf import CSRFProtect
from datetime import datetime
import pytz
from form import TaskForm, LoginForm, RegistrationForm
from models import db, Task, User

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///경로/파일명.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)

# 데이터베이스 초기화
db.create_all()

migrate = Migrate(app, db)
csrf = CSRFProtect(app)

@app.before_request
def create_admin():
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
        existing_user = User.query.filter_by(username=form.username.data).first()
        if existing_user:
            flash("Username already exists. Please choose a different username.", "danger")
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

if __name__ == "__main__":
    app.run(debug=True)
