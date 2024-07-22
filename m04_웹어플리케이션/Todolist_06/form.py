from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, DateField
from wtforms.validators import DataRequired


class TaskForm(FlaskForm):
    title = StringField("Title", validators=[DataRequired()])
    contents = TextAreaField("Contents", validators=[DataRequired()])
    due_date = DateField("Due Date", validators=[DataRequired()])


class LoginForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])


class RegistrationForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])