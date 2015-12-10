# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
#
# Also note: You'll have to insert the output of 'django-admin.py sqlcustom [app_label]'
# into your database.
from __future__ import unicode_literals

from django.db import models


class Author(models.Model):
    id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=45)
    last_name = models.CharField(max_length=45)
    middle_name = models.CharField(max_length=45, blank=True)
    bio = models.CharField(max_length=1000, blank=True)
    email = models.CharField(max_length=255, blank=True)

    class Meta:
        managed = False
        db_table = 'author'


class Category(models.Model):
    name = models.CharField(primary_key=True, max_length=45)
    description = models.CharField(max_length=1000, blank=True)

    class Meta:
        managed = False
        db_table = 'category'


class Book(models.Model):
    isbn = models.CharField(primary_key=True, max_length=20)
    title = models.CharField(max_length=100)
    pub_date = models.DateField()
    image = models.TextField(blank=True)
    edition = models.CharField(max_length=10, blank=True)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    publisher = models.ForeignKey('Publisher')
    categories = models.ManyToManyField(Category,
                                        through='BookHasCategory')
    authors = models.ManyToManyField(Author,
                                     through='BookHasAuthor')

    class Meta:
        managed = False
        db_table = 'books'


class BookHasAuthor(models.Model):
    books_isbn = models.ForeignKey(Book, db_column='books_isbn')
    author = models.ForeignKey(Author)

    class Meta:
        managed = False
        db_table = 'books_has_author'


class BookHasCategory(models.Model):
    books_isbn = models.ForeignKey(Book, db_column='books_isbn')
    category_name = models.ForeignKey('Category', db_column='category_name')

    class Meta:
        managed = False
        db_table = 'books_has_category'


class CartItem(models.Model):
    id = models.IntegerField(primary_key=True, auto_created=True)  # AutoField?
    discount = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    books_isbn = models.ForeignKey(Book, db_column='books_isbn')
    shopping_cart_transaction = models.ForeignKey('ShoppingCart')

    class Meta:
        managed = False
        db_table = 'cart_item'


class Payment(models.Model):
    id = models.IntegerField(primary_key=True, auto_created=True)  # AutoField?
    total_payment = models.DecimalField(max_digits=10, decimal_places=0)
    date_paid = models.DateTimeField()
    credit_card_number = models.CharField(max_length=100)
    cardholder_name = models.CharField(max_length=100, blank=True)
    cardholder_billing_address = models.CharField(max_length=1000, blank=True)
    cardholder_expiration = models.DateField(blank=True, null=True)
    shopping_cart_transaction = models.ForeignKey('ShoppingCart')

    class Meta:
        managed = False
        db_table = 'payments'


class Publisher(models.Model):
    id = models.AutoField(primary_key=True)
    # id = models.IntegerField(primary_key=True, auto_created=True)  # AutoField?
    name = models.CharField(max_length=100)
    address = models.CharField(max_length=1000, blank=True)

    class Meta:
        managed = False
        db_table = 'publisher'


class ShoppingCart(models.Model):
    transaction_id = models.IntegerField(primary_key=True, auto_created=True)
    date_created = models.DateTimeField()
    status = models.ForeignKey('Status')

    class Meta:
        managed = False
        db_table = 'shopping_cart'


class Status(models.Model):
    id = models.IntegerField(primary_key=True, auto_created=True)  # AutoField?
    name = models.CharField(max_length=45, blank=True)

    class Meta:
        managed = False
        db_table = 'status'


class User(models.Model):
    username = models.CharField(primary_key=True, max_length=20, )
    first_name = models.CharField(max_length=45, blank=True)
    last_name = models.CharField(max_length=45, blank=True)
    middle_name = models.CharField(max_length=45, blank=True)
    email = models.CharField(max_length=255)
    password = models.CharField(max_length=40)
    create_time = models.DateTimeField()
    address = models.CharField(max_length=100, blank=True)
    phone = models.CharField(max_length=45, blank=True)
    shopping_cart_transaction = models.ForeignKey(ShoppingCart, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user'
