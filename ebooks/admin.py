__author__ = 'Dylan'
from ebooks.models import Book, Publisher, Category, Author
from django.contrib import admin


# class PublisherInline(admin.TabularInline):
#     model = Publisher
#
#
# class CategoryInline(admin.TabularInline):
#     model = Category
#
#
# class AuthorInline(admin.TabularInline):
#     model = Author
#
#
# class BookAdmin(admin.ModelAdmin):
#     inlines = [
#         PublisherInline,
#         CategoryInline,
#         AuthorInline
#     ]
#     list_display = ('isbn', 'title', 'pub_date', 'unit_price', 'publisher')
# admin.site.register(Book, BookAdmin)

# class BookInline(admin.StackedInline):
#     model = Book.authors.through
#
# class AuthorAdmin(admin.StackedInline):
#     model = Author
#
# class BooksAuthorsAdmin(admin.ModelAdmin):
#     inlines = [BookInline, AuthorAdmin]
#
# admin.site.register(Book, BooksAuthorsAdmin)


class BookAdmin(admin.ModelAdmin):
    list_display = ('isbn', 'title', 'pub_date', 'unit_price', 'publisher')


class AuthorAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name')


class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name']


class PublisherAdmin(admin.ModelAdmin):
    list_display = ['name']


admin.site.register(Book, BookAdmin)
admin.site.register(Author, AuthorAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Publisher, PublisherAdmin)
