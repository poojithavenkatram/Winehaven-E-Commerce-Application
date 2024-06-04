import mysql.connector
import sys
from DATA225utils import *
from PyQt5.QtWidgets import QMainWindow, QApplication, QWidget, QGridLayout
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import matplotlib.pyplot as plt
import seaborn as sns

class Dashboard2(QMainWindow):
    def __init__(self):
        super().__init__()

        # Create the main widget and layout
        main_widget = QWidget(self)
        layout = QGridLayout(main_widget)

        # Add the main widget to the main window
        self.setCentralWidget(main_widget)

        # Set the window title
        self.setWindowTitle('Revenue by Coupon Code')
        self.setGeometry(100, 100, 1300, 1000)

        # Create the first grid layout with the bar chart
        grid_layout_1 = QGridLayout()
        layout.addLayout(grid_layout_1, 0, 0)

        # Create the second grid layout with the line chart
        grid_layout_2 = QGridLayout()
        layout.addLayout(grid_layout_2, 1, 0)

        # Create the data for the bar chart
        bar_data = self.get_bar_data()

        # Create the bar chart
        bar_chart = self.create_bar_chart(bar_data)
        grid_layout_1.addWidget(bar_chart, 0, 0)

        # Create the data for the line chart
        line_data = self.get_line_data()

        # Create the line chart
        line_chart = self.create_line_chart(line_data)
        grid_layout_2.addWidget(line_chart, 0, 0)

    def get_bar_data(self):
        # Create a connection to your MySQL database and execute the query
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        
        # FETCH FROM VIEW
        query = """
        select * from bossbunch_wh.coupon_analysis WHERE Coupon !="" and year >= YEAR(DATE_SUB(NOW(), INTERVAL 2 YEAR));

        """

        cursor.execute(query)

        bar_data = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return bar_data

    def get_line_data(self):
        # Create a connection to your MySQL database and execute the query
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        
        # FETCH FROM VIEW
        query = """
        select * from bossbunch_wh.overall_coupon_rev;
        """

        cursor.execute(query)

        line_data = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return line_data

    def create_bar_chart(self, data):
        # Create the figure and canvas
        figure = Figure()
        canvas = FigureCanvas(figure)

        # Create a dictionary to store the data
        coupon_data = {}
        for year, coupon, revenue in data:
            if coupon not in coupon_data:
                coupon_data[coupon] = {}
            coupon_data[coupon][year] = revenue

        # Get the list of coupons and years
        coupons = sorted(list(coupon_data.keys()))
        years = list(set([year for coupon in coupons for year in coupon_data[coupon]]))

        # Create the bar chart
        ax = figure.add_subplot(111)

        x = range(len(years))
        width = 1 / (len(coupons) + 1)
        
        num_colors = len(years)
        colors = sns.color_palette("magma",  num_colors)

        for i, coupon in enumerate(coupons):
            data = [coupon_data[coupon].get(year, 0) for year in years]
            ax.bar([xi + i * width for xi in x], data, width=width, label=coupon, color=colors[i])
        

        ax.set_ylabel('Total Revenue')
        ax.set_xlabel('Coupon')
        ax.set_title('Total Revenue by Year and Coupon')
        ax.set_xticks([xi + (len(coupons) - 1) * width / 2 for xi in x])
        ax.set_xticklabels(years)

        ax.legend()

    # Return the canvas
        return canvas

    def create_line_chart(self, data):
        # Create the figure and canvas
        figure = Figure()
        canvas = FigureCanvas(figure)

        # Create a dictionary to store the data
        year_data = {}
        for year, month, revenue in data:
            if year not in year_data:
                year_data[year] = {}
            year_data[year][month] = revenue

        # Get the list of years and months
        years = sorted(list(year_data.keys()))
        months = list(set([month for year in years for month in year_data[year]]))

        # Create the line chart
        ax = figure.add_subplot(111)
        colors = ['b', 'g', 'r', 'c', 'm', 'y', 'k']
        for i, year in enumerate(years):
            revenue_data = [year_data[year].get(month, 0) for month in months]
            ax.plot(range(len(months)), revenue_data, color=colors[i % len(colors)], label=str(year))
        ax.set_xticks(range(len(months)))
        ax.set_xticklabels(months)
        ax.set_ylabel('Revenue')
        ax.set_xlabel('Month')
        ax.set_xticklabels(['Jan', 'Feb', 'March', 'April', 'May', 'June','July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'])
        ax.set_title('Total Coupon Revenue by Month and Year')
        ax.legend(loc='upper left')

        return canvas

if __name__ == '__main__':
    app = QApplication(sys.argv)
    dashboard = Dashboard2()
    dashboard.show()
    sys.exit(app.exec_())
