from django.contrib.auth import authenticate, login
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404
from ebooks.forms import CustomerForm, UserForm
from ebooks.models import Book

__author__ = 'Dylan'


def register(request):
    """Registers accounts"""
    context = RequestContext(request)
    registered = False

    # POST method
    if request.method == 'POST':
        user_form = UserForm(data=request.POST)
        customer_form = CustomerForm(data=request.POST)
        if user_form.is_valid() and customer_form.is_valid():
            user = user_form.save()
            # user_form.password = make_password(user_form.cleaned_data['password'])
            customer = customer_form.save(commit=False)
            customer.user = user
            customer.save()
            user.set_password(user.password)
            user.save()

            registered = True

        else:
            print(user_form.errors)

    # if GET, then we render
    else:
        user_form = UserForm()
        customer_form = CustomerForm()

    return render_to_response('ebooks/register.html',
                              {'user_form': user_form,
                               'customer_form': customer_form,
                               'registered': registered}, context)


def login_user(request):
    """Logs in the user"""

    context = RequestContext(request)
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(username=username,
                            password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                state = "Logged in."
                return HttpResponseRedirect('/ebooks/')
            else:
                state = "Account not active. Contact admin."
        else:
            state = "Credentials invalid."
        return render_to_response('ebooks/auth.html', {'state': state, 'username': username}, context)
    else:
        return render_to_response('ebooks/auth.html', {'state': "Please login!", 'username': ""}, context)


def index(request):
    try:
        books = Book.objects.all()
    except ObjectDoesNotExist:
        raise Http404
    return render_to_response('ebooks/book_list.html', {'books': books})
