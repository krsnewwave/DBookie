__author__ = 'Dylan'

from django.conf.urls import url

from . import views

app_name = 'ebooks'

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^login/$', views.login_user, name='login'),
    url(r'^logout/$', views.user_logout, name='logout'),
    url(r'^register/$', views.register, name='register'),
    url(r'^cart/(?P<isbn>[A-z0-9\-]+)/$', views.add_to_cart, name='add_to_cart'),

]
