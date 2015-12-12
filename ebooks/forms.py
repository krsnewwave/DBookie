from django import forms
from django.contrib.auth.models import User
from ebooks.models import Customer

__author__ = 'Dylan'


class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['username', 'password', 'email', 'first_name', 'last_name']


class CustomerForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ('middle_name', 'address', 'phone')
