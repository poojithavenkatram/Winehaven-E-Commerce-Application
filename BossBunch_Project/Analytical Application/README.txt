Team Boss Bunch - Cellar Insights - Winehaven Analytics (Analytical Application)


Link to the Screen Recording of the Demo :
    
    1. Analytical App - https://drive.google.com/file/d/1FkS5aZmHDSWNgG2MThfatZbJDA96Y_xI/view?usp=share_link



Steps on how to run the Application :

   1. Open up a terminal window at the directory you have the files.
   2. Once that is done, type this:
       
           ipython cellar_insights.py
   
   3. Press Enter and the application should be up and running. At this point, you will be seeing a Login Window.
   4. Use the following credentials to Login and play around with the application.
       
           Username: admin1
           Password: password1



Details about the files in the Analytical Application folder :

    1. Main File: cellar_insights.py
       - This is the file you will be running in the terminal.
       - Contains most of the classes required for the application to function.
    2. Dashboard2.py, Dashboard5, WineAnalysisDashboard.py, RevenueAnalysis.py
       - These are imported in cellar_insights.py
    3. DATA225utils.py
       - Python database utilities file
    4. bossbunch_db.ini
       - Config file that connects to the database (bossbunch_db) on the server provided to us.
    5. bossbunch_wh.ini
       - Config file that connects to the warehouse (bossbunch_wh) on the server provided to us.
    6. Images
       - arrow-down.png - used for comboboxes
       - banner.png - used in the Home Page
       - cellarinsights_logo.png - logo image used in the Login Page
    6. Star-Schema.png
       - Star Schema of the bossbunch_wh database (our operational database)
    7. ETLs folder
       - Contains all ETLs and edits/alters/updates performed on the database.
       - You can go through these files if needed.