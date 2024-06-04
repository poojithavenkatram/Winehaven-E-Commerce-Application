# Import necessary Qt libraries
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QVBoxLayout, QHBoxLayout, QCheckBox, QMessageBox, QListWidget, QListWidgetItem, QScrollArea, QDialog, QInputDialog, QSpacerItem, QSizePolicy, QTableWidget, QTableWidgetItem, QAbstractItemView, QHeaderView, QFormLayout, QComboBox, QGroupBox, QDateEdit, QTextEdit, QGridLayout, QDoubleSpinBox, QSpinBox, QMainWindow, QTabWidget,  QTimeEdit, QCalendarWidget, QGraphicsTextItem, QGraphicsScene,QSplitter
from PyQt5.QtGui import QPixmap, QFont, QPalette, QPainter, QTransform, QImage, QColor, QIcon
from PyQt5.QtCore import Qt, QDate, QSettings, QRect, QPropertyAnimation, QSize, QTime, QPointF, QEvent, QPoint
from PyQt5.QtChart import QBarSet, QBarSeries, QChart, QChartView, QBarCategoryAxis, QValueAxis, QStackedBarSeries
from datetime import date, datetime
import numpy as np
import time
import pymysql
import random
import urllib.request
from datetime import datetime
import matplotlib.pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from DATA225utils import make_connection
from RevenueAnalysis import RevenueAnalysis
from Dashboard2 import *
from Dashboard5 import *
from WineAnalysisDashboard import *

# Create a connection to the database using the config file
conn = make_connection(config_file='bossbunch_wh.ini')
cursor = conn.cursor()

class Login(QWidget):
    def __init__(self):
        super().__init__()

        # Set the title and window properties
        self.setWindowTitle("Cellar Insights Winehaven - Login")
        self.setFixedSize(500, 620)

        # Create a vertical layout to hold the logo, fields, and buttons
        layout = QVBoxLayout()
        
        # Add the Winehaven logo to the top of the page
        self.logo = QLabel(self)
        pixmap = QPixmap("cellarinsights_logo.png")
        scaled_pixmap = pixmap.scaled(self.size() * 0.8, Qt.KeepAspectRatio, Qt.SmoothTransformation)
        self.logo.setPixmap(scaled_pixmap)
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


        # Add the buttons layouts to the vertical layout
        layout.addSpacing(20)
        layout.addWidget(self.logo)
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addLayout(username_layout)
        layout.addLayout(password_layout)
        layout.addSpacerItem(spacer_item) # Add the spacer item
        layout.addLayout(buttons_layout)
        layout.addSpacerItem(spacer_item) # Add the spacer item

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

        query = "SELECT * FROM Admin WHERE Username=%s AND Password=%s"

        cursor.execute(query, (self.username, self.password))
        result = cursor.fetchone()

        if result is not None:
            emp_id = result[2]

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

            home_page = HomePage(self.username, emp_id)
            home_page.show()
            home_page.exec_()
        else:
            QMessageBox.warning(self, "Error", "Invalid username or password.", QMessageBox.Ok)
            
    def reset_password(self):
        # Get the username from the username field
        username = self.username_field.text()

        # Retrieve the security question and answer for the user
        query = "SELECT SecurityQuestion, SecurityAnswer FROM Admin WHERE Username=%s"
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
                    update_query = "UPDATE Admin SET Password=%s WHERE Username=%s"
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


class HomePage(QDialog):
    def __init__(self, username, emp_id):
        super().__init__()

        # Save the username and emp_id as instance variables
        self.username = username
        self.emp_id = emp_id

        # Set the title and window properties
        self.setWindowTitle("Winehaven Home")
        self.setFixedSize(1000, 600)

        # Create a QTabWidget to hold the tabs
        self.tab_widget = QTabWidget(self)

        # Add a Home tab
        self.home_tab = QWidget()
        self.home_tab_layout = QVBoxLayout()
        self.home_tab.setLayout(self.home_tab_layout)

        
        # Add an Analytics Tab 1
        self.analytics_tab1 = QWidget()
        self.analytics_tab1_layout = QVBoxLayout() # Changed to QVBoxLayout
        self.analytics_tab1.setLayout(self.analytics_tab1_layout)
        
        # Create the dashboard in Tab 1
        self.create_dashboard_tab1()

        # Add an Analytics Tab 2
        self.analytics_tab2 = QWidget()
        self.analytics_tab2_layout = QVBoxLayout()
        self.analytics_tab2.setLayout(self.analytics_tab2_layout)
        
        self.dashboard_2 = Dashboard2()
        self.analytics_tab2_layout.addWidget(self.dashboard_2)

        # Add an Analytics Tab 3
        self.analytics_tab3 = QWidget()
        self.analytics_tab3_layout = QVBoxLayout()
        self.analytics_tab3.setLayout(self.analytics_tab3_layout)
        
        self.analytics_tab3 = RevenueAnalysis()

        # Add an Analytics Tab 4
        self.analytics_tab4 = QWidget()
        self.analytics_tab4_layout = QVBoxLayout()
        self.analytics_tab4.setLayout(self.analytics_tab4_layout)
        
        self.dashboard_4 = WineAnalysisDashboard()
        self.analytics_tab4_layout.addWidget(self.dashboard_4)
        
        
         # Add an Analytics Tab 5
        self.analytics_tab5 = QWidget()
        self.analytics_tab5_layout = QVBoxLayout()
        self.analytics_tab5.setLayout(self.analytics_tab5_layout)
        
        self.dashboard_5 = Dashboard5()
        self.analytics_tab5_layout.addWidget(self.dashboard_5)

        # Add tabs
        self.tab_widget.addTab(self.home_tab, "Home")
        self.tab_widget.addTab(self.analytics_tab3, "Revenue Tracking")
        self.tab_widget.addTab(self.analytics_tab1, "Marketing Insights")
        self.tab_widget.addTab(self.analytics_tab5, "Inventory Alerts")
        self.tab_widget.addTab(self.analytics_tab4, "Wine Sales")
        self.tab_widget.addTab(self.analytics_tab2, "Discount Analysis")
        
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

        self.home_content = QLabel(self)
        self.home_content.setAlignment(Qt.AlignCenter)
        self.home_content.setWordWrap(True)  # Enable word wrapping
        self.home_content.setTextFormat(Qt.RichText)  # Interpret the text as rich text
        self.home_content.setText("<b>Welcome to the Cellar Insights analytical tool for Winehaven!</b> <break>"
                                  "This application is designed to empower our employees with data-driven insights "
                                  "to better serve our customers and improve our business operations. "
                                  "Here are some of the features you'll find:")
        self.home_tab_layout.addWidget(self.home_content)

        self.home_content_2 = QLabel(self)
        self.home_content_2.setAlignment(Qt.AlignLeft)
        self.home_content_2.setWordWrap(True)  # Enable word wrapping
        self.home_content_2.setTextFormat(Qt.RichText)  # Interpret the text as rich text

        list_text = """
        <p style='line-height:100%; margin:0; padding:0;'>
        <ol>
        <li><b>Revenue Tracking:</b> Keep a close eye on our financial performance over the years. Understand the factors that drive our revenues and use this knowledge to improve our profitability.</li>
        <li><b>Marketing Insights:</b> Evaluate the effectiveness of our marketing campaigns and events. Learn what works and what doesn't and optimize our marketing efforts accordingly.</li>
        <li><b>Inventory Management:</b> Stay updated on our wine inventory. Monitor stock levels and ensure we're well-equipped to meet our customer demands at all times.</li>
        <li><b>Wine Sales Analysis:</b> Gain insights into our customers' ordering patterns and their preferred choices using rating, feedback data. Use this to improve our offerings and enhance customer satisfaction.</li>
        <li><b>Offers & Promotions:</b> Analyze the success of our offers and promotions. Learn what appeals to our customers and plan our future strategies accordingly.</li>
        </ol>
        """

        self.home_content_2.setText(list_text)
        self.home_tab_layout.addWidget(self.home_content_2)
        
        # Create a QFont object and set the font family to Verdana
        verdana_font = QFont("Verdana", 13)

        # Set the font for the QLabel
        self.home_content.setFont(verdana_font)
        self.home_content_2.setFont(verdana_font)
        
        self.home_content.setStyleSheet("margin:0px; padding:0px;")
        self.home_content_2.setStyleSheet("margin:0px; padding:0px;");

        # Add a logout button to the Home tab
        logout_button = QPushButton("Logout")
        logout_button.clicked.connect(self.logout)
        self.home_tab_layout.addWidget(logout_button)

    def create_dashboard_tab1(self):
        # Create the performance dashboard in Tab 1
        self.performance_dashboard = self.create_performance_dashboard()

        # Add the performance_dashboard to the layout
        self.analytics_tab1_layout.addWidget(self.performance_dashboard)

        # Set the layout for this widget
        self.analytics_tab1.setLayout(self.analytics_tab1_layout)

    def create_performance_dashboard(self):
        # Create a new widget for the performance dashboard
        self.performance_dashboard = QWidget()
        performance_dashboard_layout = QVBoxLayout()
        self.performance_dashboard.setLayout(performance_dashboard_layout)

        # Add the chart view canvas with filters to the layout
        self.performance_chart_view, filter_widget = self.create_dashboard_chart_view_with_filters()
        performance_dashboard_layout.addWidget(self.performance_chart_view)

        # Add the filter widget to the layout
        performance_dashboard_layout.addWidget(filter_widget)

        # Return the performance dashboard widget
        return self.performance_dashboard

    def create_dashboard_chart_view_with_filters(self):
        # Create a new figure for the chart
        fig = plt.figure(figsize=(10, 3))
        
        # Create a subplot for each chart
        self.fig = plt.figure(figsize=(5, 3))
        self.fig.subplots_adjust(wspace=0.7, hspace=0.6)  # Adjust as needed
        self.ax1 = self.fig.add_subplot(221)
        self.ax2 = self.fig.add_subplot(222)
        self.ax3 = self.fig.add_subplot(223)
        self.ax4 = self.fig.add_subplot(224)
        
        plt.style.use('tableau-colorblind10')
        
        # Line chart for total marketing revenue over years
        cursor.execute("SELECT Year, SUM(Revenue) FROM RevenuePerEvent JOIN MarketingEvent ON RevenuePerEvent.EventKey = MarketingEvent.EventKey GROUP BY Year ORDER BY Year")
        result = cursor.fetchall()
        years = [row[0] for row in result]
        revenues = [row[1] for row in result]
        self.ax1.plot(years, revenues, marker="o")
        self.ax1.set_xlabel("Year")
        self.ax1.set_ylabel("Revenue")
        self.ax1.set_title("Total Marketing Revenue Over Years")
        self.ax1.set_ylim(ymin=0)
        
        
        # Get the total number of attendees and RSVPs for each event
        cursor.execute("SELECT EventName, SUM(Attendees), SUM(RSVPs) FROM MarketingEvent GROUP BY EventName;")
        result = cursor.fetchall()
        event_attendees_rsvps = {}
        for row in result:
            event_attendees_rsvps[row[0]] = {"attendees": row[1], "rsvps": row[2]}

        # Horizontal stacked bar chart for total attendees and RSVPs
        total_attendees = sum([event_attendees_rsvps[event]["attendees"] for event in event_attendees_rsvps])
        total_rsvps = sum([event_attendees_rsvps[event]["rsvps"] for event in event_attendees_rsvps])
        self.ax2.barh("Attendees", total_attendees, color="#008fd5", label="Attendees")
        self.ax2.barh("RSVPs", total_rsvps, color="#fc4f30", label="RSVPs")
        self.ax2.set_xlabel("Count")
        self.ax2.set_ylabel("")
        self.ax2.set_title("Total Attendees and RSVPs")
        self.ax2.set_xlim(xmin=0)

        
        # Get the performance of employees based on the revenue they generated
        cursor.execute("SELECT EmployeeName, SUM(Revenue), AVG(EmployeeRating) FROM Employee JOIN RevenuePerEvent ON Employee.EmployeeKey = RevenuePerEvent.EmployeeKey GROUP BY EmployeeName;")
        result = cursor.fetchall()

        # Create a dictionary with employee names as keys
        employee_revenue_rating = {row[0]: {"revenue": row[1], "rating": float(row[2])} for row in result}  # Convert ratings to float

        # Sort the dictionary based on revenue and get the top 4 employees
        top_employees = sorted(employee_revenue_rating.items(), key=lambda item: item[1]["revenue"], reverse=True)[:4]

        # Horizontal bar chart for employee performance based on revenue
        employee_names = [employee[0] for employee in top_employees]
        revenues = [employee[1]["revenue"] for employee in top_employees]
        ratings = [employee[1]["rating"] for employee in top_employees]
        
        # Normalize the ratings to fit in color map
        max_rating = max(ratings)
        min_rating = min(ratings)
        norm = plt.Normalize(min_rating, max_rating)
        cmap = plt.get_cmap("coolwarm")  # Choose a color map
        
        from mpl_toolkits.axes_grid1 import make_axes_locatable

        # Create a horizontal bar chart, color based on ratings
        self.ax3.barh(employee_names, revenues, color=cmap(norm(ratings)))

        # Create a ScalarMappable object for the colorbar
        sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
        sm.set_array([])  # This line is necessary for matplotlib versions prior to 3.1.0

        divider = make_axes_locatable(self.ax3)
        cax = divider.append_axes('right', size='5%', pad=0.05)

        # Add colorbar, using the ScalarMappable object
        self.fig.colorbar(sm, cax=cax, orientation='vertical')

        self.ax3.set_xlabel("Revenue")
        self.ax3.set_title("Top 4 Employee Performance")

   
        # Scatter plot for Free Tastings and Revenue
        cursor.execute("SELECT FreeTastings, Revenue FROM MarketingEvent JOIN RevenuePerEvent ON MarketingEvent.EventKey = RevenuePerEvent.EventKey")
        result = cursor.fetchall()
        # Convert decimal.Decimal to float
        free_tastings = np.array([float(str(row[0])) for row in result])
        revenues = np.array([float(str(row[1])) for row in result])
        self.ax4.scatter(free_tastings, revenues)
        self.ax4.set_xlabel("Free Tastings")
        self.ax4.set_ylabel("Revenue")
        self.ax4.set_title("Free Tastings and Revenue Correlation")

        # Fit a linear regression line to the scatter plot data
        m, b = np.polyfit(free_tastings, revenues, 1)
        self.ax4.plot(free_tastings, m * free_tastings + b, color='red')

        # Use tight_layout to automatically adjust the layout of the charts
        fig.tight_layout()

        # Create a FigureCanvas that wraps the figure
        self.chart_view = FigureCanvas(self.fig)

        # Create filter widgets and layout
        filter_widget = QWidget()
        filter_layout = QHBoxLayout()
        filter_widget.setLayout(filter_layout)

        # Create a widget for each pair of label and combo box
        year_widget = QWidget()
        year_layout = QHBoxLayout()
        year_widget.setLayout(year_layout)

        quarter_widget = QWidget()
        quarter_layout = QHBoxLayout()
        quarter_widget.setLayout(quarter_layout)

        event_widget = QWidget()
        event_layout = QHBoxLayout()
        event_widget.setLayout(event_layout)

        # Year
        year_label = QLabel("Year:")
        year_combo_box = QComboBox()
        cursor.execute("SELECT DISTINCT Year FROM MarketingEvent;")
        years = [str(row[0]) for row in cursor.fetchall()]
        years.insert(0, "All Years")
        year_combo_box.addItems(years)
        year_layout.addWidget(year_label)
        year_layout.addWidget(year_combo_box)
        
        # Event
        event_label = QLabel("Event:")
        event_combo_box = QComboBox()
        cursor.execute("SELECT DISTINCT EventName FROM MarketingEvent;")
        events = [row[0] for row in cursor.fetchall()]
        events.insert(0, "All Events")
        event_combo_box.addItems(events)
        event_layout.addWidget(event_label)
        event_layout.addWidget(event_combo_box)

        # Add to the filter layout
        filter_layout.addWidget(year_widget)
        filter_layout.addWidget(quarter_widget)
        filter_layout.addWidget(event_widget)

        # Centering the layout
        filter_layout.setAlignment(Qt.AlignCenter)

        year_combo_box.currentIndexChanged.connect(lambda: self.update_dashboard(event_combo_box.currentText(), year_combo_box.currentText()))
        event_combo_box.currentIndexChanged.connect(lambda: self.update_dashboard(event_combo_box.currentText(), year_combo_box.currentText()))

        # Set the size policies of the chart view and filter widget
        self.chart_view.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        filter_widget.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)

        # Return the chart view and filter widget
        return self.chart_view, filter_widget
    
    def update_dashboard(self, event, year):
        quarter = "Choose Quarter"
        
        # Scenario 1: A specific year and event are chosen
        if event != "All Events" and year != "All Years" and quarter == "Choose Quarter":
            # Clear the previous data from the plots
            self.ax1.clear()
            self.ax2.clear()
            
            # Get the revenue for the chosen event in the chosen year
            cursor.execute(f"SELECT Revenue FROM RevenuePerEvent, MarketingEvent WHERE RevenuePerEvent.EventKey = MarketingEvent.EventKey AND MarketingEvent.EventName = '{event}' AND MarketingEvent.Year = {year};")
            revenue = cursor.fetchone()

            # If no data available
            if revenue is None or revenue[0] is None:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Information)
                msg.setText("No revenue data available for the selected Year and Event. (This Event was not held in the selected Year)")
                msg.setWindowTitle("Info")
                msg.exec_()
                return  # Return here

            # Bar chart for revenue for the chosen event in the chosen year
            self.ax1.bar(year, revenue[0])
            self.ax1.set_ylabel("Revenue")
            self.ax1.set_title(f"Revenue for {event} in {year}")
            self.ax1.set_ylim(ymin=0)
            self.performance_chart_view.draw()

            # Get the total number of attendees and RSVPs for the chosen event in the chosen year
            cursor.execute(f"SELECT Attendees, RSVPs FROM MarketingEvent WHERE EventName = '{event}' AND Year = {year};")
            result = cursor.fetchone()

            # If no data available
            if result is None or result[0] is None or result[1] is None:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Information)
                msg.setText("No attendees or RSVPs data available for the selected Year and Event. (This Event was not held in the selected Year)")
                msg.setWindowTitle("Info")
                msg.exec_()
                return  # Return here

            attendees, rsvps = result
            
            # Bar chart for total attendees and RSVPs for the chosen event in the chosen year
            labels = ["Attendees", "RSVPs"]
            values = [attendees, rsvps]
            indices = range(len(labels))

            self.ax2.bar(indices, values, color=["#008fd5", "#fc4f30"])
            self.ax2.set_xticks(indices)
            self.ax2.set_xticklabels(labels)
            self.ax2.set_xlabel("")
            self.ax2.set_ylabel("Count")
            self.ax2.set_title(f"Attendees and RSVPs for {event} in {year}")
            self.ax2.set_ylim(ymin=0)
            self.performance_chart_view.draw()

        # Scenario 2: When "All Events" and a particular year is chosen
        elif event == "All Events" and year != "All Years" and quarter == "Choose Quarter":
            # Update the first chart with revenue per event for the chosen year
            cursor.execute(f"SELECT EventName, SUM(Revenue) FROM RevenuePerEvent JOIN MarketingEvent ON RevenuePerEvent.EventKey = MarketingEvent.EventKey WHERE Year='{year}' GROUP BY EventName")
            result = cursor.fetchall()

            events = [row[0] for row in result]
            revenues = [row[1] for row in result]
            self.ax1.clear()
            self.ax1.bar(events, revenues)
            self.ax1.set_ylabel("Revenue")
            self.ax1.set_title("Total Marketing Revenue Per Event for Year "+year)
            self.ax1.set_ylim(ymin=0)
            self.ax1.set_xticks(range(len(events)))
            self.ax1.set_xticklabels(events, rotation=45, fontsize=5)
            self.performance_chart_view.draw()

            # Update the second chart with total attendees and rsvps per event for the chosen year
            cursor.execute(f"SELECT EventName, SUM(Attendees), SUM(RSVPs) FROM MarketingEvent WHERE Year='{year}' GROUP BY EventName")
            result = cursor.fetchall()

            events = [row[0] for row in result]
            attendees = [row[1] for row in result]
            rsvps = [row[2] for row in result]
            self.ax2.clear()
            self.ax2.bar(events, attendees, label="Attendees")
            self.ax2.bar(events, rsvps, label="RSVPs")
            self.ax2.set_ylabel("Count")
            self.ax2.set_title("Total Attendees and RSVPs Per Event for Year "+year)
            self.ax2.set_ylim(ymin=0)
            self.ax2.set_xticks(range(len(events)))
            self.ax2.set_xticklabels(events, rotation=45, fontsize=5)
            self.ax2.legend()
            self.performance_chart_view.draw()
        
        # Scenario 3: One event alone is chosen, Years = "All Years" and Quarter = "Choose Quarter"
        elif event != "All Events" and year == "All Years" and quarter == "Choose Quarter":
            # Execute query to fetch revenue per year for the chosen event
            cursor.execute(f"SELECT Year, SUM(Revenue) FROM RevenuePerEvent JOIN MarketingEvent ON RevenuePerEvent.EventKey = MarketingEvent.EventKey WHERE EventName='{event}' GROUP BY Year")
            result = cursor.fetchall()
            
            if not result:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Information)
                msg.setText("No data available for the selected time and event2222.")
                msg.setWindowTitle("Info")
                msg.exec_()
                return
            else:
                years = [row[0] for row in result]
                revenues = [row[1] for row in result]
                self.ax1.clear()
                bars = self.ax1.bar(years, revenues)
                self.ax1.set_xlabel("Year")
                self.ax1.set_ylabel("Revenue")
                self.ax1.set_title("Total Marketing Revenue Over Years")
                self.ax1.set_ylim(ymin=0)

                # Set the x-ticks to be the x-coordinates of the bars
                self.ax1.set_xticks([bar.get_x() + bar.get_width() / 2 for bar in bars])

                # Set the x-tick labels to be the years, and set their size to a smaller value
                self.ax1.set_xticklabels(years, fontsize='small')

                self.performance_chart_view.draw()

            # Total attendees and RSVPs for the chosen event over the specified time period
            cursor.execute(f"SELECT SUM(Attendees), SUM(RSVPs) FROM MarketingEvent WHERE EventName='{event}'")
            result = cursor.fetchall()
            # If no data available
            if not result:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Information)
                msg.setText("No data available for the selected Year and Event. (This Event was not held in the selected Year)")
                msg.setWindowTitle("Info")
                msg.exec_()
                return  # Return here
            else:
                attendees = result[0][0]
                rsvps = result[0][1]
                self.ax2.clear()
                attendees_bar = self.ax2.barh(["Attendees"], [attendees], color="#008fd5")
                rsvps_bar = self.ax2.barh(["RSVPs"], [rsvps], color="#fc4f30")
                self.ax2.set_xlabel("Count")
                self.ax2.set_ylabel("")
                self.ax2.set_title("Total Attendees and RSVPs")
                self.ax2.set_xlim(xmin=0)
                self.performance_chart_view.draw()

        # Scenario 4: When All Events are chosen, Years = "All Years" and Quarter = "Choose Quarter"
        elif event == "All Events" and year == "All Years" and quarter == "Choose Quarter":
            cursor.execute(f"SELECT Year, SUM(Revenue) FROM RevenuePerEvent JOIN MarketingEvent ON RevenuePerEvent.EventKey = MarketingEvent.EventKey GROUP BY Year")
            result = cursor.fetchall()
            
            years = [row[0] for row in result]
            revenues = [row[1] for row in result]
            self.ax1.clear()
            self.ax1.plot(years, revenues, marker="o")
            self.ax1.set_xlabel("Year")
            self.ax1.set_ylabel("Revenue")
            self.ax1.set_title("Total Marketing Revenue Over Years")
            self.ax1.set_ylim(ymin=0)
            self.performance_chart_view.draw()

            # the second chart shows total attendees and RSVPs for all events over all years
            cursor.execute(f"SELECT SUM(Attendees), SUM(RSVPs) FROM MarketingEvent")
            result = cursor.fetchall()

            attendees = result[0][0]
            rsvps = result[0][1]
            self.ax2.clear()
            attendees_bar = self.ax2.barh(["Attendees"], [attendees], color="#008fd5")
            rsvps_bar = self.ax2.barh(["RSVPs"], [rsvps], color="#fc4f30")
            self.ax2.set_xlabel("Count")
            self.ax2.set_ylabel("")
            self.ax2.set_title("Total Attendees and RSVPs")
            self.ax2.set_xlim(xmin=0)
            self.performance_chart_view.draw()
        

        # Get the performance of employees based on the revenue they generated
        cursor.execute("SELECT EmployeeName, SUM(Revenue), AVG(EmployeeRating) FROM Employee JOIN RevenuePerEvent ON Employee.EmployeeKey = RevenuePerEvent.EmployeeKey GROUP BY EmployeeName;")
        result = cursor.fetchall()

        # Create a dictionary with employee names as keys
        employee_revenue_rating = {row[0]: {"revenue": row[1], "rating": float(row[2])} for row in result}  # Convert ratings to float

        # Sort the dictionary based on revenue and get the top 4 employees
        top_employees = sorted(employee_revenue_rating.items(), key=lambda item: item[1]["revenue"], reverse=True)[:4]

        # Horizontal bar chart for employee performance based on revenue
        employee_names = [employee[0] for employee in top_employees]
        revenues = [employee[1]["revenue"] for employee in top_employees]
        ratings = [employee[1]["rating"] for employee in top_employees]

        # Normalize the ratings to fit in color map
        max_rating = max(ratings)
        min_rating = min(ratings)
        norm = plt.Normalize(min_rating, max_rating)
        cmap = plt.get_cmap("coolwarm")  # Choose a color map

        from mpl_toolkits.axes_grid1 import make_axes_locatable

        # Create a horizontal bar chart, color based on ratings
        self.ax3.barh(employee_names, revenues, color=cmap(norm(ratings)))

        # Create a ScalarMappable object for the colorbar
        sm = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
        sm.set_array([])  # This line is necessary for matplotlib versions prior to 3.1.0

        divider = make_axes_locatable(self.ax3)
        cax = divider.append_axes('right', size='5%', pad=0.05)

        # Add colorbar, using the ScalarMappable object
        self.fig.colorbar(sm, cax=cax, orientation='vertical')

        self.ax3.set_xlabel("Revenue")
        self.ax3.set_title("Top 4 Employee Performance")


        # Scatter plot for Free Tastings and Revenue
        cursor.execute("SELECT FreeTastings, Revenue FROM MarketingEvent JOIN RevenuePerEvent ON MarketingEvent.EventKey = RevenuePerEvent.EventKey")
        result = cursor.fetchall()
        # Convert decimal.Decimal to float
        free_tastings = np.array([float(str(row[0])) for row in result])
        revenues = np.array([float(str(row[1])) for row in result])
        self.ax4.clear()
        self.ax4.scatter(free_tastings, revenues)
        self.ax4.set_xlabel("Free Tastings")
        self.ax4.set_ylabel("Revenue")
        self.ax4.set_title("Free Tastings and Revenue Correlation")
        m, b = np.polyfit(free_tastings, revenues, 1)
        self.ax4.plot(free_tastings, m * free_tastings + b, color='red')
        self.performance_chart_view.draw()

        # Fit a linear regression line to the scatter plot data
        m, b = np.polyfit(free_tastings, revenues, 1)
        self.ax4.plot(free_tastings, m * free_tastings + b, color='red')
        
        self.performance_chart_view.draw()
        
        # Function to log out and return to the login page
    def logout(self):
        self.close()
        login.show()
        

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