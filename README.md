At present this version of EasyGP is only intended for developers
though you may try it if you like - but it is not at a point where
you will be able keep your medical records accurately or safely so
should not on any account be used for that purpose.

Main developers:

Dr. Richard Terry <rterry@pacific.net.au>
Dr. Ian Haywood <ihaywood3@gmail.com>

pre-requisites
==============

- postgresql, version 8.4 or greater
- gambas, version 3.0 (i.e. the developement svn branch)
- ruby (if you want to compile the docs)

quick-install
=============

1) Download the svn to a directory of your choice:

    user ~  $ mkdir /home/user/easygp
    user ~  $ cd /home/user/easygp
    user ~  easygp$ svn checkout svn://ozdocit.org/easygp/trunk
 
 you will see a whole lot of files checked out for example:
 
    A    trunk/debian/easygp-server.install                                                                                                                                  
    A    trunk/debian/changelog                                                                                                                                              
    A    trunk/debian/copyright                                                                                                                                              
    A    trunk/debian/easygp-client.install                                                                                                                                  
    A    trunk/debian/make-server.sh        
    Checked out revision xyz.

2) Compile the help files, these can only be run from within EasyGP at
   the current time.
   
    user ~ easygp  $  cd trunk/client/help/
    user ~ easygp/trunk/client/help  $  ruby basicdoc.rb easygp.bd
    user ~ easygp/trunk/client/help  $
 
 3) Refer to db/README for instriuctions on how to set up the database

 4) Run Gambas3 and select your project as the client/ directory under this directory,
    and from within the IDE make sure that the startup file is
    client/startup/modStartup.module (which should be the default), 
    then run the project

 5)  Log in with the user and passsword you set when creating the database
     back in step 3), the client should now start a wizard to allow you 
     to set the practice organisation
 

     
   
 
