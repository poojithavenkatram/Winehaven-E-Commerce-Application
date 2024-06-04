Team Boss Bunch - Winehaven E-Commerce App (Operational Application)


Links to the Screen Recordings of the Demos :
    
    1. Login & SignUp   - https://drive.google.com/file/d/1AUq4PH0SrC0biTLrYJm-d5YGrc2Gk1K4/view?usp=share_link
    2. Main Application - https://drive.google.com/file/d/1J-Et2TWn8UisXzJVcFLBHfHvJ0dlqFkc/view?usp=share_link
    3. Cart & Checkout  - https://drive.google.com/file/d/1v6GjMUVgRzny3QtUMS1XfT-A5tZ_e6gA/view?usp=share_link
    
    

Steps on how to run the Application :

    1. Open up a terminal window at the directory you have the files.
    2. Once that is done, type this:
       
           ipython winehaven.py
   
    3. Press Enter and the application should be up and running. At this point, you will be seeing a Login Window.
    4. You can either Sign Up as a New User or use the following credentials to Login and play around with the application.
       
           Username: CoolCat21
           Password: password141



Details about the files in the Operational Application folder :

    1. Main File: winehaven.py
       - This is the file you will be running in the terminal.
       - Contains most of the classes required for the application to function.
    2. Checkout.py, Customisation.py, Cart.py
       - These are imported in winehaven.py
    3. DATA225utils.py
       - Python database utilities file
    4. bossbunch_db.ini
       - Config file that connects to the database (bossbunch_db) on the server provided to us.
    5. Images
       - arrow-down.png - used for comboboxes
       - banner.png - used in the Home Page
       - winehaven_logo.png - logo image used in the Login Page
       - images folder - bottle label images (fetched when customisation is opted)
    6. ER-Diagram.png
       - Entity Relationship Diagram of the bossbunch_db database (our operational database for the winehaven e-commerce app)
    7. Relational-Schema.png
       - Relational Schema of the bossbunch_db database (our operational database)
    8. ETLs, DDL folder
       - Contains all ETLs and edits/alters/updates performed on the database.
       - You can go through these files if needed.