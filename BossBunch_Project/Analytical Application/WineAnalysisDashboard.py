import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QComboBox, QGridLayout
from PyQt5.QtGui import QFont
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.font_manager import FontProperties
from DATA225utils import make_connection
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QComboBox, QGridLayout, QSplitter
from PyQt5.QtChart import QChart, QChartView, QPieSeries, QPieSlice
import numpy as np
from matplotlib.figure import Figure
from PyQt5.QtWidgets import QSlider
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QLabel
from PyQt5.QtGui import QFont

class WineAnalysisDashboard(QMainWindow):
    def __init__(self):
        super().__init__()
        
        # Set up the main window
        self.setWindowTitle('Wine Analysis Dashboard')
        self.setGeometry(100, 100, 800, 600)

        layout = QVBoxLayout()
        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)

        splitter = QSplitter(Qt.Horizontal)
        layout.addWidget(splitter)

        left_widget = QWidget(splitter)
        right_widget = QWidget(splitter)

        left_layout = QVBoxLayout(left_widget)
        right_layout = QVBoxLayout(right_widget)

        # Create the top selling wines graph
        self.top_selling_fig = plt.figure(figsize=(12, 10))
        self.top_selling_ax = self.top_selling_fig.add_subplot(111)
        self.top_selling_ax.tick_params(axis='x', rotation=45)
        top_selling_canvas = FigureCanvas(self.top_selling_fig)
        left_layout.addWidget(top_selling_canvas)

        # Create the units sold graph
        self.units_sold_fig, self.units_sold_ax = plt.subplots(figsize=(12, 10))  # Adjust figsize as needed
        self.createUnitsSoldGraph(self.units_sold_ax)  # Pass the ax parameter
        self.units_sold_ax.tick_params(axis='x', rotation=45)  # Rotate x-axis labels
        self.units_sold_canvas = FigureCanvas(self.units_sold_fig)
        left_layout.addWidget(self.units_sold_canvas)

        # Create the variety distribution graph (pie chart)
        self.variety_distribution_fig, self.variety_distribution_ax = plt.subplots(figsize=(6, 6))
        self.variety_distribution_canvas = FigureCanvas(self.variety_distribution_fig)
        right_layout.addWidget(self.variety_distribution_canvas)

        # Create the rating distribution graph (donut chart)
        self.rating_distribution_fig, self.rating_distribution_ax = plt.subplots(figsize=(6, 6))
        self.rating_distribution_canvas = FigureCanvas(self.rating_distribution_fig)
        right_layout.addWidget(self.rating_distribution_canvas)

        splitter.setSizes([1, 1])

        # Set the spacing between graphs
        left_layout.setSpacing(10)
        right_layout.setSpacing(10)

        # Connect to the database
        self.conn = make_connection(config_file='bossbunch_wh.ini')
        
        label = QLabel("Wine List")
        label.setFont(QFont("Arial", 12, QFont.Bold))
        
        layout.addWidget(label)

        # Create widgets for selecting wine and year
        self.wine_combo_box = QComboBox()
        layout.addWidget(self.wine_combo_box)

        self.wine_combo_box.currentIndexChanged.connect(self.handleWineSelection)
        self.updateWineComboBox()

        # Add the wine and year widgets to the layout
        layout.addWidget(self.wine_combo_box)
        
    def createGridLayout(self):
        # Create a grid layout
        grid_layout = QGridLayout()

        # Create the top selling wines graph
        top_selling_fig, top_selling_ax = plt.subplots(figsize=(8, 6))  # Adjust figsize as needed
        top_selling_canvas = FigureCanvas(top_selling_fig)
        grid_layout.addWidget(top_selling_canvas, 0, 0, 1, 2)  # Span across both columns

        # Create the units sold graph
        units_sold_fig, units_sold_ax = plt.subplots(figsize=(10, 6))  # Adjust figsize as needed
        self.createUnitsSoldGraph(units_sold_ax)  # Pass the ax parameter
        units_sold_ax.tick_params(axis='x', rotation=45)  # Rotate x-axis labels
        units_sold_canvas = FigureCanvas(units_sold_fig)
        grid_layout.addWidget(units_sold_canvas, 1, 0, 1, 2)  # Span across one row and two columns

        # Create the variety distribution graph (pie chart)
        variety_distribution_fig, variety_distribution_ax = plt.subplots(figsize=(6, 6))  # Adjust figsize as needed
        variety_distribution_canvas = FigureCanvas(variety_distribution_fig)
        grid_layout.addWidget(variety_distribution_canvas, 2, 0)  # Span across one row and one column

        # Create the rating distribution graph (donut chart)
        rating_distribution_fig, rating_distribution_ax = plt.subplots(figsize=(6, 6))  # Adjust figsize as needed
        rating_distribution_canvas = FigureCanvas(rating_distribution_fig)
        grid_layout.addWidget(rating_distribution_canvas, 2, 1)  # Span across one row and one column

        # Set the size policy for FigureCanvas widgets
        top_selling_canvas.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        units_sold_canvas.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        variety_distribution_canvas.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        rating_distribution_canvas.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

        # Set the spacing and stretch factors
        grid_layout.setSpacing(10)
        grid_layout.setColumnStretch(0, 1)
        grid_layout.setColumnStretch(1, 1)
        grid_layout.setRowStretch(0, 1)
        grid_layout.setRowStretch(1, 1)
        grid_layout.setRowStretch(2, 1)

        return grid_layout

    def createTopSellingWinesGraph(self, ax, metric='revenue', num_wines=5, selected_wine=None):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Construct the SQL query based on the selected metric
        if metric == 'revenue':
            metric_column = 'RevenueInDollars'
        elif metric == 'units_sold':
            metric_column = 'UnitsSold'
        else:
            raise ValueError('Invalid metric')

        if selected_wine:
            query = (
                "SELECT WineID, {0} "
                "FROM SalesPerWOC "
                "JOIN Wine ON Wine.WineKey = SalesPerWOC.WineKey "
                "WHERE Wine.WineName = %s "
                "GROUP BY WineID, {0} "
                "ORDER BY {0} DESC "
                "LIMIT %s"
            ).format(metric_column)
            cursor.execute(query, (selected_wine, num_wines))
        else:
            query = (
                "SELECT Wine.WineID, SUM({0}) AS Total{1} "
                "FROM SalesPerWOC "
                "JOIN Wine ON Wine.WineKey = SalesPerWOC.WineKey "
                "GROUP BY Wine.WineID "
                "ORDER BY Total{1} DESC "
                "LIMIT %s"
            ).format(metric_column, metric.capitalize())
            cursor.execute(query, (num_wines,))

        # Fetch the results
        results = cursor.fetchall()

        # Extract the wine IDs and metric values
        wine_ids = [row[0] for row in results]
        metric_values = [row[1] for row in results]

        # Reduce subplot size to fit the grid
        plt.subplots_adjust(bottom=0.2, top=0.9, left=0.1, right=0.9)
    
        # Create the bar chart on the specified axes
        bars = ax.bar(range(len(wine_ids)), metric_values, color='lightblue')
    
        # Set the wine IDs as x-axis labels
        ax.set_xticks(range(len(wine_ids)))
        ax.set_xticklabels(wine_ids, rotation=0)
    
        ax.set_xlabel('Wine ID')
        ax.set_ylabel(metric.capitalize())
        ax.set_title('Top Selling Wines')
       
        # Place labels inside the bar graph
        #for i, bar in enumerate(bars):
           # ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height(), str(wine_ids[i]), ha='center')

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return ax.figure
    
    def createUnitsSoldGraph(self, ax):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Execute the SQL query to retrieve the units sold by wine
        cursor.execute("SELECT Wine.WineID, SUM(SalesPerWOC.UnitsSold) AS UnitsSold "
                       "FROM Wine "
                       "JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey "
                       "GROUP BY Wine.WineKey")

        # Fetch the results
        results = cursor.fetchall()

        # Create lists to store the wine names and units sold
        wine_names = []
        units_sold = []

        # Extract the wine names and units sold from the results
        for row in results:
            wine_names.append(row[0])
            units_sold.append(row[1])

        # Create the line graph on the specified axes
        ax.plot(wine_names, units_sold, marker='o',color='skyblue')
        ax.set_xlabel("Wine")
        ax.set_ylabel("Units Sold")
        ax.set_title("Wine Sales Trend")

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return ax.figure

    def createVarietyDistributionGraph(self, ax):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Execute the SQL query to retrieve the variety distribution
        cursor.execute("SELECT Wine.WineGrapeVariety, COUNT(*) AS VarietyCount "
                       "FROM Wine "
                       "GROUP BY Wine.WineGrapeVariety")

        # Fetch the results
        results = cursor.fetchall()

        # Create lists to store the variety names and variety counts
        variety_names = []
        variety_counts = []

        # Extract the variety names and variety counts from the results
        for row in results:
            variety_names.append(row[0])
            variety_counts.append(row[1])

        # Create the pie chart on the specified axes
        ax.pie(variety_counts, labels=variety_names, autopct='%1.1f%%')
        ax.set_title('Variety Distribution Overview')

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return ax.figure

    def createRatingDistributionGraph(self, ax):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Execute the SQL query to retrieve the rating distribution
        cursor.execute("SELECT "
                       "CASE "
                       "    WHEN Rating <= 2 THEN 'Poor' "
                       "    WHEN Rating = 3 THEN 'Average' "
                       "    WHEN Rating = 4 THEN 'Good' "
                       "    WHEN Rating >= 5 THEN 'Excellent' "
                       "END AS RatingCategory, "
                       "COUNT(*) AS RatingCount "
                       "FROM Feedback "
                       "GROUP BY RatingCategory")

        # Fetch the results
        results = cursor.fetchall()

        # Prepare the data for the donut chart
        rating_categories = [row[0] for row in results]
        rating_counts = [row[1] for row in results]

        # Clear the previous plot
        ax.clear()

        # Create the donut chart
        ax.pie(rating_counts, labels=rating_categories, autopct='%1.1f%%', startangle=90, wedgeprops=dict(width=0.4))

        # Set the title of the chart
        ax.set_title('Feedback Analysis - Rating Overview')

        # Set the aspect ratio to be equal
        ax.set_aspect('equal')

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # Update the plot
        self.rating_distribution_canvas.draw()

    def updateWineComboBox(self):
        
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        
        # Execute the query to fetch WineID and wine name columns
        query = "SELECT WineID, WineName FROM Wine"
        cursor.execute(query)

        # Fetch all rows from the result set
        rows = cursor.fetchall()

        # Populate the combo box with the WineID and wine name data
        for row in rows:
            wine_id, wine_name = row
            self.wine_combo_box.addItem(f"{wine_id}: {wine_name}")
            
        # Close the cursor
        cursor.close()
    
    def handleWineSelection(self):
        
        # Get the selected wine from the combo box
        selected_wine = self.wine_combo_box.currentText()

        self.updateTopSellingWinesGraph(selected_wine)
        
        # Get the selected year
        #selected_year = self.year_combo_box.currentText()
    
        # Map the selected year to the corresponding year in the database
        
        #year_mapping = {
            #'Year 1': 2020,
           # 'Year 2': 2021,
           # 'Year 3': 2023
        #}
        #database_year = year_mapping[selected_year]

        # Update the graphs when a different wine is selected
        self.createTopSellingWinesGraph(self.top_selling_ax)
        self.createUnitsSoldGraph(self.units_sold_ax)
        self.createVarietyDistributionGraph(self.variety_distribution_ax)
        self.createRatingDistributionGraph(self.rating_distribution_ax)
        
    def updateTopSellingWinesGraph(self, selected_wine):
        
        # Clear the current graph
        self.top_selling_ax.clear()

        # Call the createTopSellingWinesGraph method with the selected wine
        self.createTopSellingWinesGraph(self.top_selling_ax, metric='revenue', num_wines=5, selected_wine=selected_wine)
        
        # Redraw the canvas
        self.top_selling_ax.figure.canvas.draw()
    
if __name__ == '__main__':
    app= QApplication(sys.argv)
    form= WineAnalysisDashboard()
    form.show()
    sys.exit(app.exec_())
