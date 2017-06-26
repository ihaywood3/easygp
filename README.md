Pre-requisites
==============

- postgresql, version 8.4 or greater
- gambas, version 3.5 or later
- ruby (only if you want to compile the docs
- git revision contorl system (to download the code form this website)

Instllation
=============

1) Download via git:

     $ git clone htpps://github.com/ihaywood3/easygp
 

2) Compile the help files, these can only be run from within EasyGP at
   the current time.
   
     $  cd easygp/trunk/client/help/
     $  ruby basicdoc.rb easygp.bd
 
 3) Refer to db/README for instructions on how to set up the database.
 
 4) Open gambas3 and load as a project the base library (base/ in the easygp directory)
    Go to Project / Make / Executable... in the Gambas menus and compile it. Remember where you saved this.

 5) Run Gambas3 again and select your project as the client/ directory under this directory. 
    Go to Project / Properties... / Libraries and select Add.., then select the library executable
	you created in step 4.
    
6)  Then run the project (Debug / Run or F5) If it complains sure that the startup file is
    client/startup/modStartup.module (which should be the default).

7)  Log in with the user and password you set when creating the database
     back in step 3), the client should now start a wizard to allow you 
     to set the practice organisation and other details.
 

     
   
 
