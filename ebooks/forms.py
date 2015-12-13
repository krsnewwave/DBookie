from django import forms
from django.contrib.auth.models import User
from ebooks.models import Customer, Payment

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


class NewPaymentForm(forms.ModelForm):
    cardholder_expiration = forms.DateField(widget=forms.SelectDateWidget)
    credit_card_number = forms.CharField(widget=forms.PasswordInput)

    class Meta:
        model = Payment
        fields = ('cardholder_name', 'credit_card_number',
                  'cardholder_billing_address', 'cardholder_expiration')
