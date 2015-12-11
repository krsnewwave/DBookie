from django.http import HttpResponse
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404
from ebooks.forms import UserForm
from ebooks.models import Book

__author__ = 'Dylan'

def register(request):
    """Registers accounts"""
    context = RequestContext(request)
    registered = False

    # POST method
    if request.method == 'POST':
        user_form = UserForm(data=request.POST)
        if user_form.is_valid():
            user = user_form.save()
            # user.set_password(user.password)
            user.save()

            registered = True

        else:
            print(user_form.errors)

    # if GET, then we render
    else:
        user_form = UserForm()

    return render_to_response('ebooks/register.html',
                              {'user_form': user_form, 'registered': registered}, context)


def index(request):
    try:
        books = Book.objects.all()
    except ObjectDoesNotExist:
        raise Http404
    return render_to_response('ebooks/book_list.html',{'books':books})
