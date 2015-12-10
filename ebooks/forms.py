from django import forms
from ebooks.models import User

__author__ = 'Dylan'


class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ('username', 'first_name', 'last_name', 'middle_name', 'email',
                  'password', 'address', 'phone')
