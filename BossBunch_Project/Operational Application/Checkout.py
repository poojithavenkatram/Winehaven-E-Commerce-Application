from PyQt5 import uic
from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 
from DATA225utils import *
import sys
import os
import datetime
import re
from DATA225utils import *
from Customization import *


total_amount=0
CustomerID=0
total_amount=0
no_coupon=True
coupon_used=""
quant=0
gift_wrap=False
new_cc=False


class Checkout(QWidget):
    def __init__(self,CustID):
        super().__init__()
        
        self.setWindowTitle('Cart')
        self.setFixedSize(500, 620)
        #self.setGeometry(100, 100, 800, 600)
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()
        
        global CustomerID
        CustomerID=CustID
        
        query = f"select  w.WineName, sum(quantity),sum(w.price) as total_wine_price from bossbunch_db.Cart c inner join bossbunch_db.Wine w on c.WineID = w.WineID left join bossbunch_db.customization pers on c.pers_id= pers.pers_id where CustomerID={CustomerID} group by CustomerID,w.WineName,bottle_name,custom_message;"
        cursor.execute(query)
        data = cursor.fetchall()

        # create a vertical layout
        layout =  QGridLayout()

        # create a label widget and add it to the layout
        #label = QLabel("Hello World")
        #layout.addWidget(label,0,0)
        
        row = 0
        for record in data:
            col = 0
            for field in record:
                label = QLabel(str(field))
                layout.addWidget(label, row, col)
                
                if col==2:
                    global total_amount
                    total_amount+= round(float(field),2)
                
                col += 1
            row += 1
            
        row+=1   
         #Customization Cost
        self.cust_Label = QLabel("Customization Cost:")
        font = self.cust_Label.font()
        font.setPointSize(16)
        font.setBold(True)
        self.cust_Label.setFont(font)
        
        layout.addWidget(self.cust_Label, row, 0)
        row+=1 
        
        
        self.cust_bottle_Label = QLabel("")
        font = self.cust_bottle_Label.font()
        font.setPointSize(16)
        self.cust_bottle_Label.setFont(font)
        
        
        self.cust_bottle_totalprice = QLabel("")
        font = self.cust_bottle_totalprice.font()
        font.setPointSize(16)
        self.cust_bottle_totalprice.setFont(font)
        
        
        
        query = f"select case when bottle_name is null then '' else bottle_name end as bottle_name,sum(customization_price),gift_wrap,custom_message from bossbunch_db.Cart c inner join bossbunch_db.Wine w on c.WineID = w.WineID left join bossbunch_db.customization pers on c.pers_id= pers.pers_id where CustomerID={CustomerID} and bottle_name is not null group by CustomerID,bottle_name,gift_wrap,custom_message;"
        cursor.execute(query)
        data = cursor.fetchall()
        
        row_rec = 0
        for record in data:

            cust_bottle_Label = QLabel(str(record[0]))
            print(cust_bottle_Label)
            layout.addWidget(cust_bottle_Label, row, 0)
            cust_bottle_totalprice = QLabel(str(round(float(record[1]),2)))
            layout.addWidget(cust_bottle_totalprice, row, 2)
            total_amount+= round(float(record[1]),2)
                    
            row +=1
            row_rec +=1
        
        row+=1  
        self.gift_Label = QLabel("Gift wrap")
        font = self.gift_Label.font()
        font.setPointSize(16)
        self.gift_Label.setFont(font)
        layout.addWidget(self.gift_Label, row, 0)
        
        self.gift_wrap_price = QLabel("$0.00")
        font = self.gift_wrap_price.font()
        font.setPointSize(16)
        self.gift_wrap_price.setFont(font)
        
        query = f"select sum(gift_wrap_price) as gift_wrap_price from ( select gift_wrap, case when gift_wrap is true then 3.99 else 0 end gift_wrap_price from bossbunch_db.Cart c where CustomerID={CustomerID} ) x;"
        cursor.execute(query)
        gift_wrap = cursor.fetchone()
        gift_wrap_price = QLabel(str(gift_wrap[0]))
        layout.addWidget(gift_wrap_price, row, 2)
        total_amount+= round(float(gift_wrap[0]),2)
        row+=1 
        
        self.msg_Label = QLabel("Your custom message:")
        font = self.msg_Label.font()
        font.setPointSize(16)
        self.msg_Label.setFont(font)
        layout.addWidget(self.msg_Label, row, 0)
        row+=1
        
        self.custom_message = QLabel("NA")
        font = self.custom_message.font()
        font.setPointSize(14)
        self.custom_message.setFont(font)
        
        query = f"select distinct custom_message from bossbunch_db.Cart c where custom_message != '' and CustomerID={CustomerID};"
        cursor.execute(query)
        data = cursor.fetchall()
        
        row_rec = 0
        for record in data:
            custom_message = QLabel(str(record[0]))
            print(custom_message)
            layout.addWidget(custom_message, row, 0)
            row +=1
            row_rec +=1
        
        row+=1  
        
        #*****
        
        #Coupon Code
        
        self.coupon_Label = QLabel("Have Coupon code? Enter Here :")
        font = self.gift_Label.font()
        font.setPointSize(16)
        self.gift_Label.setFont(font)
        
        self.coupon = QLineEdit()
        
        # Create a button to submit the input
        self.check_coupon = QPushButton('Check')
        self.check_coupon.clicked.connect(self.check_coupon_details)
        
        #Discount
        
        self.disc_Label = QLabel("Discount:")
        font = self.disc_Label.font()
        font.setPointSize(16)
        font.setBold(True)
        self.disc_Label.setFont(font)
        
        
        self.disc_code = QLabel("NA")
        font = self.disc_code.font()
        font.setPointSize(16)
        self.disc_code.setFont(font)
        
        
        self.discount_amount = QLabel("-$0.00")
        font = self.discount_amount.font()
        font.setPointSize(16)
        self.discount_amount.setFont(font)
        
        
        #Total amt
        
        self.total_amt_Label = QLabel("Total amount payable:")
        font = self.total_amt_Label.font()
        font.setPointSize(16)
        font.setBold(True)
        self.total_amt_Label.setFont(font)
        
        self.total_amount = QLabel(str(round(float(total_amount),2)))
        font = self.total_amount.font()
        font.setPointSize(16)
        self.total_amount.setFont(font)
        
        self.cancel_button = QPushButton("CANCEL")
        self.cancel_button.clicked.connect(self.close)
        self.order_button = QPushButton("CONFIRM ORDER")
        self.order_button.clicked.connect(self.show_order_page)
        
        
        
        layout.addWidget(self.disc_Label, row,0)
        row+=1
        layout.addWidget(self.coupon_Label, row,0)
        layout.addWidget(self.coupon, row,2)
        row+=1
        layout.addWidget(self.check_coupon, row,2)
        row+=1
        
        layout.addWidget(self.disc_code, row,0)
        layout.addWidget(self.discount_amount, row,2)
        row+=1

        layout.addWidget(self.total_amt_Label, row,0)
        layout.addWidget(self.total_amount, row,2)
        row+=3
        layout.addWidget(self.cancel_button, row,0)
        layout.addWidget(self.order_button, row,2)
        

        # set the layout for the main widget
        self.setLayout(layout)
        
        
    def check_coupon_details(self): 
        
        global coupon_used
        valid=False
        user_coupon=self.coupon.text()
        
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()
        
        query = f"SELECT DiscountCode FROM Discounts WHERE DiscountCode='{user_coupon}'"
        cursor.execute(query)
        result = cursor.fetchone()
        
        if result is not None:
            if user_coupon == "BIRTHDAY10":
                valid=self.check_birthdate()
            else:
                valid=True
        
        if valid is True:
            self.apply_coupon_details()
            coupon_used=user_coupon
        else:
            QMessageBox.warning(self, "Error", "Invalid Coupon!")
            return
        
    def check_birthdate(self):
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()
        
        query = f"select Month(BirthDate) from bossbunch_db.Customer where CustomerID='{CustomerID}'"
        cursor.execute(query)
        result = cursor.fetchone()
        customer_bday_month = result[0]
        
        now = datetime.datetime.now()
        current_month = now.month

        if customer_bday_month == current_month:
            return True
        else:
            return False
                    
    def apply_coupon_details(self):
        
        global no_coupon
        global coupon_used
        
        if no_coupon is True:
        
            user_coupon=self.coupon.text()
            conn = make_connection(config_file='bossbunch_db.ini')
            cursor = conn.cursor()
            query = f"SELECT DiscountPercentage FROM Discounts WHERE DiscountCode='{user_coupon}'"
            cursor.execute(query)
            result = cursor.fetchone()
            discount_percent=0.00
        
            global total_amount

            if result is not None:
                # Prompt the user to answer the security question
                self.disc_code.setText(user_coupon)
                discount_percent = result[0]
                discount_amount = float((discount_percent / 100)) * float(total_amount)
                self.discount_amount.setText("-$"+str(round(discount_amount,2)))
                total_amount=float(total_amount)-float(discount_amount)
                self.total_amount.setText("$"+str(round(float(total_amount),2)))
                no_coupon= False
                coupon_used=user_coupon
                
            print(discount_percent)
            
    def show_order_page(self):
        self.order = Order(CustomerID,total_amount)
        self.order.show()
        

if __name__ == '__main__':
    app = QApplication(sys.argv)
    widget = Checkout(CustomerID)
    widget.show()
    sys.exit(app.exec_())