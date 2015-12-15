from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response, render
from django.template import RequestContext
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404
from django.views.generic import CreateView, DetailView
from ebooks.forms import CustomerForm, UserForm, NewPaymentForm
from ebooks.models import Book, Customer, ShoppingCart, CartItem, Status, Payment, BookHasAuthor, Author, BookHasCategory

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
        # get all shopping carts with this user
        bought_items = ShoppingCart.objects.filter(shopping_cart_customer_id=request.user.id)
        # remove the cart still in the customer's current cart
        transactions = [fc for fc in bought_items
                        if fc.transaction_id != request.user.customer.shopping_cart_transaction_id]
        bought_isbns = []
        for transaction in transactions:
            for item in transaction.cartitem_set.all():
                bought_isbns.append(item.books_isbn)

        # provide also the user's shopping cart: the list of item isbns
        # user_id = request.user.id
        # cart = Customer.objects.get(pk=user_id).shopping_cart_transaction
        cart = request.user.customer.shopping_cart_transaction

        if not cart or not bought_isbns:
		    return render(request, 'ebooks/book_list.html', {'books': books})
        else:
            items = [item.books_isbn for item in cart.cartitem_set.all()]
            return render(request, 'ebooks/book_list.html', {'books': books, 'items': items, 'bought': bought_isbns})

    except ObjectDoesNotExist:
        raise Http404


@login_required
def view_cart(request):
    # get the user
    user_id = request.user.id
    # get the customer
    customer = Customer.objects.get(pk=user_id)
    # get its shopping cart
    cart = customer.shopping_cart_transaction
    books = []
    cart_items = []
    sum_price = 0
    if not cart:
        return render(request, 'ebooks/my_cart.html',
                      {'cart': [], 'sum_price': 0})
    else:
        for item in cart.cartitem_set.all():
            isbn = item.books_isbn_id
            book = Book.objects.get(pk=isbn)
            books.append(book)
            if item.discount is not None:
                sum_price += book.unit_price * item.discount
            else:
                sum_price += book.unit_price
            cart_items.append(item)
        return render(request, 'ebooks/my_cart.html',
                      {'cart': cart_items, 'sum_price': sum_price})


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
        cart = ShoppingCart.objects.create(status=status, shopping_cart_customer=customer)
        customer.shopping_cart_transaction_id = cart.transaction_id
        customer.save(force_update=True)

    # add the new book into a cart item
    book = Book.objects.get(pk=isbn)
    CartItem.objects.create(books_isbn=book, shopping_cart_transaction=cart)

    return HttpResponseRedirect('/ebooks/')


@login_required
def view_purchases(request):
    # get the user
    user_id = request.user.id
    # get all shopping carts with this user
    carts = ShoppingCart.objects.filter(shopping_cart_customer_id=user_id)
    # remove the cart still in the customer's current cart
    carts = [fc for fc in carts if fc.transaction_id != request.user.customer.shopping_cart_transaction_id]

    # get all the books in all these carts
    books = []
    for cart in carts:
        for item in cart.cartitem_set.all():
            isbn = item.books_isbn_id
            book = Book.objects.get(pk=isbn)
            books.append(book)

    return render(request, 'ebooks/purchases.html', {'books': books})


class PaymentNew(CreateView):
    model = Payment
    # fields = ['credit_card_number', 'cardholder_name', 'cardholder_billing_address',
    #           'cardholder_expiration']
    form_class = NewPaymentForm
    template_name = 'ebooks/billing.html'

    def form_valid(self, form):
        payment = form.save(commit=False)
        # get the user's shopping cart
        user_id = self.request.user.id
        # get the customer's cart ID and link that into the current payment
        customer = Customer.objects.get(pk=user_id)
        cart_id = customer.shopping_cart_transaction.transaction_id
        payment.shopping_cart_transaction_id = cart_id
        # get the total payment in the shopping cart
        sum_price = 0
        for item in customer.shopping_cart_transaction.cartitem_set.all():
            isbn = item.books_isbn_id
            book = Book.objects.get(pk=isbn)
            if item.discount is not None:
                sum_price += book.unit_price * item.discount
            else:
                sum_price += book.unit_price

        # then empty the shopping cart of the customer
        customer.shopping_cart_transaction = None
        customer.save()

        payment.total_payment = sum_price
        payment.save()
        return HttpResponseRedirect('/ebooks/my_purchases')

def book_details(request, isbn):
    # get the book
    book = Book.objects.get(pk=isbn)

    #get the author of the book
    bookHasAuthors = BookHasAuthor.objects.get(books_isbn=isbn)

    #get the category of the book
    bookHasCategory = BookHasCategory.objects.get(books_isbn=isbn)

    book_data = {
        "isbn" : book.isbn,
        "title" : book.title,
        "author" : bookHasAuthors.author,
        "image" : book.image,
        "publisher" : book.publisher.name,
        "pub_date":book.pub_date,
        "categories" : bookHasCategory.category_name
    }



    return render(request, 'ebooks/book_details.html', {'book': book_data})
