
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from DATA225utils import *
from Checkout import *

CustomerID=0

class Cart(QWidget):
    def __init__(self,username):
        super().__init__()
        self.setWindowTitle('Checkout')
        self.setGeometry(100, 100, 800, 600)
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()
        global CustomerID
        
        cursor.execute(f"select CustomerID from Users where Username='{username}'")
        ids = cursor.fetchone()
        CustomerID=ids[0]
        # print(f"CART query executed {CustomerID} ")
        conn.close()
        self.initUI()

    def initUI(self):
        self.tableWidget = QTableWidget()
        self.tableWidget.resizeColumnsToContents()

        self.tableWidget.setColumnCount(7)
        self.tableWidget.setHorizontalHeaderLabels(['Wine', 'Quantity', 'Price','Bottle Label','Customization Cost','Gift Wrap Cost',''])
        self.tableWidget.setShowGrid(False)
        #self.tableWidget.horizontalHeader().setVisible(False)
        self.tableWidget.setColumnWidth(0, 300)
        #self.tableWidget.setFixedSize(700, 400)
        

        self.tableWidget.setStyleSheet("""
    QHeaderView::section {
        background-color: white;
        color: black;
        padding-left: 4px;
        border: none;
        qproperty-resizeMode: ResizeToContents;
    }

    QTableWidget {
        background-color: white;
        border: none;
        gridline-color: gray;
        font-size: 12px;
        font-family: Arial;
    }

    QTableWidget::item {
        padding: 2px;
    }

    QTableWidget::item:selected {
        background-color: #c1e2ff;
    }
        """)

        self.refreshButton = QPushButton("Refresh")
        self.refreshButton.clicked.connect(self.refresh)
        
        self.checkoutButton = QPushButton("Proceed to Checkout")
        self.checkoutButton.clicked.connect(self.open_checkout)

        layout = QVBoxLayout()
        layout.addWidget(self.refreshButton)
        layout.addWidget(self.tableWidget)
        layout.addWidget(self.checkoutButton)

        self.setLayout(layout)

        self.refresh()

    def refresh(self):
        
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()

        cursor.execute(f"select w.WineName, sum(quantity),sum(w.price) as total_wine_price,case when bottle_name is not null then bottle_name else '' end as bottle_name ,case when sum(c.customization_price) is not null then ROUND(sum(c.customization_price),2) else 0.00 end as customization_price,sum(case when gift_wrap is True then 3.99 else 0 end ) as gift_wrap_cost,null from bossbunch_db.Cart c inner join bossbunch_db.Wine w on c.WineID = w.WineID left join bossbunch_db.customization pers on c.pers_id= pers.pers_id where CustomerID={CustomerID} group by CustomerID,w.WineName,bottle_name")

        data = cursor.fetchall()

        self.tableWidget.setRowCount(len(data))

        for i, row in enumerate(data):
            for j, val in enumerate(row):
                if j != 6:
                    item = QTableWidgetItem(str(val))
                    self.tableWidget.setItem(i, j, item)
                else:
                    self.deleteButton = QPushButton("Remove Item")
                    self.tableWidget.setCellWidget(i, j, self.deleteButton)
                    self.deleteButton.clicked.connect(self.deleteClicked)
        conn.close()
        
    def deleteClicked(self):
        button = self.sender()
        if button:
            row = self.tableWidget.indexAt(button.pos()).row()
            first_column_value = self.tableWidget.item(row, 0).text()
            self.tableWidget.removeRow(row)
                                                      
        conn = make_connection(config_file='bossbunch_db.ini')
        cursor = conn.cursor()

        cursor.execute(f"DELETE c FROM Cart c JOIN Wine w ON c.WineID = w.WineID WHERE w.WineName= '{first_column_value}' and  CustomerID={CustomerID}")
        
        conn.commit()
        conn.close()
        
    def open_checkout(self, dialog):
        # create and show window B
        #self.checkout_window = Checkout(CustomerID,"WINE005")
        #self.checkout_window.show() 
        
        self.checkout_window = Checkout(CustomerID)
        self.checkout_window.show() 

if __name__ == "__main__":
    app = QApplication([])
    widget = Cart("CoolCat21")
    widget.show()
    app.exec_()
