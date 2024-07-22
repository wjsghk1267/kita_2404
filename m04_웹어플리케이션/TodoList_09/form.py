from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    PasswordField,
    TextAreaField,
    DateField,
    BooleanField,
    SubmitField,
)
from wtforms.validators import DataRequired, Email, EqualTo, Optional


class TaskForm(FlaskForm):
    title = StringField("Title", validators=[DataRequired()])
    contents = TextAreaField("Contents", validators=[DataRequired()])
    due_date = DateField("Due Date", validators=[DataRequired()])
    completion_date = DateField(
        "Completion Date", validators=[Optional()]
        )
    submit = SubmitField("submit")
    


class LoginForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    password = PasswordField("Password", validators=[DataRequired()])
    submit = SubmitField("submit")

class RegistrationForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    email = StringField("Email", validators=[DataRequired(), Email()])
    password = PasswordField("Password", validators=[DataRequired()])
    confirm_password = PasswordField(
        "Confirm Password", validators=[DataRequired(), EqualTo("password")]
    )
    submit = SubmitField("Register")


class UserForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    email = StringField("Email", validators=[DataRequired(), Email()])
    password = PasswordField("Password", validators=[DataRequired()])
    confirm_password = PasswordField(
        "Confirm Password", validators=[DataRequired(), EqualTo("password")]
    )
    is_admin = BooleanField("Admin")
    submit = SubmitField("Submit")


class UpdateProfileForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired()])
    email = StringField("Email", validators=[DataRequired(), Email()])
    password = PasswordField("New Password")
    confirm_password = PasswordField(
        "Confirm Password", validators=[EqualTo("password")]
    )
    submit = SubmitField("Update")
