__author__ = 'Dylan'

from django.conf.urls import url

from . import views

app_name = 'ebooks'

urlpatterns = [
    url(r'^login/$', views.login_user, name='login'),
    url(r'^register/$', views.register, name='register'),
    url(r'^$', views.index, name='index'),
]
