from flask_security import Security
from flask_security.forms import RegisterForm, Required
from wtforms import StringField
from blog import app



class ExtendedRegisterForm(RegisterForm):
    name = StringField('First Name', [Required()])
    second_name = StringField('Last Name', [Required()])

