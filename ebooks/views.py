from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response, render
from django.template import RequestContext
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404
from ebooks.forms import CustomerForm, UserForm
from ebooks.models import Book, Customer, ShoppingCart, CartItem, Status

UNPAID_STATUS = 'Unpaid'

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


@login_required
def user_logout(request):
    """Defines logout request"""
    logout(request)
    return HttpResponseRedirect('/ebooks/')


@login_required(login_url='/ebooks/login/')
def index(request):
    try:
        books = Book.objects.all()

        # provide also the user's shopping cart: the list of item isbns
        # user_id = request.user.id
        # cart = Customer.objects.get(pk=user_id).shopping_cart_transaction
        cart = request.user.customer.shopping_cart_transaction

        if cart is not None:
            items = [item.books_isbn for item in cart.cartitem_set.all()]
            return render(request, 'ebooks/book_list.html', {'books': books, 'items': items})
        else:
            return render(request, 'ebooks/book_list.html', {'books': books})

    except ObjectDoesNotExist:
        raise Http404


@login_required
def add_to_cart(request, isbn):
    # get the user
    user_id = request.user.id
    # get the customer
    customer = Customer.objects.get(pk=user_id)
    # get its shopping cart
    cart = customer.shopping_cart_transaction

    # if the shopping cart is empty, make a new one
    if cart is None:
        cart = ShoppingCart()
        # get the status 'Unpaid'
        qs = Status.objects.filter(name__iexact=UNPAID_STATUS)
        # if not available, make it
        if not qs.exists():
            status = Status()
            status.name = UNPAID_STATUS
            status.save()
        else:
            status = qs[0]

        # save the cart
        cart = ShoppingCart.objects.create(status=status)
        customer.shopping_cart_transaction_id = cart.transaction_id
        customer.save(force_update=True)

    # add the new book into a cart item
    book = Book.objects.get(pk=isbn)
    CartItem.objects.create(books_isbn=book, shopping_cart_transaction=cart)

    return HttpResponseRedirect('/ebooks/')
    # return render(request, 'ebooks/book_list.html', {'books': request.books, })
