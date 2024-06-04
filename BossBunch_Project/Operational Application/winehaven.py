# Import necessary Qt libraries
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QVBoxLayout, QHBoxLayout, QCheckBox, QMessageBox, QListWidget, QListWidgetItem, QScrollArea, QDialog, QInputDialog, QSpacerItem, QSizePolicy, QTableWidget, QTableWidgetItem, QAbstractItemView, QHeaderView, QFormLayout, QComboBox, QGroupBox, QDateEdit, QTextEdit, QGridLayout, QDoubleSpinBox, QSpinBox, QMainWindow, QTabWidget,  QTimeEdit, QCalendarWidget
from PyQt5.QtGui import QPixmap, QFont, QPalette, QPainter, QTransform, QImage, QColor
from PyQt5.QtCore import Qt, QDate, QSettings, QRect, QPropertyAnimation, QSize
from datetime import date, datetime
from datetime import datetime
import time
import pymysql
import random
import urllib.request
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import Qt, QTime
from datetime import datetime
from DATA225utils import make_connection
from Customization import *
from Cart import *

# Create a connection to the database using the config file
conn = make_connection(config_file='bossbunch_db.ini')
cursor = conn.cursor()
custid=0
wine=""

class Login(QWidget):
    def __init__(self):
        super().__init__()

        # Set the title and window properties
        self.setWindowTitle("Winehaven Login")
        self.setFixedSize(500, 620)

        # Create a vertical layout to hold the logo, fields, and buttons
        layout = QVBoxLayout()

        # Add the Winehaven logo to the top of the page
        self.logo = QLabel(self)
        self.logo.setPixmap(QPixmap("winehaven_logo.png"))
        self.logo.setAlignment(Qt.AlignCenter)
        
        # Add some space between the logo and the username/password fields
        spacer_item = QSpacerItem(20, 0, QSizePolicy.Minimum, QSizePolicy.Expanding)

        # Add the username and password fields to a horizontal layout
        username_layout = QHBoxLayout()
        self.username_label = QLabel(self)
        self.username_label.setText("Username:")
        self.username_field = QLineEdit(self)
        self.username_field.setPlaceholderText("Enter your username")
        self.username_field.setFixedWidth(200)
        spacer = QSpacerItem(40, 20, QSizePolicy.Expanding, QSizePolicy.Minimum)
        username_layout.addItem(spacer)
        username_layout.addWidget(self.username_label)
        username_layout.addWidget(self.username_field)
        username_layout.addItem(spacer)

        password_layout = QHBoxLayout()
        self.password_label = QLabel(self)
        self.password_label.setText("Password:")
        self.password_field = QLineEdit(self)
        self.password_field.setPlaceholderText("Enter your password")
        self.password_field.setEchoMode(QLineEdit.Password)
        self.password_field.setFixedWidth(200)
        spacer = QSpacerItem(40, 20, QSizePolicy.Expanding, QSizePolicy.Minimum)
        password_layout.addItem(spacer)
        password_layout.addWidget(self.password_label)
        password_layout.addWidget(self.password_field)
        password_layout.addItem(spacer)

        # Add the sign-in button, remember me checkbox, and forgot password button to a horizontal layout
        buttons_layout = QHBoxLayout()
        self.signin_button = QPushButton(self)
        self.signin_button.setText("Sign In")
        self.signin_button.clicked.connect(self.login)

        self.remember_me_checkbox = QCheckBox("Remember me", self)
        self.remember_me_checkbox.setText("Remember me")
        self.remember_me_checkbox.clicked.connect(self.update_remember_me)

        self.forgot_password = QPushButton(self)
        self.forgot_password.setText("Forgot Password")
        self.forgot_password.clicked.connect(lambda: self.reset_password())
        
        self.signin_button.setFixedWidth(120)
        self.forgot_password.setFixedWidth(150)
        
        # Set the stylesheet for the sign-in button
        self.signin_button.setStyleSheet(
            "QPushButton {"
            "   font-size: 14px;"
            "   background-color: #2c3e50;"
            "   color: #fff;"
            "   border: none;"
            "   border-radius: 4px;"
            "   padding: 8px 16px;"
            "}"
            "QPushButton:hover {"
            "   background-color: #34495e;"
            "}"
        )

        # Set the stylesheet for the remember me checkbox
        self.remember_me_checkbox.setStyleSheet(
            "QCheckBox {"
            "   font-size: 14px;"
            "   color: #34495e;"
            "}"
            "QCheckBox::indicator {"
            "   width: 20px;"
            "   height: 20px;"
            "}"
        )

        # Set the stylesheet for the forgot password button
        self.forgot_password.setStyleSheet(
            "QPushButton {"
            "   font-size: 14px;"
            "   color: #2980b9;"
            "   border: none;"
            "   background-color: transparent;"
            "   text-decoration: underline;"
            "}"
            "QPushButton:hover {"
            "   color: #2c3e50;"
            "}"
        )

        # Load the saved username and password, if they exist
        self.username = ""
        self.password = ""
        self.login_counter = 0
        self.remember_me = False
        settings = QSettings("WineHaven", "Login")
        if settings.contains("remember_me"):
            self.remember_me = settings.value("remember_me", False, bool)
            self.remember_me_checkbox.setChecked(self.remember_me)
            if self.remember_me:
                self.username = settings.value("username", "")
                self.password = settings.value("password", "")
                self.login_counter = settings.value("login_counter", 0, int)
                self.username_field.setText(self.username)
                self.password_field.setText(self.password)

        buttons_layout.addWidget(self.signin_button)
        buttons_layout.addWidget(self.remember_me_checkbox)
        buttons_layout.addWidget(self.forgot_password)
        
        # Set the alignment of the buttons layout to center
        buttons_layout.setAlignment(Qt.AlignCenter)

        # Add a new horizontal layout for the sign up button
        signup_layout = QHBoxLayout()
        self.signup_button = QPushButton(self)
        self.signup_button.setText("Sign Up")
        self.signup_button.clicked.connect(lambda: self.show_signup())
        self.signup_button.setFixedWidth(100)
        self.signup_button.setStyleSheet(
            "background-color: green; border: none; padding: 8px 16px; font-size: 14px; font-weight: bold; color: #FFFFFF;"
        )
        signup_layout.addWidget(self.signup_button)

        # Add the buttons layouts to the vertical layout
        layout.addWidget(self.logo)
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addLayout(username_layout)
        layout.addLayout(password_layout)
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addLayout(buttons_layout)
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addLayout(signup_layout) # Add the signup layout

        # Add the security notice
        self.security_notice = QLabel(self)
        self.security_notice.setText("Your security is important to us.\n Please contact us if you have any questions.\n\n© 2023 WineHaven. All rights reserved.")
        self.security_notice.setAlignment(Qt.AlignCenter)
        layout.addWidget(self.security_notice)

        # Set the layout for the QWidget
        self.setLayout(layout)

        # Set the stretch factor of the logo layout to 0
        layout.setStretch(0, 0)
        
    def update_remember_me(self):
        self.remember_me = self.remember_me_checkbox.isChecked()
        settings = QSettings("WineHaven", "Login")
        settings.setValue("remember_me", self.remember_me)
        if not self.remember_me:
            settings.remove("username")
            settings.remove("password")
            settings.remove("login_counter")

    def login(self):
        self.username = self.username_field.text()
        self.password = self.password_field.text()

        query = "SELECT * FROM Users WHERE Username=%s AND Password=%s"

        cursor.execute(query, (self.username, self.password))
        result = cursor.fetchone()

        if result is not None:
            customer_id = result[2]

            # Save the username and password if "Remember Me" is checked
            if self.remember_me:
                settings = QSettings("WineHaven", "Login")
                settings.setValue("username", self.username)
                settings.setValue("password", self.password)
            else: # Delete the saved username and password if "Remember Me" is unchecked
                settings = QSettings("WineHaven", "Login")
                settings.remove("username")
                settings.remove("password")

            # Increment login counter
            self.login_counter += 1

            # If login counter reaches 2, reset "Remember Me" checkbox and counter
            if self.login_counter == 2:
                self.remember_me_checkbox.setChecked(False)
                self.login_counter = 0

            # Close the login page and open the home page
            self.close()

            home_page = HomePage(self.username, customer_id)
            home_page.show()
            home_page.exec_()
        else:
            QMessageBox.warning(self, "Error", "Invalid username or password.", QMessageBox.Ok)

    def show_signup(self):
        conn = make_connection(config_file='bossbunch_db.ini')
        sign_up_page = SignUp(conn)
        sign_up_page.show()
        sign_up_page.exec_()
        sign_up_page.close()
            
    def reset_password(self):
        # Get the username from the username field
        username = self.username_field.text()

        # Retrieve the security question and answer for the user
        query = "SELECT SecurityQuestion, SecurityAnswer FROM Users WHERE Username=%s"
        cursor.execute(query, (username,))
        result = cursor.fetchone()

        if result is not None:
            # Prompt the user to answer the security question
            security_question, security_answer = result
            answer, ok = QInputDialog.getText(self, "Security Question", security_question)

            # If the user entered the correct answer, allow them to reset their password
            if ok and answer == security_answer:
                new_password, ok = QInputDialog.getText(self, "New Password", "Enter your new password", QLineEdit.Password)

                # Update the user's password in the database
                if ok:
                    update_query = "UPDATE Users SET Password=%s WHERE Username=%s"
                    cursor.execute(update_query, (new_password, username))
                    conn.commit()

                    QMessageBox.information(self, "Password Reset", "Your password has been successfully reset.", QMessageBox.Ok)

                    # Return to the login page
                    self.login()
            else:
                QMessageBox.warning(self, "Security Question", "Incorrect answer. Please try again.", QMessageBox.Ok)
                # Return to the login page
                self.login()
        else:
            QMessageBox.warning(self, "Error", "Username not found.", QMessageBox.Ok)
            # Return to the login page
            self.login()

class SignUp(QDialog):
    def __init__(self, conn):
        super().__init__()
        self.conn = conn
        
        # Set the title and window properties
        self.setWindowTitle("Winehaven Sign Up")
        self.setFixedSize(520, 720)

        # Create a vertical layout to hold the fields and buttons
        main_layout = QVBoxLayout()

        # Add the instructions label to the top of the page
        self.instructions_label = QLabel(self)
        self.instructions_label.setText("Thanks for choosing to wine with us!\nPlease fill out the form below to create a new account.")
        self.instructions_label.setAlignment(Qt.AlignCenter)

        # Set the font size to 20
        font = QFont()
        font.setPointSize(16)
        self.instructions_label.setFont(font)

        main_layout.addWidget(self.instructions_label)

        # Create a group box for personal details
        personal_box = QGroupBox("Personal Details")
        personal_layout = QFormLayout()
        personal_box.setStyleSheet("QGroupBox::title {font-size: 22px;}")
        personal_box.setFixedSize(452, 130)

        self.first_name_label = QLabel(self)
        self.first_name_label.setText("First Name:")
        self.first_name_field = QLineEdit(self)
        self.first_name_field.setPlaceholderText("Enter your First Name")
        self.first_name_field.setFixedWidth(300)
        personal_layout.addRow(self.first_name_label, self.first_name_field)

        self.last_name_label = QLabel(self)
        self.last_name_label.setText("Last Name:")
        self.last_name_field = QLineEdit(self)
        self.last_name_field.setPlaceholderText("Enter your Last Name")
        self.last_name_field.setFixedWidth(300)
        personal_layout.addRow(self.last_name_label, self.last_name_field)

        self.birthdate_label = QLabel(self)
        self.birthdate_label.setText("Birth Date:")
        self.birthdate_field = QDateEdit(self)
        self.birthdate_field.setCalendarPopup(True)
        self.birthdate_field.setDate(QDate.currentDate())
        self.birthdate_field.setFixedWidth(300)
        personal_layout.addRow(self.birthdate_label, self.birthdate_field)

        personal_box.setLayout(personal_layout)
        
        # Create a group box for account details
        account_box = QGroupBox("Account Details")
        account_layout = QFormLayout()
        account_box.setStyleSheet("QGroupBox::title {font-size: 22px;}")
        account_box.setFixedSize(452, 180)

        self.username_label = QLabel(self)
        self.username_label.setText("Username:")
        self.username_field = QLineEdit(self)
        self.username_field.setPlaceholderText("Enter username")
        self.username_field.setFixedWidth(300)
        account_layout.addRow(self.username_label, self.username_field)

        self.password_label = QLabel(self)
        self.password_label.setText("Password:")
        self.password_field = QLineEdit(self)
        self.password_field.setPlaceholderText("Enter password")
        self.password_field.setEchoMode(QLineEdit.Password)
        self.password_field.setFixedWidth(300)
        account_layout.addRow(self.password_label, self.password_field)

        self.confirm_password_label = QLabel(self) # Note the corrected variable name
        self.confirm_password_label.setText("Confirm Password:")
        self.confirm_password_field = QLineEdit(self)
        self.confirm_password_field.setPlaceholderText("Enter password again")
        self.confirm_password_field.setEchoMode(QLineEdit.Password)
        self.confirm_password_field.setFixedWidth(300)
        account_layout.addRow(self.confirm_password_label, self.confirm_password_field)
        
        self.security_question_label = QLabel(self)
        self.security_question_label.setText("Security Question:")
        self.security_question_field = QComboBox(self)
        self.security_question_field.addItems(get_questions())
        self.security_question_field.setFixedWidth(300)
        account_layout.addRow(self.security_question_label, self.security_question_field)
        
        self.security_answer_label = QLabel(self)
        self.security_answer_label.setText("Securty Answer:")
        self.security_answer_field = QLineEdit(self)
        self.security_answer_field.setPlaceholderText("Enter Security Answer")
        self.security_answer_field.setFixedWidth(300)
        account_layout.addRow(self.security_answer_label, self.security_answer_field)

        account_box.setLayout(account_layout)
        
        # Create a group box for address details
        address_box = QGroupBox("Address Details")
        address_layout = QFormLayout()
        address_box.setStyleSheet("QGroupBox::title {font-size: 22px;}")
        address_box.setFixedSize(452, 185)
        
        self.street_label = QLabel(self)
        self.street_label.setText("Street:")
        self.street_field = QLineEdit(self)
        self.street_field.setPlaceholderText("Enter your street address")
        self.street_field.setFixedWidth(300)
        address_layout.addRow(self.street_label, self.street_field)

        self.city_label = QLabel(self)
        self.city_label.setText("City:")
        self.city_field = QLineEdit(self)
        self.city_field.setPlaceholderText("Enter your city")
        self.city_field.setFixedWidth(300)
        address_layout.addRow(self.city_label, self.city_field)

        self.state_label = QLabel(self)
        self.state_label.setText("State:")
        self.state_field = QLineEdit(self)
        self.state_field.setPlaceholderText("Enter your state")
        self.state_field.setFixedWidth(300)
        address_layout.addRow(self.state_label, self.state_field)

        self.zipcode_label = QLabel(self)
        self.zipcode_label.setText("Zipcode:")
        self.zipcode_field = QLineEdit(self)
        self.zipcode_field.setPlaceholderText("Enter your zipcode")
        self.zipcode_field.setFixedWidth(300)
        address_layout.addRow(self.zipcode_label, self.zipcode_field)
        
        self.country_label = QLabel(self)
        self.country_label.setText("Country:")
        self.country_field = QComboBox(self)
        self.country_field.addItems(get_countries())
        address_layout.addRow(self.country_label, self.country_field)
        
        address_box.setLayout(address_layout)

        # Create a group box for contact details
        contact_box = QGroupBox("Contact Details")
        contact_layout = QFormLayout()
        contact_box.setStyleSheet("QGroupBox::title {font-size: 22px;}")
        contact_box.setFixedSize(452, 100)

        self.email_label = QLabel(self)
        self.email_label.setText("Email:")
        self.email_field = QLineEdit(self)
        self.email_field.setPlaceholderText("Enter your email address")
        self.email_field.setFixedWidth(300)
        contact_layout.addRow(self.email_label, self.email_field)

        self.phone_label = QLabel(self)
        self.phone_label.setText("Phone Number:")
        self.phone_field = QLineEdit(self)
        self.phone_field.setPlaceholderText("1-XXX-XXX-XXXX")
        self.phone_field.setFixedWidth(300)
        contact_layout.addRow(self.phone_label, self.phone_field)

        contact_box.setLayout(contact_layout)

        # Create a horizontal box layout for buttons
        button_layout = QHBoxLayout()

        self.signup_button = QPushButton("Sign Up", self)
        self.signup_button.clicked.connect(self.submit_form)
        button_layout.addWidget(self.signup_button)

        self.cancel_button = QPushButton("Cancel", self)
        self.cancel_button.clicked.connect(self.close)
        button_layout.addWidget(self.cancel_button)

        # Create a main layout that includes all of the other layouts
        layout = QVBoxLayout()
        layout.addWidget(self.instructions_label)
        layout.addWidget(personal_box)
        layout.addWidget(account_box)
        layout.addWidget(address_box)
        layout.addWidget(contact_box)
        layout.addLayout(button_layout)

        # Create a scroll area and set the main layout as its widget
        scroll_area = QScrollArea()
        scroll_widget = QWidget()
        scroll_widget.setLayout(layout)
        scroll_area.setWidget(scroll_widget)

        # Add the scroll area to the main window
        main_layout.addWidget(scroll_area)

        # Set the main layout for the window
        self.setLayout(main_layout)

    def submit_form(self):
        # Get the entered values
        first_name = self.first_name_field.text()
        last_name = self.last_name_field.text()
        birthdate = self.birthdate_field.date().toPyDate()
        username = self.username_field.text()
        password = self.password_field.text()
        confirm_password = self.confirm_password_field.text()
        security_question = self.security_question_field.currentText()
        security_answer = self.security_answer_field.text()
        country_name = self.country_field.currentText()
        state = self.state_field.text()
        city = self.city_field.text()
        street = self.street_field.text()
        zipcode = self.zipcode_field.text()
        email = self.email_field.text()
        phonenumber = self.phone_field.text()
        
        # Check if any field is left empty
        if not all([first_name, last_name, birthdate, username, password, confirm_password, security_answer, country_name, state, city, street, zipcode, email, phonenumber]):
            # Highlight the empty fields in red
            if not first_name:
                self.first_name_field.setStyleSheet("background-color: #FFC0CB")
            if not last_name:
                self.last_name_field.setStyleSheet("background-color: #FFC0CB")
            if not birthdate:
                self.birthdate_field.setStyleSheet("background-color: #FFC0CB")
            if not username:
                self.username_field.setStyleSheet("background-color: #FFC0CB")
            if not password:
                self.password_field.setStyleSheet("background-color: #FFC0CB")
            if not confirm_password:
                self.confirm_password_field.setStyleSheet("background-color: #FFC0CB")
            if not security_answer:
                self.security_answer_field.setStyleSheet("background-color: #FFC0CB")
            if not country_name:
                self.country_field.setStyleSheet("background-color: #FFC0CB")
            if not state:
                self.state_field.setStyleSheet("background-color: #FFC0CB")
            if not city:
                self.city_field.setStyleSheet("background-color: #FFC0CB")
            if not street:
                self.street_field.setStyleSheet("background-color: #FFC0CB")
            if not zipcode:
                self.zipcode_field.setStyleSheet("background-color: #FFC0CB")
            if not email:
                self.email_field.setStyleSheet("background-color: #FFC0CB")
            if not phonenumber:
                self.phone_field.setStyleSheet("background-color: #FFC0CB")

            # Show a warning message
            QMessageBox.warning(self, "Fields left empty", "Oops! Looks like you haven't filled out all details!\nPlease fill in all the required fields.")
            return
    
        # Check for password length
        if len(password) < 8:
            QMessageBox.warning(self, "Password too short", "Password must be at least 8 characters long")
            return
        
        # Check if password and confirm password fields are the same
        if password != confirm_password:
            QMessageBox.warning(self, "Passwords do not match", "Passwords do not match.")
            return

        # Calculate the age based on the birthdate
        today = date.today()
        age = today.year - birthdate.year - ((today.month, today.day) < (birthdate.month, birthdate.day))
        
        # Throw an error if the age is less than 21
        if age < 21:
            QMessageBox.warning(self, "Age restriction", "You must be at least 21 years old to create an account.")
            return

        # Get the CountryCode based on the selected CountryName
        country_id = None
        cursor = self.conn.cursor()
        cursor.execute("SELECT CountryCode FROM Countries WHERE CountryName = %s", (country_name,))
        result = cursor.fetchone()
        if result is not None:
            country_id = result[0]
            
        # Get the count of records in the customer table
        cursor.execute("SELECT COUNT(*) FROM Customer")
        customer_count = cursor.fetchone()[0]

        # Calculate the new CustomerID
        new_customer_id = 2000 + customer_count + 1

        try:
            # Check if the username already exists
            cursor.execute("SELECT COUNT(*) FROM Users WHERE Username = %s", (username,))
            username_count = cursor.fetchone()[0]
            if username_count > 0:
                QMessageBox.critical(self, "Error", "Username already exists. Please choose a different username.")
                return

            # Insert the customer details
            cursor.execute("INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Birthdate, Age, CountryCode, State, City, Street, Zipcode) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                           (new_customer_id, first_name, last_name, email, birthdate, age, country_id, state, city, street, zipcode))
            self.conn.commit()

            # Insert the user details
            cursor.execute("INSERT INTO Users (CustomerID, Username, Password, SecurityQuestion, SecurityAnswer) VALUES (%s, %s, %s, %s, %s)",
                           (new_customer_id, username, password, security_question, security_answer))
            self.conn.commit()
            
            # Insert the phone number details
            cursor.execute("INSERT INTO Customer_Phone (CustomerID, Phone) VALUES (%s, %s)",
                           (new_customer_id, phonenumber))
            self.conn.commit()

            # Show a success message
            QMessageBox.information(self, "Success", "Your account has been created successfully!")
            
            return
            
            # Return to the login page
            # self.login()

        except pymysql.err.IntegrityError as e:
            # Rollback the transaction and show an error message if the email already exists
            self.conn.rollback()
            if "Duplicate entry" in str(e) and "Username" in str(e):
                QMessageBox.critical(self, "Error", "Username already exists. Please choose a different username.")
            elif "Duplicate entry" in str(e) and "Email" in str(e):
                QMessageBox.critical(self, "Error", "Email ID already exists. Please use a different email ID.")
            else:
                QMessageBox.critical(self, "Error", "An error occurred while creating your account: {}".format(str(e)))

def get_countries():
    cursor.execute("SELECT CountryName FROM Countries")
    countries = cursor.fetchall()
    return [country[0] for country in countries]

def get_questions():
    cursor.execute("SELECT DISTINCT SecurityQuestion FROM Users")
    questions = cursor.fetchall()
    return [question[0] for question in questions]


class HomePage(QDialog):
    def __init__(self, username, customer_id):
        super().__init__()

        # Save the username and customer_id as instance variables
        self.username = username
        self.customer_id = customer_id

        # Set the title and window properties
        self.setWindowTitle("Winehaven Home")
        self.setFixedSize(1000, 600)

        # Create a QTabWidget to hold the tabs
        self.tab_widget = QTabWidget(self)

        # Add a Home tab
        self.home_tab = QWidget()
        self.home_tab_layout = QVBoxLayout()
        self.home_tab.setLayout(self.home_tab_layout)

        # Add a Wishlist tab
        # self.wishlist_tab = QWidget()
        # self.wishlist_tab_layout = QVBoxLayout()
        # self.wishlist_tab.setLayout(self.wishlist_tab_layout)

        # Add a Cart tab
        self.cart_tab = QWidget()
        self.cart_tab_layout = QVBoxLayout()
        self.cart_tab.setLayout(self.cart_tab_layout)

        # Add a View Products tab
        self.view_products_tab = QWidget()
        self.view_products_tab_layout = QVBoxLayout()
        self.view_products_tab.setLayout(self.view_products_tab_layout)
        
        # Add an Offers tab
        self.offers_tab = QWidget()
        self.offers_tab_layout = QVBoxLayout()
        self.offers_tab.setLayout(self.offers_tab_layout)
        
        # Create button to return to Home tab from Offers tab
        offers_home_button = QPushButton("Back to Home")
        offers_home_button.clicked.connect(lambda: self.tab_widget.setCurrentIndex(0))

        # Create layout for button
        offers_button_layout = QHBoxLayout()
        offers_button_layout.addStretch(1)
        offers_button_layout.addWidget(offers_home_button)
        offers_button_layout.addStretch()

        # Add layout to offers tab layout, with stretch to push button to bottom
        self.offers_tab_layout.addStretch(1)
        self.offers_tab_layout.addLayout(offers_button_layout)
        
        # Create a horizontal layout for the label and button
        label_button_layout = QHBoxLayout()

        # Add the label to the layout
        label = QLabel("FREE SHIPPING FROM US FOR THE NEXT 10 DAYS, ORDER NOW!")
        label.setAlignment(Qt.AlignCenter)
        label.setFont(QFont("Verdana", 14, QFont.Bold))
        label.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        label_button_layout.addWidget(label)

        # Add some stretch to push the label to the left
        label_button_layout.addStretch(1)

        # Add the button to the layout
        home_button = QPushButton("Back to Home")
        home_button.clicked.connect(lambda: self.tab_widget.setCurrentIndex(0))
        label_button_layout.addWidget(home_button)

        # Add the layout to the view products tab layout
        self.view_products_tab_layout.addLayout(label_button_layout)
        
        # Add a Reservation tab
        self.reservation_tab = QWidget()
        self.reservation_tab_layout = QVBoxLayout()
        self.reservation_tab.setLayout(self.reservation_tab_layout)
        
        #Add a Reviews tab
        self.reviews_tab = QWidget()
        self.reviews_tab_layout = QVBoxLayout()
        self.reviews_tab.setLayout(self.reviews_tab_layout)
        
        #Add a Cart tab
        self.cart_tab = QWidget()
        self.cart_tab_layout = QVBoxLayout()
        self.cart_tab.setLayout(self.cart_tab_layout)
        
        # Add tabs
        self.tab_widget.addTab(self.home_tab, "Home")
        self.tab_widget.addTab(self.view_products_tab, "View Products")
        self.tab_widget.addTab(self.reservation_tab, "Make Reservation")
        self.tab_widget.addTab(self.reviews_tab, "Reviews")
        self.tab_widget.addTab(self.offers_tab, "Offers")
        #self.tab_widget.addTab(self.wishlist_tab, "Wishlist")
        self.tab_widget.addTab(self.cart_tab, "Cart")

        # Add the tab widget to the layout
        layout = QVBoxLayout()
        layout.addWidget(self.tab_widget)
        self.setLayout(layout)
    
        # Add an image to the Home tab
        self.home_image = QLabel(self)
        pixmap = QPixmap("banner.jpeg")
        scaled_pixmap = pixmap.scaled(self.home_tab.size() * 1.5, Qt.KeepAspectRatio, Qt.SmoothTransformation)
        self.home_image.setPixmap(scaled_pixmap)
        self.home_image.setAlignment(Qt.AlignCenter)
        self.home_tab_layout.addWidget(self.home_image)
        
        # Add content to the Home tab
        self.home_content = QLabel(self)
        self.home_content.setText("Welcome to Winehaven!\nWe're happy to have you here.\nExplore our wines and find your favorites.")
        self.home_content.setAlignment(Qt.AlignCenter)
        self.home_tab_layout.addWidget(self.home_content)
        
        # Create a QGroupBox for the About Us section
        self.about_us_groupbox = QGroupBox("About Us", self)
        self.about_us_groupbox.setStyleSheet("QGroupBox::title {font-size: 22px;}")
        self.home_tab_layout.addWidget(self.about_us_groupbox)

        # Create a QLabel with the About Us text
        self.about_us_label = QLabel(self)
        font = QFont("Verdana", 13) # use a monospaced font with size 10
        self.about_us_label.setFont(font)
        self.about_us_label.setText("Winehaven is a premier reseller of exceptional wines from various regions around the world. Our collection of fine wines includes the best selections from renowned wine regions such as California, France, and many others.\nAt Winehaven, we believe that wine is more than just a beverage; it's a passion that's been embraced by connoisseurs for centuries. We strive to bring that passion to our customers by offering a unique selection of premium wines from different regions of the world, and by providing the knowledge and expertise needed to choose the perfect wine for any occasion.\nOur team of experts carefully selects each bottle of wine in our inventory, ensuring that every wine is of the highest quality and meets our rigorous standards.")
        
#         We take pride in our extensive collection of wines, ranging from the popular to the rare and hard-to-find vintages.\nWhether you're a seasoned wine connoisseur or just starting to explore the world of wine, Winehaven is the perfect place to find the perfect bottle. We are committed to providing exceptional customer service and strive to make every customer's experience with us a memorable one.
        
        self.about_us_label.setAlignment(Qt.AlignCenter)
        self.about_us_label.setWordWrap(True) # enable word wrapping to prevent text from going off the screen
        self.about_us_groupbox.setLayout(QVBoxLayout())
        self.about_us_groupbox.layout().addWidget(self.about_us_label)

        # Add a logout button to the Home tab
        logout_button = QPushButton("Logout")
        logout_button.clicked.connect(self.logout)
        self.home_tab_layout.addWidget(logout_button)
                
        # Initialize the wishlist and cart variables
        self.wishlist = []
        #self.cart = []

        # Create instances of the other classes and add them as widgets to their respective tabs
        self.view_products_page = ViewProductsPage(self.username)
        self.view_products_tab_layout.addWidget(self.view_products_page)

        self.reviews_page = ReviewsPage(self.username)
        self.reviews_tab_layout.addWidget(self.reviews_page)
        
        # self.wishlist_page = WishlistPage(self.username) 
        # self.wishlist_tab_layout.addWidget(self.wishlist_page) 
        
        self.offers_page = OffersPage()
        self.offers_tab_layout.addWidget(self.offers_page) 
        
        self.reservation_page = WineryReservation(self.username)
        self.reservation_tab_layout.addWidget(self.reservation_page) 
        
        self.cart_page = Cart(self.username)
        self.cart_tab_layout.addWidget(self.cart_page)

    # Function to log out and return to the login page
    def logout(self):
        self.close()
        login.show()
        

class WishlistPage(QWidget):
    def __init__(self, username, wine_id=None, parent=None):
        super().__init__(parent)
        
        # Connect to the database and execute a SELECT query to retrieve the customer ID for the specified username.
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()
        query = "SELECT CustomerID FROM Users WHERE Username = %s"
        cursor.execute(query, (username,))
        result = cursor.fetchone()
        self.customer_id = result[0]
        
        # Execute a SELECT query to retrieve the wine IDs and quantities from the wishlist table for the specified customer ID.
        query = "SELECT WineID FROM Wishlist WHERE CustomerID = %s"
        cursor.execute(query, (self.customer_id,))
        result = cursor.fetchall()
        wine_ids = [row[0] for row in result]
        
        # Create a scroll area to hold the wine information
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)

        # Create a widget to hold the wine information
        widget = QWidget()
        layout = QVBoxLayout(widget)

        # For each wine ID in the wishlist, execute a SELECT query to retrieve the wine name and other wine information from the wine table.
        for wine_id in wine_ids:
            query = "SELECT WineName, Price FROM Wine WHERE WineID = %s"
            cursor.execute(query, (wine_id,))
            result = cursor.fetchone()
            wine_name = result[0]
            wine_price = result[1]

            # Create widgets to display the wine information and buttons to add and remove from cart
           # name_label = QLabel(wine_name)
            name_label = QLabel(f"<b>{wine_name}</b>")
            name_label.setWordWrap(True)
            price_label = QLabel(f"${wine_price:.2f}")
            add_to_cart_button = QPushButton("Add to cart")
            remove_button = QPushButton("Remove from Wishlist")

            # Add the wine information widgets and buttons to the layout
            row_layout = QHBoxLayout()
            row_layout.addWidget(name_label)
            row_layout.addWidget(price_label)
            row_layout.addWidget(add_to_cart_button)
            row_layout.addWidget(remove_button)
            layout.addLayout(row_layout)

            # Connect the add and remove button signals to their respective slots
            #add_button.clicked.connect(lambda checked, wine_id=wine_id: self.add_to_cart(wine_id))
            add_to_cart_button.clicked.connect(lambda checked, wine_id=wine_id: self.add_to_cart(wine_id))
            remove_button.clicked.connect(lambda checked, wine_id=wine_id: self.remove_from_wishlist(wine_id))

        # Add the layout to the widget and set the widget as the scroll area's widget
        widget.setLayout(layout)
        scroll_area.setWidget(widget)

        # Set the scroll area as the central widget for the wishlist page
        self.setLayout(QVBoxLayout())
        self.layout().addWidget(scroll_area)

        # Set the window properties
        self.setWindowTitle("Wishlist")
        self.resize(500, 600)

        # Store the database connection and cursor as instance variables for later use
        self.conn = conn
        self.cursor = cursor
        self.username = username
        self.wine_id = wine_id
        
    def add_to_cart(self, wine_id):
        # Get the quantity of the selected wine in stock
        query = "SELECT Stock FROM Inventory WHERE WineID = %s"
        cursor.execute(query, (wine_id,))
        stock_quantity = cursor.fetchone()[0]
        
        query = "SELECT CustomerID FROM Users WHERE Username = %s"
        cursor.execute(query, (self.username,))
        customer_id = cursor.fetchone()[0]
        
        query = "SELECT WineName FROM Wine WHERE WineID = %s"
        self.cursor.execute(query, (wine_id,))
        wine_name = self.cursor.fetchone()[0]

        
        global custid
        global wine
        custid=customer_id
        wine=wine_id
        print(customer_id,wine_id,custid,wine)

        # If there is stock available, add the wine to the cart
        if stock_quantity > 0:
            # Insert a new row into the cart table with the customer's ID, the wine ID, and a quantity of 1
            query = "INSERT INTO Cart(CustomerID, WineID, Quantity) VALUES (%s, %s, %s)"
            self.cursor.execute(query, (customer_id, wine_id, 1))
            self.conn.commit()

            QMessageBox.information(self, "Success", f"{wine_name} added to Cart.")
            #self.ask_for_customization()

        # If there is no stock available, show an error message
        else:
            wine_name = self.find_child_by_attribute("objectName", str(wine_id)).wine_name
            QMessageBox.warning(self, "Error", f"{wine_name} is out of stock.")
        
        self.ask_for_customization()

    def remove_from_wishlist(self, wine_id):
        # Execute a DELETE query to remove the specified wine from the wishlist table
        query = "DELETE FROM Wishlist WHERE CustomerID = %s AND WineID = %s"
        self.cursor.execute(query, (self.customer_id, wine_id))
        self.conn.commit()
        
        
        QMessageBox.information(self, "Success", f"Removed from wishlist.")    
                  
        
        
        # Remove the wine information from the wishlist page
        widget = self.findChild(QWidget, "wishlist_page")
        if widget:
            for i in reversed(range(widget.layout().count())):
                item = widget.layout().itemAt(i)
                row_widget = item.widget()
                if row_widget.property("wine_id") == wine_id:
                    widget.layout().removeItem(item)
                    row_widget.setParent(None)
                      
                   # Update the scroll area's widget with the modified layout
                scroll_area = self.findChild(QScrollArea)
                scroll_area.setWidget(widget)                
                
        #widget.repaint()        
        # Refresh the layout
        #widget.adjustSize()
        #widget.updateGeometry()
        #self.adjustSize()
        #self.updateGeometry()

        # Refresh the page to update the displayed wishlist
        #self.refresh()
        
        
class WineTile(QWidget):
    def __init__(self, wine_id, wine_name, description, price, username, parent=None):
        super().__init__(parent)
        self.wine_id = wine_id
        self.wine_name = wine_name
        self.description = description
        self.price = price
        self.username = username
        
        # Create UI elements
        name_label = QLabel(wine_name)
        name_label.setFont(QFont("Arial", 14, QFont.Bold))
        description_edit = QTextEdit(description)
        description_edit.setReadOnly(True)
        price_label = QLabel("<b>Price:</b> ${:.2f}".format(price))
        quicklook_button = QPushButton("Quick Look")
        quicklook_button.setObjectName(str(wine_id))
        quicklook_button.clicked.connect(self.quicklook)

        # Create layout
        layout = QHBoxLayout()

        # Create layout for wine details
        details_layout = QVBoxLayout()
        details_layout.addWidget(name_label)
#         details_layout.addWidget(description_edit)
        details_layout.addWidget(price_label)
        details_layout.addWidget(quicklook_button)

        # Set layout margin and spacing
        details_layout.setContentsMargins(20, 20, 20, 20)
        details_layout.setSpacing(5)

        # Add the layout to the page
        layout.addLayout(details_layout)

        self.setLayout(layout)

    def quicklook(self):
        # Create dialog box for wine details
        self.quicklook_dialog = QDialog(self)
        self.quicklook_dialog.setWindowTitle("Wine Details")
        self.quicklook_dialog.setMinimumWidth(500)

        # Query wine details
        query = """
        SELECT Wine.WineName, Wine.Description, Wine.Vintage,
               WineType.WineType AS WineColour, gv.Variety AS GrapeVariety, Wine.WineID, Wine.Price, Wine.ImageURL, Wine.ABV
        FROM Wine
        JOIN WineType ON Wine.WineTypeID = WineType.WineTypeID 
        JOIN GrapeVariety AS gv ON Wine.VarietyID = gv.VarietyID 
        WHERE Wine.WineID = %s
        """
        cursor.execute(query, (self.wine_id,))
        result = cursor.fetchone()
        image_url = result[7]

        image_label = QLabel()
        image_data = urllib.request.urlopen(image_url).read()
        image = QPixmap()
        image.loadFromData(image_data)

        # Determine the aspect ratio of the original image
        aspect_ratio = image.width() / image.height()

        # Create a new image with a fixed height, preserving the aspect ratio
        new_height = 400
        new_width = int(new_height * aspect_ratio)
        new_image = QPixmap(new_width, new_height)
        new_image.fill(Qt.transparent)
        painter = QPainter(new_image)
        painter.drawPixmap(0, 0, image.scaled(new_width, new_height, Qt.KeepAspectRatio, Qt.SmoothTransformation))
        painter.end() # end painting operation

        # Crop the sides of the new image
        crop_rect = QRect(int(new_width / 4), 0, int(new_width / 2), new_height)
        cropped_image = new_image.copy(crop_rect)

        image_label.setPixmap(cropped_image)

        # Add the "Add to Cart" button
        add_to_cart_button = QPushButton("Add to Cart")
        add_to_cart_button.setObjectName(str(self.wine_id))
        add_to_cart_button.setStyleSheet("background-color: #5CB85C; color: white; border: none; padding: 5px 10px;")
        add_to_cart_button.clicked.connect(lambda _, id=self.wine_id: self.add_to_cart(id))
        
        # Add the "Add to Wishlist" button
        add_to_wishlist_button = QPushButton("Add to Wishlist")
        add_to_wishlist_button.setObjectName(str(self.wine_id))
        add_to_wishlist_button.setStyleSheet("background-color: #337AB7; color: white; border: none; padding: 5px 10px;")
        add_to_wishlist_button.clicked.connect(lambda _, id=self.wine_id: self.add_to_wishlist(id))

        # Add the layout to the page
        back_button = QPushButton("Back")
        back_button.setStyleSheet("background-color: #D9534F; color: white; border: none; padding: 5px 10px;")
        back_button.clicked.connect(self.back_to_view_products_page)
        
        # Create horizontal layout and add the image to the left and the details layout to the right
        layout = QHBoxLayout()
        layout.addWidget(image_label)
        
        # Create layout for wine details
        vbox = QVBoxLayout()
        layout.addLayout(vbox)
        
        self.wine_name = result[0]
        
        # Create labels for wine details
        name_label = QLabel("<b>{}</b>".format(result[0]))
        name_label.setFont(QFont("Arial", 16, QFont.Bold))
        description_label = QLabel(result[1])
        description_label.setWordWrap(True)
        description_label.setAlignment(Qt.AlignTop)
        description_label.setMargin(10)
        vintage_label = QLabel("<b>Vintage:</b> {}".format(result[2]))
        wine_colour_label = QLabel("<b>Wine Colour:</b> {}".format(result[3]))
        grape_variety_label = QLabel("<b>Grape Variety:</b> {}".format(result[4]))
        price_label = QLabel("<b>Price:</b> ${:.2f}</b>".format(result[6]))
        ABV_label = QLabel("<b>Alcohol Content :</b> {:.1f}%".format(result[8]))

        # Add wine details to layout
        vbox.addWidget(name_label)
        vbox.addWidget(description_label)
        vbox.addWidget(vintage_label)
        vbox.addWidget(wine_colour_label)
        vbox.addWidget(grape_variety_label)
        vbox.addWidget(ABV_label)
        vbox.addWidget(price_label)
        vbox.addWidget(add_to_cart_button)
        vbox.addWidget(add_to_wishlist_button)
        vbox.addWidget(back_button)

        # Set layout margin and spacing
        vbox.setContentsMargins(20, 20, 20, 20)
        vbox.setSpacing(10)

        # Set dialog box layout
        self.quicklook_dialog.setLayout(layout)

        # Show dialog box
        self.quicklook_dialog.exec_()

    def back_to_view_products_page(self):
        # Close quicklook dialog if it is open
        if self.quicklook_dialog and self.quicklook_dialog.isVisible():
            self.quicklook_dialog.close()
        
    def add_to_cart(self, wine_id):
        # Get the quantity of the selected wine in stock
        query = "SELECT Stock FROM Inventory WHERE WineID = %s"
        cursor.execute(query, (wine_id,))
        stock_quantity = cursor.fetchone()[0]
        
        query = "SELECT CustomerID FROM Users WHERE Username = %s"
        cursor.execute(query, (self.username,))
        customer_id = cursor.fetchone()[0]
        
        global custid
        global wine
        custid=customer_id
        wine=wine_id
        print(customer_id,wine_id,custid,wine)

        # If there is stock available, add the wine to the cart
        if stock_quantity > 0:
            # Insert a new row into the cart table with the customer's ID, the wine ID, and a quantity of 1
            query = "INSERT INTO Cart(CustomerID, WineID, Quantity) VALUES (%s, %s, %s)"
            cursor.execute(query, (customer_id, wine_id, 1))
            conn.commit()

            QMessageBox.information(self, "Success", f"{self.wine_name} added to Cart.")
            self.ask_for_customization()

        # If there is no stock available, show an error message
        else:
            wine_name = self.find_child_by_attribute("objectName", str(wine_id)).wine_name
            QMessageBox.warning(self, "Error", f"{wine_name} is out of stock.")
            
        self.quicklook_dialog.close()

    def ask_for_customization(self):
        dialog = QDialog(self)
        dialog.setWindowTitle('Customization Confirmation')
        layout = QVBoxLayout()
        label = QLabel('Would you like to Customize your order?', dialog)
        layout.addWidget(label)
        buttons = QDialogButtonBox(QDialogButtonBox.Cancel | QDialogButtonBox.Ok, dialog)
        buttons.accepted.connect(lambda: self.open_custom(dialog))
        buttons.rejected.connect(lambda: self.open_checkout(dialog))
        
        layout.addWidget(buttons)
        dialog.setLayout(layout)
        
        dialog.exec_()

    def open_custom(self, dialog):
        # close the dialog box
        dialog.accept()

        current_path = os.getcwd()
        self.checkout_window = Customization(current_path+"/images",custid,wine)
        self.checkout_window.show()

    def open_checkout(self, dialog):
        # close the dialog box
        dialog.reject()

        # create and show window B
        self.checkout_window = Checkout(custid,wine)
        self.checkout_window.show()            
            

    def add_to_wishlist(self, wine_id):
        query = "SELECT CustomerID FROM Users WHERE Username = %s"
        cursor.execute(query, (self.username,))
        customer_id = cursor.fetchone()[0]      

        cursor.execute("SELECT NOW()")
        # Fetch the result and print it
        current_timestamp = cursor.fetchone()

        # Check if the wine is already in the wishlist
        query = "SELECT * FROM Wishlist WHERE CustomerID = %s AND WineID = %s"
        cursor.execute(query, (customer_id, wine_id))
        result = cursor.fetchone()
        if result:
            QMessageBox.warning(self, "Warning", f"{self.wine_name} is already in Wishlist.")
            return

        # Insert a new row into the wishlist table with the customer's ID and the wine ID
        query = "INSERT INTO Wishlist(CustomerID, WineID) VALUES (%s, %s)"
        cursor.execute(query, (customer_id, wine_id))
        conn.commit()

        QMessageBox.information(self, "Success", f"{self.wine_name} added to Wishlist.")
        
        #self.ask_for_customization()


class ViewProductsPage(QDialog):
    def __init__(self, username, parent=None, result=None):
        super().__init__(parent)

        # Set up the UI elements
        self.setWindowTitle("View Products")
        
        self.setFixedSize(1000, 400)
        
        self.username = username

        # Create a vertical layout to hold the UI elements
        layout = QVBoxLayout()

        # Create the filter button
        filter_button = QPushButton("Filter")

        # Set the fixed width and height of the button
        filter_button.setFixedSize(200, 30)

        # Set the font size and weight
        font = filter_button.font()
        font.setPointSize(14)
        font.setWeight(QFont.Bold)
        filter_button.setFont(font)

        # Set the background color and hover color
        filter_button.setStyleSheet('''
            background-color: black;
            color: white;
            border-radius: 5px;
        ''')

        filter_button.setCursor(Qt.PointingHandCursor)
        
        # Create the wishlist button
        wishlist_button = QPushButton("Wishlist")
        
        # Set the fixed width and height of the button
        wishlist_button.setFixedSize(200, 30)

        # Set the font size and weight
        wishlist_button.setFont(font)

        # Set the background color and hover color
        wishlist_button.setStyleSheet('''
            background-color: black;
            color: white;
            border-radius: 5px;
        ''')

        wishlist_button.setCursor(Qt.PointingHandCursor)
        
        # Add the buttons to the layout
        button_layout = QHBoxLayout()
        button_layout.addWidget(filter_button, alignment=Qt.AlignCenter)
        button_layout.addWidget(wishlist_button, alignment=Qt.AlignCenter)
        layout.addLayout(button_layout)

        # Connect the buttons to their respective functions
        filter_button.clicked.connect(self.show_filter_dialog)
        wishlist_button.clicked.connect(self.show_wishlist_dialog)
       
        # Add a scroll area to hold the wine widgets
        scroll_area = QScrollArea()
        layout.addWidget(scroll_area)

        # Create a widget to hold the wine widgets
        self.wine_widget_container = QWidget()
        wine_widget_container_layout = QGridLayout()
        self.wine_widget_container.setLayout(wine_widget_container_layout)
        scroll_area.setWidget(self.wine_widget_container)
        scroll_area.setFixedHeight(400)
        
        # Store the initial query used to fetch the wine data
        self.initial_query = """
        SELECT Wine.WineName, Wine.Description, Wine.Vintage,
               WineType.WineType AS WineColour, gv.Variety AS GrapeVariety, Wine.WineID, Wine.Price, Wine.ImageURL, Winery.WineryName, Wine.ABV
        FROM Wine, WineType, GrapeVariety AS gv, Winery
        WHERE Wine.WineTypeID = WineType.WineTypeID 
        AND Wine.VarietyID = gv.VarietyID 
        AND Wine.WineryID = Winery.WineryID
        """
        
        # Query the wine, winetype, and grape variety tables to get the available wines and their details
        query = """
        SELECT Wine.WineName, Wine.Description, Wine.Vintage,
               WineType.WineType AS WineColour, gv.Variety AS GrapeVariety, Wine.WineID, Wine.Price, Wine.ImageURL, Winery.WineryName, Wine.ABV
        FROM Wine, WineType, GrapeVariety AS gv, Winery
        WHERE Wine.WineTypeID = WineType.WineTypeID 
        AND Wine.VarietyID = gv.VarietyID 
        AND Wine.WineryID = Winery.WineryID
        GROUP BY Wine.WineID
        """
        cursor.execute(query)
        result = cursor.fetchall()
        
        # Add wine tiles to the container
        row = 0
        col = 0
        for wine_name, description, vintage, wine_colour, grape_varieties, wine_id, price, image_url, winery, abv in result:
            # Create a widget for the wine tile
            wine_widget = QWidget()
            wine_widget_layout = QHBoxLayout()
            wine_widget.setLayout(wine_widget_layout)

            # Create a widget for the wine image
            image_widget = QWidget()
            image_layout = QVBoxLayout()
            image_widget.setLayout(image_layout)

            # Add the wine image to the image widget
            if image_url:
                image_label = QLabel()
                image_data = urllib.request.urlopen(image_url).read()
                image = QPixmap()
                image.loadFromData(image_data)

                # Determine the aspect ratio of the original image
                aspect_ratio = image.width() / image.height()

                # Create a new image with a fixed height, preserving the aspect ratio
                new_height = 200
                new_width = int(new_height * aspect_ratio)
                new_image = QPixmap(new_width, new_height)
                new_image.fill(Qt.transparent)
                painter = QPainter(new_image)
                painter.drawPixmap(0, 0, image.scaled(new_width, new_height, Qt.KeepAspectRatio, Qt.SmoothTransformation))
                painter.end() # end painting operation

                # Crop the sides of the new image
                crop_rect = QRect(int(new_width / 4), 0, int(new_width / 2), new_height)
                cropped_image = new_image.copy(crop_rect)

                image_label.setPixmap(cropped_image)
                image_layout.addWidget(image_label)

            # Add the image widget to the wine widget
            wine_widget_layout.addWidget(image_widget)

            # Create a widget for the wine information
            info_widget = QWidget()
            info_layout = QVBoxLayout()
            info_widget.setLayout(info_layout)

            # Add the wine information to the info widget
            wine_tile = WineTile(wine_id, wine_name, description, price, self.username)
            info_layout.addWidget(wine_tile)

            # Add the info widget to the wine widget with a stretch factor to push it closer to the image
            wine_widget_layout.addWidget(info_widget, 1)

            # Add the wine widget to the grid layout
            wine_widget_container_layout.addWidget(wine_widget, row, col)
            col += 1
            if col == 2:
                row += 1
                col = 0

        # Set the layout for the container widget
        self.wine_widget_container.setLayout(wine_widget_container_layout)

        # Set the widget for the scroll area
        scroll_area.setWidgetResizable(True)
        scroll_area.setWidget(self.wine_widget_container)

        # Add the layout to the page
        layout.addStretch(1)
        
        self.filter_dialog_open = False

        self.setLayout(layout)
        
        
    def show_wishlist_dialog(self):
        # Create a pop-up dialog box to show the WishlistPage
        dialog = QDialog(self)
        dialog.setWindowTitle("Wishlist")
        dialog.setFixedSize(600, 400)
        wishlist_page = WishlistPage(self.username, parent=dialog)
        layout = QVBoxLayout(dialog)
        layout.addWidget(wishlist_page)
        dialog.exec_()
    
    def show_filter_dialog(self):
        # Create a dialog window to get filter details
        self.filter_dialog = QDialog(self)
        self.filter_dialog.setWindowTitle("Filter Wines")
        self.filter_dialog.setModal(True)

        # Set up the UI elements
        layout = QVBoxLayout()

        # Add a label to the top of the page
        label = QLabel("Add Filters")
        label.setAlignment(Qt.AlignCenter)
        layout.addWidget(label)

        # Add a form to input filter details
        self.form = QFormLayout()

        # Add a combo box to select winery name
        self.winery_name_combo = QComboBox()
        self.winery_name_combo.addItem("All Wineries")
        # Populate winery name options from the database
        query = "SELECT WineryName FROM Winery"
        cursor.execute(query)
        result = cursor.fetchall()
        for winery_name, in result:
            self.winery_name_combo.addItem(winery_name)
        self.form.addRow("Winery Name:", self.winery_name_combo)

        # Add a spin box to input ABV content
        self.abv_spinbox = QDoubleSpinBox()
        self.abv_spinbox.setRange(0, 100)
        self.abv_spinbox.setDecimals(1)
        self.abv_spinbox.setSingleStep(0.1)
        self.form.addRow("Alcohol Content:", self.abv_spinbox)

        # Add a combo box to select wine color
        self.wine_color_combo = QComboBox()
        self.wine_color_combo.addItem("All Colours")
        # Populate wine color options from the database
        query = "SELECT DISTINCT WineType FROM WineType ORDER BY WineType ASC"
        cursor.execute(query)
        result = cursor.fetchall()
        for wine_color, in result:
            self.wine_color_combo.addItem(wine_color)
        self.form.addRow("Wine Color:", self.wine_color_combo)

        # Add a combo box to select grape variety
        self.grape_variety_combo = QComboBox()
        self.grape_variety_combo.addItem("All Varieties")
        # Populate grape variety options from the database
        query = "SELECT Variety FROM GrapeVariety"
        cursor.execute(query)
        result = cursor.fetchall()
        for grape_variety, in result:
            self.grape_variety_combo.addItem(grape_variety)
        self.form.addRow("Grape Variety:", self.grape_variety_combo)

        # Add a combo box to select vintage
        self.vintage_combo = QComboBox()
        self.vintage_combo.addItem("All Vintages")
        # Populate vintage options from the database
        query = "SELECT DISTINCT Vintage FROM Wine ORDER BY Vintage DESC"
        cursor.execute(query)
        result = cursor.fetchall()
        for vintage, in result:
            self.vintage_combo.addItem(str(vintage))
        self.form.addRow("Vintage:", self.vintage_combo)

        # Add two spin boxes to input price range
        self.min_price_spinbox = QSpinBox()
        self.min_price_spinbox.setRange(0, 10000)
        self.min_price_spinbox.setSingleStep(50)
        self.form.addRow("Minimum Price:", self.min_price_spinbox)

        self.max_price_spinbox = QSpinBox()
        self.max_price_spinbox.setRange(0, 10000)
        self.max_price_spinbox.setSingleStep(50)
        self.max_price_spinbox.setValue(10000)
        self.form.addRow("Maximum Price:", self.max_price_spinbox)

        # Add the form to the layout
        layout.addLayout(self.form)

        # Add a button to apply the filters
        self.apply_button = QPushButton("Apply Filters")
        layout.addWidget(self.apply_button, alignment=Qt.AlignCenter)
        self.apply_button.clicked.connect(self.apply_filters)

        # Add a button to clear the filters
        self.clear_button = QPushButton("Clear Filters")
        layout.addWidget(self.clear_button, alignment=Qt.AlignCenter)
        self.clear_button.clicked.connect(self.clear_filters)
        
        # Add a button to close the filters window
        self.close_button = QPushButton("Back")
        layout.addWidget(self.close_button, alignment=Qt.AlignCenter)
        self.close_button.clicked.connect(self.close_filter)

        # Add the layout to the dialog
        self.filter_dialog.setLayout(layout)
        
        self.filter_dialog.show()

    # Define a function to apply the filters and close the dialog
    def apply_filters(self):
        # Get the selected filter values
        winery_name = self.winery_name_combo.currentText()
        abv_content = self.abv_spinbox.value()
        wine_color = self.wine_color_combo.currentText()
        grape_variety = self.grape_variety_combo.currentText()
        vintage = self.vintage_combo.currentText()
        min_price = self.min_price_spinbox.value()
        max_price = self.max_price_spinbox.value()
        
        # Create a new query based on the selected filters
        query = self.initial_query

        # Add the filter conditions to the query if they are not empty
        if min_price:
            query += f" AND Wine.Price >= {min_price}"
        if max_price:
            query += f" AND Wine.Price <= {max_price}"
        if winery_name != "All Wineries":
            query += f" AND Winery.WineryName = '{winery_name}'"
        if abv_content:
            query += f" AND Wine.ABV >= {abv_content}"
        if wine_color != "All Colours":
            query += f" AND WineType.WineType = '{wine_color}'"
        if grape_variety != "All Varieties":
            query += f" AND gv.Variety = '{grape_variety}'"
        if vintage != "All Vintages":
            query += f" AND Wine.Vintage = {vintage}"

        query += """
        GROUP BY Wine.WineID, Wine.WineName, Wine.Description, Wine.Vintage,
                 WineType.WineType, gv.Variety, Wine.Price
        ORDER BY Wine.WineName ASC
        """

        # Executing the filtered query and returning the results
        cursor.execute(query)
        result = cursor.fetchall()

        # Clear the existing wine widgets from the grid layout
        wine_widget_container = self.wine_widget_container
        wine_widget_container_layout = wine_widget_container.layout()
        while wine_widget_container_layout.count():
            item = wine_widget_container_layout.takeAt(0)
            widget = item.widget()
            widget.deleteLater()

        # Add wine tiles to the container
        row = 0
        col = 0
        for wine_name, description, vintage, wine_colour, grape_varieties, wine_id, price, image_url, winery, abv in result:
            # Create a widget for the wine tile
            wine_widget = QWidget()
            wine_widget_layout = QHBoxLayout()
            wine_widget.setLayout(wine_widget_layout)

            # Create a widget for the wine image
            image_widget = QWidget()
            image_layout = QVBoxLayout()
            image_widget.setLayout(image_layout)

            # Add the wine image to the image widget
            if image_url:
                image_label = QLabel()
                image_data = urllib.request.urlopen(image_url).read()
                image = QPixmap()
                image.loadFromData(image_data)

                # Determine the aspect ratio of the original image
                aspect_ratio = image.width() / image.height()

                # Create a new image with a fixed height, preserving the aspect ratio
                new_height = 200
                new_width = int(new_height * aspect_ratio)
                new_image = QPixmap(new_width, new_height)
                new_image.fill(Qt.transparent)
                painter = QPainter(new_image)
                painter.drawPixmap(0, 0, image.scaled(new_width, new_height, Qt.KeepAspectRatio, Qt.SmoothTransformation))
                painter.end() # end painting operation

                # Crop the sides of the new image
                crop_rect = QRect(int(new_width / 4), 0, int(new_width / 2), new_height)
                cropped_image = new_image.copy(crop_rect)

                image_label.setPixmap(cropped_image)
                image_layout.addWidget(image_label)

            # Add the image widget to the wine widget
            wine_widget_layout.addWidget(image_widget)

            # Create a widget for the wine information
            info_widget = QWidget()
            info_layout = QVBoxLayout()
            info_widget.setLayout(info_layout)

            # Add the wine information to the info widget
            wine_tile = WineTile(wine_id, wine_name, description, price, self.username)
            info_layout.addWidget(wine_tile)

            # Add the info widget to the wine widget with a stretch factor to push it closer to the image
            wine_widget_layout.addWidget(info_widget, 1)

            # Add the wine widget to the grid layout
            wine_widget_container_layout.addWidget(wine_widget, row, col)
            col += 1
            if col == 2:
                row += 1
                col = 0

#         # Set the stretch factor for all rows and columns to 1
#         for i in range(row + 1):
#             wine_widget_container_layout.setRowStretch(i, 1)
#         for j in range(col):
#             wine_widget_container_layout.setRowStretch(j, 1)

        # Close the filters dialog
        self.filter_dialog.close()

    def clear_filters(self):
        # Clear the filter settings
        self.winery_name_combo.setCurrentIndex(0)
        self.abv_spinbox.setValue(0)
        self.wine_color_combo.setCurrentIndex(0)
        self.grape_variety_combo.setCurrentIndex(0)
        self.vintage_combo.setCurrentIndex(0)
        self.min_price_spinbox.setValue(0)
        self.max_price_spinbox.setValue(10000)

    def close_filter(self):
        # Close the filters dialog
        self.filter_dialog.close()
        
    def open_quicklook_dialog(self, wine_id):
        """
        Opens a dialog to display details about the selected wine.
        """
        # Query the wine, winetype, and grape variety tables to get the wine details
        query = """
        SELECT Wine.WineName, Wine.Description, Wine.Vintage,
               WineType.WineType AS WineColour, gv.Variety AS GrapeVariety, Wine.Price
        FROM Wine, WineType, GrapeVariety AS gv
        WHERE Wine.WineTypeID = WineType.WineTypeID 
        AND Wine.VarietyID = gv.VarietyID 
        AND Wine.WineID = ?
        """
        cursor.execute(query, (wine_id,))
        result = cursor.fetchone()

        # Create a dialog to display the wine details
        dialog = QDialog(self)
        dialog.setWindowTitle("Quicklook")
        dialog_layout = QVBoxLayout()
        dialog.setLayout(dialog_layout)

        # Add the wine name in bold
        wine_name_label = QLabel(result[0])
        wine_name_label.setStyleSheet("font-weight: bold; font-size: 18px;")
        dialog_layout.addWidget(wine_name_label)

        # Add the wine description
        wine_description_label = QLabel(result[1])
        wine_description_label.setWordWrap(True)
        dialog_layout.addWidget(wine_description_label)

        # Add the wine vintage
        wine_vintage_label = QLabel(f"Vintage: {result[2]}")
        dialog_layout.addWidget(wine_vintage_label)

        # Add the wine colour
        wine_colour_label = QLabel(f"Wine Colour: {result[3]}")
        dialog_layout.addWidget(wine_colour_label)

        # Add the grape variety
        grape_variety_label = QLabel(f"Grape Variety: {result[4]}")
        dialog_layout.addWidget(grape_variety_label)

        # Add the wine price
        wine_price_label = QLabel(f"Price: ${str(price)}")
        wine_price_label.setObjectName("winePriceLabel")
        wine_layout.addWidget(wine_price_label)

        # Add the Quick Look button
        quick_look_button = QPushButton("Quick Look")
        quick_look_button.setObjectName(str(wine_id))
        quick_look_button.clicked.connect(lambda _, id=wine_id: self.show_wine_details(id))
        wine_layout.addWidget(quick_look_button)

        # Add the wine widget to the container
        wine_widget_container_layout.addWidget(wine_widget)
        
        # Set the widget for the scroll area
        scroll_area.setWidgetResizable(True)
        scroll_area.setWidget(wine_widget_container)

        # Add the layout to the page
        self.setLayout(layout)
                
    def back_to_home_page(self):
        # Switch to the Home tab
        self.tab_widget.setCurrentIndex(0)

        
class OffersPage(QWidget):
    def __init__(self):
        super().__init__()

        # Set the stylesheet for the page
        self.setStyleSheet(
            """
            QLabel {
                font-size: 18px;
            }
            """
        )

        # Create a layout for the page
        self.layout = QVBoxLayout()
        self.setLayout(self.layout)

        # Create a label for the page title
        self.title_label = QLabel("Offers and Discounts")
        self.title_label.setFont(QFont("Verdana", 30, QFont.Bold))
        self.title_label.setAlignment(Qt.AlignCenter)
        self.layout.addWidget(self.title_label)

        # Create a layout for the offers and discounts
        self.offers_layout = QVBoxLayout()

        # Query the Discounts table
        cursor.execute("SELECT DiscountCode, DiscountName FROM Discounts")
        discounts = cursor.fetchall()

        # Create a label for each discount and add it to the offers layout
        for discount in discounts:
            discount_label = QLabel(f"{discount[0]}: {discount[1]} off")
            discount_label.setStyleSheet("padding: 5px;")
            self.offers_layout.addWidget(discount_label)

        # Add some spacing between the title and the offers layout
        self.layout.addSpacing(10)

        # Add the offers layout to the page layout
        self.layout.addLayout(self.offers_layout)

        font1 = QFont("Verdana", 15)
        font2 = QFont("Verdana", 12)

        # Create a spacer item
        spacer_item = QSpacerItem(20, 40, QSizePolicy.Minimum, QSizePolicy.Expanding)

        # Add terms and conditions warning
        self.terms_box = QGroupBox("Terms and Conditions Applicable")
        self.terms_box.setFont(font1)
        self.layout.addItem(spacer_item)  # Add spacer item before the group box
        self.layout.addWidget(self.terms_box)

        self.terms_layout = QVBoxLayout()
        self.terms_box.setLayout(self.terms_layout)

        self.terms_label = QLabel("Please note that all offers and discounts provided by our company are subject to certain terms and conditions. For instance, the BIRTHDAY10 discount is only applicable to orders placed on your birthday, while the DISCOUNT5 offer can only be used once per customer. The FREESHIP discount is only valid for orders over $50 and only applies to standard shipping, while the NEWCUSTOMER discount is only applicable to first-time customers. The SPRING10 discount is only valid during the spring season and can only be applied to items that are not already on sale, and the SUMMER25 discount is only applicable to orders over $100. We encourage you to carefully review the terms and conditions associated with each offer or discount before applying it to your order.")
        self.terms_label.setFont(font2)
        self.terms_label.setStyleSheet("font-size: 12px; color: red;")
        self.terms_label.setWordWrap(True)
        self.terms_layout.addWidget(self.terms_label)


class ReviewsPage(QWidget):
    def __init__(self, username, parent=None, result=None):
        super().__init__(parent)

        # Set up the UI elements
        self.setWindowTitle("Reviews")
        
        self.setFixedSize(910, 500)
        
        self.username = username

        # Add widgets to the window
        layout = QVBoxLayout()
        
        # Add a QHBoxLayout to hold the buttons
        button_layout = QHBoxLayout()
        
        # Add a spacer to push the buttons to the right
        spacer_item = QSpacerItem(600, 40, QSizePolicy.Expanding, QSizePolicy.Minimum)
        button_layout.addItem(spacer_item)

        # Add My Reviews button
        my_reviews_button = QPushButton('My Reviews')
        my_reviews_button.setObjectName('my_reviews_button')
        my_reviews_button.setStyleSheet("#my_reviews_button { color: white; background-color: black; }")
        my_reviews_button.clicked.connect(lambda: self.show_my_reviews(username))
        button_layout.addWidget(my_reviews_button)

        # Add Provide Your Feedback button
        provide_feedback_button = QPushButton('Provide Your Feedback')
        provide_feedback_button.setObjectName('provide_feedback_button')
        provide_feedback_button.setStyleSheet("#provide_feedback_button { color: white; background-color: black; }")
        provide_feedback_button.clicked.connect(self.show_feedback_page)
        button_layout.addWidget(provide_feedback_button)

        # Add a spacer to push the buttons to the right
        button_layout.addStretch(1)

        # Add the button layout to the main layout
        layout.addLayout(button_layout)

        # Add wine dropdown and label
        wine_label = QLabel('Select a wine:')
        wine_label.setObjectName('wine_label')  
        self.wine_dropdown = QComboBox()
        self.wine_dropdown.currentIndexChanged.connect(self.show_feedback)
        layout.addWidget(wine_label)
        layout.addWidget(self.wine_dropdown)
        
        wine_label.setObjectName("wineLabel")
        wine_label.setStyleSheet("#wineLabel { color: black; font-size: 20px; }")
        self.wine_dropdown.setObjectName("wineDropdown")
        self.wine_dropdown.setStyleSheet("#wineDropdown { color: black; font-size: 16px; }")
        
        # Add the average rating label
        self.average_rating_label = QLabel()
        self.average_rating_label.setObjectName("averageRatingLabel")
        self.average_rating_label.setStyleSheet("#averageRatingLabel { color: black; font-size: 15px; }")
        layout.addWidget(self.average_rating_label)        


        #Add the reviews layout
        self.reviews_layout = QVBoxLayout()
        self.reviews_widget = QWidget()
        self.reviews_widget.setLayout(self.reviews_layout)

        self.scroll_area = QScrollArea()
        self.scroll_area.setWidgetResizable(True)
        self.scroll_area.setWidget(self.reviews_widget)
        layout.addWidget(self.scroll_area)

        
        
        # Add the security notice
        self.security_notice = QLabel(self)
        self.security_notice.setText("Your security is important to us.\nPlease contact us if you have any questions.\n\n© 2023 WineHaven. All rights reserved.")
        self.security_notice.setAlignment(Qt.AlignCenter)
        layout.addWidget(self.security_notice)

        # Set the layout for the QWidget
        self.setLayout(layout)

        # Set the stretch factor of the logo layout to 0
        layout.setStretch(0, 0)

        # Fill the wine names in the combo box
        self.fill_wine_names()

    def fill_wine_names(self):
        # Connect to the database
        conn = make_connection(config_file = 'bossbunch_db.ini')
        cursor = conn.cursor()

        # execute query to get wine names
        cursor.execute('SELECT DISTINCT WineName FROM Wine ORDER BY WineName ASC')
        wine_names = [result[0] for result in cursor.fetchall()]

        # set wine names to the combo box
        self.wine_dropdown.addItems(wine_names)

    def show_feedback(self):
        # Clear the feedback table
        for i in reversed(range(self.reviews_layout.count())):
            self.reviews_layout.itemAt(i).widget().setParent(None)

        # Get the selected wine name
        wine_name = self.wine_dropdown.currentText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()

        # Get the feedback for the selected wine
        cursor.execute('SELECT Rating, Feedback, PurchaseExperience, Username FROM Feedback WHERE WineName = %s', (wine_name,))
        feedback = cursor.fetchall()
        
        
        # Add the feedback to the layout
        for i, row in enumerate(feedback):
            review_text = f"Username: {row[3]}\nWine Rating: {row[0]}\nFeedback: {row[1]}\nPurchase Experience: {row[2]}"
            review_label = QLabel(review_text)
            self.reviews_layout.addWidget(review_label)

        # Calculate the average rating
        ratings = [float(row[0]) for row in feedback]
        if ratings:
            average_rating = sum(ratings) / len(ratings)
            self.average_rating_label.setText(f'Average rating: {average_rating:.1f}')
        else:
            self.average_rating_label.setText('No ratings yet')


        conn.commit()
        conn.close()
        
    def show_feedback_page(self):
        feedback_page = FeedbackPage(username=self.username)
        feedback_page.show()
        feedback_page.exec_()
        
    def show_my_reviews(self, username):
        my_reviews_page = MyReviewsPage(username)
        my_reviews_page.exec_()
 
        
class FeedbackPage(QDialog):
    def __init__(self, username, parent=None, result=None):
        super().__init__(parent)

        # Set window properties
        self.setWindowTitle('Feedback')
        self.setGeometry(100, 100, 400, 400)
        
        self.username = username

        # Add widgets to the window
        layout = QVBoxLayout()

        wine_label = QLabel('Select a wine:')
        self.wine_dropdown = QComboBox()
        layout.addWidget(wine_label)
        layout.addWidget(self.wine_dropdown)

        rating_label = QLabel('Select a rating:')
        self.rating_dropdown = QComboBox()
        layout.addWidget(rating_label)
        layout.addWidget(self.rating_dropdown)

        payment_rating_label = QLabel('Select purchase and payment experience rating:')
        self.payment_rating_dropdown = QComboBox()
        layout.addWidget(payment_rating_label)
        layout.addWidget(self.payment_rating_dropdown)

        feedback_label = QLabel('We would like to hear from you:')
        self.feedback_form = QTextEdit()
        layout.addWidget(feedback_label)
        layout.addWidget(self.feedback_form)

        self.submit_review_button = QPushButton('Submit')
        layout.addWidget(self.submit_review_button)

        # Add the security notice
        self.security_notice = QLabel(self)
        self.security_notice.setText("Your security is important to us.\nPlease contact us if you have any questions.\n\n© 2023 WineHaven. All rights reserved.")
        self.security_notice.setAlignment(Qt.AlignCenter)
        layout.addWidget(self.security_notice)

        # Set the layout for the QWidget
        self.setLayout(layout)

        # Set the stretch factor of the logo layout to 0
        layout.setStretch(0, 0)

        # Fill the wine names in the combo box
        self.fill_wine_names()

        # Set the rating options
        self.rating_dropdown.addItems(['1', '2', '3', '4', '5'])
        self.payment_rating_dropdown.addItems(['1', '2', '3', '4', '5'])

        # Connect the submit button to the submit_review function
        self.submit_review_button.clicked.connect(self.submit_review)

    def fill_wine_names(self):
        # Connect to the database
        conn = make_connection(config_file = 'bossbunch_db.ini')
        cursor = conn.cursor()

        # execute query to get wine names
        cursor.execute('SELECT DISTINCT WineName FROM Wine ORDER BY WineName ASC')
        wine_names = [result[0] for result in cursor.fetchall()]

        # set wine names to the combo box
        self.wine_dropdown.addItems(wine_names)

    def submit_review(self):
        # Get form values
        wine_name = self.wine_dropdown.currentText()
        rating = int(self.rating_dropdown.currentText())
        purchase_rating = int(self.payment_rating_dropdown.currentText())
        feedback = self.feedback_form.toPlainText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()

        # Insert review into the database
        cursor.execute('INSERT INTO Feedback (Winename, Rating, Feedback, PurchaseExperience, Username) VALUES (%s, %s, %s, %s, %s)', (wine_name, rating, feedback, purchase_rating, self.username))

        conn.commit()

        # Clear form fields
        #self.username_field.clear()
        self.wine_dropdown.setCurrentIndex(0)
        self.rating_dropdown.setCurrentIndex(0)
        #self.purchase_rating_dropdown.setCurrentIndex(0)
        self.payment_rating_dropdown.setCurrentIndex(0)
        self.feedback_form.clear()
   
        # Show a message box with a confirmation message
        QMessageBox.information(self, 'Feedback submitted', 'Thank you! Your feedback has been submitted.') 
        
class MyReviewsPage(QDialog):
    def __init__(self, username, parent=None):
        super().__init__(parent)

        # Set window properties
        self.setWindowTitle('My Reviews')
        self.setGeometry(350, 100, 800, 600)

        # Set the current user's username
        self.username = username

        # Connect to the database
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()

        # Retrieve the reviews for the current user from the Feedback table
        query = "SELECT WineName, Rating, Feedback FROM Feedback WHERE Username = %s"
        cursor.execute(query, (username,))
        reviews = cursor.fetchall()

        # Create a table to display the reviews
        self.table = QTableWidget(self)
        self.table.setColumnCount(4)  # added one column delete button
        self.table.setHorizontalHeaderLabels(['Wine Name', 'Rating', 'Feedback', '', ''])
        self.table.setRowCount(len(reviews))

        # Populate the table with the reviews and buttons
        for i, review in enumerate(reviews):
            wine_name, rating, feedback = review
            self.table.setItem(i, 0, QTableWidgetItem(wine_name))
            self.table.setItem(i, 1, QTableWidgetItem(str(rating)))
            self.table.setItem(i, 2, QTableWidgetItem(feedback))
            
            # Set column widths
            self.table.setColumnWidth(0, 200)
            self.table.setColumnWidth(1, 70)
            self.table.setColumnWidth(2, 300)
            self.table.setColumnWidth(3, 70)
            
            self.table.horizontalHeader().setStretchLastSection(True)

            
            # Add Delete button
            delete_btn = QPushButton('Delete', self)
            delete_btn.setProperty('row', i)
            delete_btn.clicked.connect(self.delete_review)
            self.table.setCellWidget(i, 3, delete_btn)

        # Add the table to the layout
        layout = QVBoxLayout()
        layout.addWidget(self.table)

        # Add the security notice
        security_notice = QLabel(self)
        security_notice.setText("Your security is important to us.\nPlease contact us if you have any questions.\n\n© 2023 WineHaven. All rights reserved.")
        security_notice.setAlignment(Qt.AlignCenter)
        layout.addWidget(security_notice)

        # Set the layout for the QWidget
        self.setLayout(layout)

        # Set the stretch factor of the table layout to 1
        layout.setStretch(0, 1)

    def delete_review(self):
        # Get the selected row from the table
        btn = self.sender()
        row = btn.property('row')

        #row = self.table.currentRow()

        if row >= 0:
        # Get the wine name and rating from the selected row
            wine_name = self.table.item(row, 0).text()
            rating = int(self.table.item(row, 1).text())

        # Delete the review from the Feedback table
            conn = make_connection(config_file='bossbunch_db.ini')
            cursor = conn.cursor()
            query = "DELETE FROM Feedback WHERE Username = %s AND WineName = %s AND Rating = %s"
            cursor.execute(query, (self.username, wine_name, rating))
            conn.commit()
            conn.close()

        # Remove the row from the table
            self.table.removeRow(row)
        else:
            QMessageBox.warning(self, 'Error', 'Please select a review to delete.', QMessageBox.Ok)

class WineryReservation(QWidget):
    
        def __init__(self, username, parent=None, result=None):
            super().__init__(parent)
            global CustomerID
            CustomerID = self.get_customer_id(username)
        
#             # Connect to the database and get a cursor
#             self.conn = make_connection(config_file='bossbunch_db.ini')
#             self.cursor = self.conn.cursor()

            # Set the title and window properties
            self.setWindowTitle("Winehaven Reservation")
            self.setFixedSize(910, 500)
            
            # Define the font properties
            font2 = QFont()
            font2.setPointSize(12)
            font2.setBold(True)
            font2.setItalic(True)

            # Create a vertical layout to hold the logo, fields, and buttons
            layout = QVBoxLayout()
            
            # Create the label with the reservation information
            label = QLabel(self)
            label.setAlignment(Qt.AlignCenter)
            label.setText("All tastings are by reservation only and can be booked online. If you are unable to attend your reservation, a transfer to another guest for the same date and time is available only on prior notice. Please see cancellation policy for individual experiences.\n\nDue to the nature of our tastings, we request that all guests be at least 21 years of age except for designated drivers ages 16-20.")
            label.setFont(font2)
            label.setStyleSheet("font-size: 12px; color: black;")
            label.setWordWrap(True)

            # Create a vertical layout to hold the label and other widgets
            layout = QVBoxLayout()
            layout.setAlignment(Qt.AlignCenter)

            # Add the label to the layout
            layout.addWidget(label)

            # Add the Winehaven logo to the top of the page
            self.logo = QLabel(self)
            self.logo.setAlignment(Qt.AlignCenter)

            # Create labels for the name, contact details, and date
            name_label = QLabel('Name:')
            contact_label = QLabel('Contact Details:')
            date_label = QLabel('Time:')
            winery_label = QLabel('Winery Name:')
            #customer_id_label = QLabel('Customer ID:')

            # Create text fields for the name and contact details
            self.name_text = QLineEdit()
            self.contact_text = QLineEdit()

            # Create a time edit widget for the time
            self.time_edit = QTimeEdit()

            # Create a calendar widget for the date
            self.calendar = QCalendarWidget()

            # Create a text box for the customer ID
            #self.customer_id_text = QLineEdit()

            # Create a combo box for the Winery Name
            self.winery_combo = QComboBox()

            # Add winery names to combo box
            cursor.execute("SELECT WineryName FROM Winery")
            winery_names = cursor.fetchall()
            for name in winery_names:
                self.winery_combo.addItem(name[0])

            # Create buttons
            self.make_reservation_button = QPushButton('Make Reservation')
            self.update_reservation_button = QPushButton('Update Reservation')
            self.delete_reservation_button = QPushButton('Cancel Reservation')

            # Connect buttons to functions
            self.make_reservation_button.clicked.connect(self.make_reservation)
            self.update_reservation_button.clicked.connect(self.update_reservation)
            self.delete_reservation_button.clicked.connect(self.delete_reservation)

            # Create the layout for the form widgets
            form_layout = QGridLayout()
            form_layout.addWidget(name_label, 0, 0)
            form_layout.addWidget(self.name_text, 0, 1)
            form_layout.addWidget(contact_label, 1, 0)
            form_layout.addWidget(self.contact_text, 1, 1)
            form_layout.addWidget(date_label, 2, 0)
            form_layout.addWidget(self.calendar, 3, 0, 1, 2)
            form_layout.addWidget(self.time_edit, 2, 1)
            form_layout.addWidget(winery_label, 4, 0)
            form_layout.addWidget(self.winery_combo, 4, 1)
            #form_layout.addWidget(customer_id_label, 4, 2)
            #form_layout.addWidget(self.customer_id_text, 4, 3)

            # Create the layout for the buttons
            button_layout = QHBoxLayout()
            button_layout.addWidget(self.make_reservation_button)
            button_layout.addWidget(self.update_reservation_button)
            button_layout.addWidget(self.delete_reservation_button)

            # Create the layout for the logo and form layout
            logo_form_layout = QVBoxLayout()
            logo_form_layout.addWidget(self.logo)
            logo_form_layout.addLayout(form_layout)

            # Add the logo and form layout to the main layout
            layout.addLayout(logo_form_layout)
            layout.addLayout(button_layout)

            # Set main layout
            self.setLayout(layout)

            # Show window
            self.show()

        def make_reservation(self):
            # Connect to the database
            conn = make_connection(config_file='bossbunch_db.ini')
            cursor = conn.cursor()

            # Get the values from the input fields
            name = self.name_text.text()
            contact = self.contact_text.text()
            winery = self.winery_combo.currentText()
            time = self.time_edit.time().toString("hh:mm")
            date = self.calendar.selectedDate().toString("yyyy-MM-dd")
            r_id = random.randint(100000, 999999)

            # Fetch the customer_id from the Customer table
            customer_name = self.name_text.text()
            cursor.execute('SELECT CustomerID FROM Customer WHERE FirstName=%s', (customer_name,))
            row = cursor.fetchone()
            if row:
                customer_id = row[0]
            else:
                # Handle the case when the customer name is not found
                # You can show an error message or take appropriate action
                QMessageBox.warning(self, 'Customer Not Found', 'Customer name not found in the database.')

            # Insert into reservations table
            cursor.execute("INSERT INTO reservations (r_id, name, contact_details, time, date, CustomerID, winery_name) VALUES (%s, %s, %s, %s, %s, %s, %s)",(r_id, name, contact, time, date, customer_id, winery))
            conn.commit()

            # Close the database connection
            conn.close()

            # Show a message box with a confirmation message
            QMessageBox.information(self, 'Reservation Made', f'Thank you! Reservation Made. Your reservation ID is {r_id}.')

        def update_reservation(self):
            r_id, ok = QInputDialog.getInt(self, "Enter Reservation ID", "Reservation ID:")
            if ok:
                cursor = conn.cursor()
                cursor.execute('SELECT * FROM reservations WHERE r_id=%s', (r_id,))
                row = cursor.fetchone()
            if row is not None:
                winery_name, ok = QInputDialog.getText(self, "Enter Winery Name", "Winery Name:", text=row[1])
            if ok:
                date_str = row[2]
                date, ok = QInputDialog.getText(self, "Enter Reservation Date", "Reservation Date (YYYY-MM-DD):", text=date_str)
                if ok:
                    time_str = row[3]
                    time, ok = QInputDialog.getText(self, "Enter Reservation Time", "Reservation Time (HH:MM):", text=time_str)
                    if ok:
                        try:
                            cursor.execute("UPDATE reservations SET winery_name=%s, date=%s, time=%s WHERE r_id=%s", (winery_name, date, time, r_id))
                            conn.commit()
                            QMessageBox.information(self, "Reservation Updated", "Reservation has been updated successfully!")
                        except Exception as e:
                            QMessageBox.warning(self, "Update Error", f"An error occurred while updating the reservation: {str(e)}")
            else:
                QMessageBox.warning(self, "Reservation Not Found", f"No reservation found with ID {r_id}.")

        def delete_reservation(self):
            # Get the reservation ID from the user
            reservation_id, ok = QInputDialog.getInt(self, 'Delete Reservation', 'Enter Reservation ID:')
    
            if ok:
                # Connect to the database
                conn = make_connection(config_file='bossbunch_db.ini')
                cursor = conn.cursor()
        
                # Check if the reservation exists in the database
                cursor.execute('SELECT * FROM reservations WHERE r_id = %s', (reservation_id,))
                reservation = cursor.fetchone()
        
                if reservation is not None:
                    # Confirm with the user before deleting the reservation
                    reply = QMessageBox.question(self, 'Delete Reservation', f'Are you sure you want to delete reservation {reservation_id}?', QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
            
                if reply == QMessageBox.Yes:
                    # Delete the reservation from the database
                    cursor.execute('DELETE FROM reservations WHERE r_id = %s', (reservation_id,))
                    conn.commit()
                
                    # Show a message box with a confirmation message
                    QMessageBox.information(self, 'Reservation Deleted', f'Thank you! Reservation Deleted.')
                
                else:
                    # Show a message box indicating that the deletion was cancelled
                    QMessageBox.information(self, 'Reservation Deletion Cancelled', 'Reservation deletion was cancelled.')
        
            else:
                # Show a message box indicating that the reservation was not found in the database
                QMessageBox.warning(self, 'Reservation Not Found', f'Reservation {reservation_id} was not found in the database.')
        
            # Close the database connection
            conn.close()
            
        def get_customer_id(self, username):
            cursor = conn.cursor()
            cursor.execute('SELECT CustomerID FROM Customer WHERE FirstName = %s', (username,))
            row = cursor.fetchone()
            if row:
                return row[0]
       
            else:
                return None

# Start the application and display the login page
if __name__ == '__main__':
    app = QApplication([])

    # Define the colors for the Winehaven app
    palette = {
        "primary": "#703030",   # dark red
        "secondary": "#D4AF37", # gold
        "tertiary": "#F2E6DE",  # light peach
        "background": "#F8F6F7", # off white
        "text": "#000000"       # black
    }

    # Define the custom palette for the app
    q_palette = QPalette()
    q_palette.setColor(QPalette.Window, QColor(palette["background"]))
    q_palette.setColor(QPalette.WindowText, QColor(palette["text"]))
    q_palette.setColor(QPalette.Base, QColor(palette["tertiary"]))
    q_palette.setColor(QPalette.AlternateBase, QColor(palette["background"]))
    q_palette.setColor(QPalette.ToolTipBase, QColor(palette["text"]))
    q_palette.setColor(QPalette.ToolTipText, QColor(palette["background"]))
    q_palette.setColor(QPalette.Text, QColor(palette["text"]))
    q_palette.setColor(QPalette.Button, QColor(palette["tertiary"]))
    q_palette.setColor(QPalette.ButtonText, QColor(palette["text"]))
    q_palette.setColor(QPalette.BrightText, QColor(palette["background"]))
    q_palette.setColor(QPalette.Link, QColor(palette["secondary"]))
    q_palette.setColor(QPalette.Highlight, QColor(palette["secondary"]))
    q_palette.setColor(QPalette.HighlightedText, QColor(palette["background"]))
    
    app.setPalette(q_palette)

    # Define a stylesheet for the Winehaven app
    stylesheet = f"""
    /* Set the style for QToolTip */
    QToolTip {{
    color: {palette["text"]};
    background-color: {palette["background"]};
    }}

    /* Set the style for QComboBox */
    QComboBox {{
    color: {palette["text"]};
    background-color: {palette["tertiary"]};
    border-style: solid;
    border-width: 1px;
    border-color: {palette["secondary"]};
    border-radius: 3px;
    padding: 2px 18px 2px 3px;
    min-width: 6em;
    }}

    QComboBox::drop-down {{
    subcontrol-origin: padding;
    subcontrol-position: top right;
    width: 18px;
    border-left-width: 1px;
    border-left-color: {palette["secondary"]};
    border-left-style: solid;
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
    background-color: {palette["tertiary"]};
    }}
    
    /* Set the style for QComboBox when it is pressed */
    QComboBox:pressed {{
        background-color: {palette["primary"]};
        color: {palette["background"]};
        border-color: {palette["primary"]};
    }}

    QComboBox QAbstractItemView {{
    color: {palette["text"]};
    background-color: {palette["tertiary"]};
    selection-color: {palette["background"]};
    selection-background-color: {palette["secondary"]};
    outline: none;
    }}
    
    /* Set the style for QComboBox's expand arrow */
    QComboBox::down-arrow {{
        image: url('arrow-down.png');
        width: 10px;
        height: 10px;
    }}

    /* Set the style for QTabWidget */
    QTabWidget {{
    background-color: {palette["tertiary"]};
    }}

    /* Set the style for QTabWidget when it is not selected and the mouse is hovering over it */
    QTabWidget::tab:hover {{
    background-color: {palette["secondary"]};
    }}

    /* Set the style for QTabWidget when it is selected */
    QTabWidget::tab:selected {{
    background-color: {palette["secondary"]};
    }}

    QTabWidget::tab:!selected {{
    margin-top: 2px;
    }}

    QTabBar::tab {{
    background-color: {palette["tertiary"]};
    border-style: solid;
    border-width: 1px;
    border-color: {palette["secondary"]};
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    padding: 4px;
    }}

    QTabBar::tab:selected {{
    background-color: {palette["secondary"]};
    border-style: solid;
    border-width: 1px;
    border-color: {palette["secondary"]};
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    padding: 4px;
    }}

    /* Set the style for QPushButton */
    QPushButton {{
    color: {palette["text"]};
    background-color: {palette["tertiary"]};
    border-style: solid;
    border-width: 1px;
    border-color: {palette["secondary"]};
    border-radius: 3px;
    padding: 2px 8px;
    min-width: 6em;
    }}

    QPushButton:hover {{
    background-color: {palette["secondary"]};
    }}

    /* Set the style for QLineEdit */
    QLineEdit {{
    color: {palette["text"]};
    background-color: {palette["background"]};
    border-style: solid;
    border-width: 1px;
    border-color: {palette["secondary"]};
    border-radius: 3px;
    padding: 2px 8px;
    }}

    QLineEdit:focus {{
    border-color: {palette["secondary"]};
    }}

    /* Set the style for QLabel */
    QLabel {{
    color: {palette["text"]};
    }}
    
    /* Set the style for QCalendarWidget header */
    QCalendarWidget QWidget {{
        alternate-background-color: {palette["tertiary"]};
        background: {palette["tertiary"]};
    }}
    
    QCalendarWidget QToolButton {{
        color: {palette["text"]};
        background-color: {palette["tertiary"]};
    }}

    QCalendarWidget QMenu QAbstractItemView {{
        color: {palette["text"]};
    }}
    
    /* Set the style for QCalendarWidget */
    QCalendarWidget QAbstractItemView:enabled {{
        color: {palette["text"]};
    }}

    QCalendarWidget QTableView {{
        color: {palette["text"]};
        selection-color: {palette["text"]};
        selection-background-color: {palette["secondary"]};
    }}

    QCalendarWidget QTableView QTableCornerButton::section {{
        background-color: {palette["tertiary"]};
    }}
    
    /* Set the style for QCalendarWidget Month and Year text */
    QCalendarWidget QMenu QAbstractItemView {{
        color: {palette["text"]};
    }}
    """

    app.setStyleSheet(stylesheet)

    login = Login()
    login.show()
    app.exec_()
    conn.close()
    cursor.close()