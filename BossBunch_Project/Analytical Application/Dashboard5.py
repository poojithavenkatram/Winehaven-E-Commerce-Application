import mysql.connector
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QColor
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QTableWidget, QTableWidgetItem , QSizePolicy,QHeaderView
from DATA225utils import *


class Dashboard5(QWidget):
    def __init__(self):
        super().__init__()

        # Initialize the database connection
        self.conn = make_connection(config_file='bossbunch_db.ini')
        self.cursor = self.conn.cursor()

        # Set up the UI
        self.setWindowTitle('Wine Inventory Dashboard')
        self.setGeometry(100, 100, 800, 500)
        self.layout = QVBoxLayout()
        self.setLayout(self.layout)

        # Add a label
        self.label = QLabel('Stock Details')
        self.label.setAlignment(Qt.AlignCenter)
        self.layout.addWidget(self.label)

        # Add a table to display the inventory
        self.table = QTableWidget()
        self.table.setColumnCount(2)
        self.table.setHorizontalHeaderLabels(['Wine', 'Stock'])
        self.table.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.layout.addWidget(self.table)

        # Populate the table with data
        self.populate_table()

    def populate_table(self):
        # Call the stored procedure to get the inventory data
        self.cursor.callproc('get_stock_details')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()

        # Sort the results by stock in descending order
        sorted_results = sorted(results, key=lambda x: x[1], reverse=True)

        # Populate the table
        self.table.setRowCount(len(sorted_results))
        for i, (wine, stock) in enumerate(sorted_results):
            item1 = QTableWidgetItem(wine)
            item2 = QTableWidgetItem(str(stock))
            if stock < 20:
                item2.setBackground(QColor(255, 0, 0))
            self.table.setItem(i, 0, item1)
            self.table.setItem(i, 1, item2)
            

    def closeEvent(self, event):
        # Close the database connection when the application is closed
        self.cursor.close()
        self.conn.close()


if __name__ == '__main__':
    app = QApplication([])
    dashboard = Dashboard5()
    dashboard.show()
    app.exec_()
