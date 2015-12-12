from django.contrib.auth.models import User

__author__ = 'Dylan'
from ebooks.models import Book, Publisher, Category, Author, Status, \
    CartItem, Customer, ShoppingCart
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin


class BookAdmin(admin.ModelAdmin):
    list_display = ('isbn', 'title', 'pub_date', 'unit_price', 'publisher')


class AuthorAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name')


class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name']


class PublisherAdmin(admin.ModelAdmin):
    list_display = ['name']


class CartItemInline(admin.StackedInline):
    model = CartItem
    extra = 3

class ShoppingCartAdmin(admin.ModelAdmin):
    list_display = ['transaction_id', 'date_created', 'status']
    inlines = [CartItemInline]


class StatusAdmin(admin.ModelAdmin):
    list_display = ['name']


class CustomerInline(admin.StackedInline):
    model = Customer
    can_delete = False
    verbose_name_plural = 'customers'


class UserAdmin(BaseUserAdmin):
    inlines = [CustomerInline, ]


admin.site.register(Book, BookAdmin)
admin.site.register(Author, AuthorAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Publisher, PublisherAdmin)

admin.site.register(Status, StatusAdmin)
admin.site.register(ShoppingCart, ShoppingCartAdmin)

admin.site.unregister(User)
admin.site.register(User, UserAdmin)
