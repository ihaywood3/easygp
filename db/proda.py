#!/usr/bin/python

"""
An interface to the web-based PROvider Direct Access (PRODA) system
of Medicare Australia
"""

import mechanize # available via PIP
import re

m = mechanize.Browser()

m.open("https://proda.humanservices.gov.au/prodalogin/pages/public/login.jsf?TAM_OP=login&USER")

m.select_form(name="loginFormAndStuff")
m['loginFormAndStuff:inputPassword'] = "Drc232crq838"
m['loginFormAndStuff:username'] = 'ihaywood'

m.submit()

m.select_form(nr=0)
m['otp.user.otp'] = raw_input("Emailed code")
m.submit()
print m.reply()

#m.open("https://www2.medicareaustralia.gov.au:5447/pcert/hpos/home.do")
#m.select_form(name="termsAndConditionsForm")
#m['action'] = "I agree"
#m.submit()

#m.follow_link(text_regex=re.compile("Claims"))
#m.follow_link(text_regex=re.compile("Make a new claim"))
#m.follow_link(text_regex=re.compile("Medicare Bulk Bill Webclaim"))

print m.read()