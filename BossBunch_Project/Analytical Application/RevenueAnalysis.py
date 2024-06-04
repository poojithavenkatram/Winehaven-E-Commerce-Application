from PyQt5.QtWidgets import QApplication, QComboBox, QLabel, QVBoxLayout, QHBoxLayout, QWidget, QTextEdit, QMessageBox, QTableWidget, QTableWidgetItem, QPushButton, QDialog
from DATA225utils import make_connection
from PyQt5.QtCore import Qt
import matplotlib.pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas

class RevenueAnalysis(QWidget):
    def __init__(self):
        super().__init__()

        # Set window properties
        self.setWindowTitle('Wine Revenue')
        self.setGeometry(100, 100, 800, 600)

        # Add widgets to the window
        layout = QVBoxLayout()
        
        # Initialize the year_dropdown attribute
        self.year_dropdown = QComboBox()

        # Add wine dropdown and label
        year_label = QLabel('Select a year:')
        quarter_label = QLabel('Select a Quarter:')
        revenue_unit_label = QLabel('Select revenue or units sold:')
        
        self.quarter_dropdown = QComboBox()
        self.revenue_unit_dropdown = QComboBox()
        self.year_dropdown.currentIndexChanged.connect(self.fill_quarter_values)
              
        # Add submit push button
        submit_button = QPushButton('Submit')
        submit_button.clicked.connect(self.show_revenue)
        submit_button.clicked.connect(self.show_max_revenue_wine)
        #layout.addWidget(submit_button)
        
        # Create a layout for the row containing the Year Dropdown, Quarter Dropdown,
        # Revenue Unit Dropdown, and Submit button
        input_layout = QHBoxLayout()
        input_layout.addWidget(year_label)
        input_layout.addWidget(self.year_dropdown)
        input_layout.addWidget(quarter_label)
        input_layout.addWidget(self.quarter_dropdown)
        input_layout.addWidget(revenue_unit_label)
        input_layout.addWidget(self.revenue_unit_dropdown)
        input_layout.addWidget(submit_button)
        
        self.revenue_unit_dropdown.addItems(['Revenue', 'Units Sold'])
        
         # Set fixed sizes for the widgets in the input layout
        self.year_dropdown.setFixedSize(130, 25)
        self.quarter_dropdown.setFixedSize(130, 25)
        self.revenue_unit_dropdown.setFixedSize(130, 25)
        submit_button.setFixedSize(130, 25)
        
        # Add the input layout to the main layout
        layout.addLayout(input_layout)

        # Add the max revenue wine label
        self.max_revenue_label = QLabel()
        self.max_revenue_label.setObjectName("maxRevenueLabel")
        self.max_revenue_label.setStyleSheet("#maxRevenueLabel { color: black; font-size: 15px; }")
        layout.addWidget(self.max_revenue_label)
        
        # Add the wine revenue table widget
     
        self.wine_revenue_table = QTableWidget()
        layout.addWidget(self.wine_revenue_table)
        # Set fixed size for the table
        self.wine_revenue_table.setFixedSize(800, 400)
        # Set the border style for the table
        self.wine_revenue_table.setStyleSheet("QTableView { border: 1px solid black; }")
             
        self.yearwiseanalysis = YearwiseAnalysisDialog()
        
        # Add Yearwise Analysis button
        yearwise_analysis_button = QPushButton('Yearwise Analysis')
        yearwise_analysis_button.clicked.connect(lambda: (self.yearwiseanalysis.figure.clear(), self.yearwiseanalysis.show()))

        # Add show graph button
        self.show_graph_button = QPushButton('Visualize Data')
        self.show_graph_button.clicked.connect(self.show_graph)

        # Create a layout for the row containing the Yearwise Analysis and Visualize Data buttons
        button_layout = QHBoxLayout()
        button_layout.addWidget(self.show_graph_button)
        button_layout.addWidget(yearwise_analysis_button)
        
        # Set fixed sizes for the buttons in the button layout
        self.show_graph_button.setFixedSize(150, 25)
        yearwise_analysis_button.setFixedSize(150, 25)
        
        # Add the button layout to the main layout
        layout.addLayout(button_layout)

        # Set the main layout
        self.setLayout(layout)
      
        # Set the layout for the QWidget
        self.setLayout(layout)
        # Set the stretch factor of the logo layout to 0
        layout.setStretch(0, 0)
        # Fill the year values in the combo box
        self.fill_year_values()
               

    def fill_year_values(self):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Execute query to get year values
        cursor.execute('SELECT DISTINCT Year FROM Calendar ORDER BY Year DESC')
        year_values = [result[0] for result in cursor.fetchall()]
        
        # Add "All Years" option
        year_values.insert(0, "All Years")

        # Set year values to the combo box
        self.year_dropdown.addItems(year_values)
        self.year_dropdown.setCurrentIndex(0)
        
        #conn.close()
        
        
    def fill_quarter_values(self):
        
        # Clear the quarter dropdown
        self.quarter_dropdown.clear()
        
        year = self.year_dropdown.currentText()
       
        
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        
       # Execute query to get quarter values
        if year == 'All Years':
            cursor.execute('SELECT DISTINCT Quarter FROM Calendar ORDER BY Quarter ASC')
        else:
            cursor.execute('SELECT DISTINCT Quarter FROM Calendar WHERE Year = %s ORDER BY Quarter ASC', (year,))

        quarter_values = [result[0] for result in cursor.fetchall()]
        
        # Add the "All Quarters" option
        quarter_values.insert(0, 'All Quarters')

        # Set quarter values to the combo box
        self.quarter_dropdown.addItems(quarter_values)
        self.quarter_dropdown.setCurrentIndex(0)
        
        conn.commit()
        conn.close()
        

    
    def show_revenue(self):
        # Clear the wine revenue table
        self.wine_revenue_table.setRowCount(0)
    
        # Get the selected year, quarter, and revenue/unit sold
        year = self.year_dropdown.currentText()
        quarter = self.quarter_dropdown.currentText()
        revenue_unit = self.revenue_unit_dropdown.currentText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Prepare the SQL query
        query = 'SELECT WineName, '
        if revenue_unit == 'Revenue':
            query += 'SUM(RevenueInDollars) '
        else:
            query += 'SUM(UnitsSold) '
        query += 'FROM Wine '
        query += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '

        # Add conditions for year and quarter
        if year != 'All Years':
            query += 'WHERE Calendar.Year = %s '
            if quarter != 'All Quarters':
                query += 'AND Calendar.Quarter = %s '
        elif quarter != 'All Quarters':
            query += 'WHERE Calendar.Quarter = %s '

        # Group by wine name and order by revenue/units sold
        query += 'GROUP BY Wine.WineName '
        if revenue_unit == 'Revenue':
            query += 'ORDER BY SUM(RevenueInDollars) DESC'
        else:
            query += 'ORDER BY SUM(UnitsSold) DESC'

        # Execute the query with the appropriate parameters
        if year != 'All Years' and quarter != 'All Quarters':
            cursor.execute(query, (year, quarter,))
        elif year != 'All Years':
            cursor.execute(query, (year,))
        elif quarter != 'All Quarters':
            cursor.execute(query, (quarter,))
        else:
            cursor.execute(query)

        self.wine_data = cursor.fetchall()

        # Set the header labels based on the selected revenue or unit sold
        if revenue_unit == 'Revenue':
            self.wine_revenue_table.setColumnCount(2)
            self.wine_revenue_table.setHorizontalHeaderLabels(['Wine Names', 'Revenue in USD($)'])
        else:
            self.wine_revenue_table.setColumnCount(2)
            self.wine_revenue_table.setHorizontalHeaderLabels(['Wine Names', 'Units Sold'])

       # Add the wine revenue to the table
        for i, row in enumerate(self.wine_data):
            self.wine_revenue_table.insertRow(i)
            wine_name_item = QTableWidgetItem(row[0])
            data_item = QTableWidgetItem(str(row[1]))
            self.wine_revenue_table.setItem(i, 0, wine_name_item)
            self.wine_revenue_table.setItem(i, 1, data_item)

       # Set column widths
        self.wine_revenue_table.setColumnWidth(0, 400)
        self.wine_revenue_table.setColumnWidth(1, 400)
        self.wine_revenue_table.horizontalHeader().setStretchLastSection(False)

        conn.commit()
        conn.close()

        
    def show_graph(self):
        
        plt.clf()
        
        # Get the selected revenue or unit sold
        revenue_unit = self.revenue_unit_dropdown.currentText()

        # Get all the wine names
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        cursor.execute('SELECT WineName FROM Wine')
        all_wine_names = [row[0] for row in cursor.fetchall()]
        conn.close()

        # Generate line graph data
        wine_names = all_wine_names
        values = []
        for name in wine_names:
            found = False
            for row in self.wine_data:
                if row[0] == name:
                    values.append(row[1])
                    found = True
                    break
            if not found:
                values.append(0)

        # Close any existing figures
        plt.close('all')       
        # Create the line graph
        plt.figure(figsize=(12, 6))
        plt.plot(wine_names, values, marker='o')
        plt.title('Revenue Generated For All Wines' if revenue_unit == 'Revenue' else 'Units Sold For All Wines')
        plt.xlabel('Wine Names')
        plt.ylabel('Revenue in USD($)' if revenue_unit == 'Revenue' else 'Units Sold')
        plt.xticks(rotation=90)
        plt.tight_layout()

        # Display the line graph
        plt.show()
    

    def show_max_revenue_wine(self):
        # Get the selected year
        year = self.year_dropdown.currentText()
        
         # Get the selected quarter or set it to None for all quarters
        quarter = self.quarter_dropdown.currentText()
        if quarter == "All Quarters":
            quarter = None
        
         # Get the selected option in the revenue/unit dropdown
        option = self.revenue_unit_dropdown.currentText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
   

        # Get the wine with the max revenue or units sold for the selected year and quarter(s)
        if option == 'Revenue':
            if year == "All Years":
                if quarter is None:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                   'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                   'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                   'GROUP BY Wine.WineKey '
                                   'ORDER BY SUM(SalesPerWOC.RevenueInDollars) DESC '
                                   'LIMIT 1')
                else:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                   'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                   'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                   'WHERE Calendar.Quarter = %s '
                                   'GROUP BY Wine.WineKey '
                                   'ORDER BY SUM(SalesPerWOC.RevenueInDollars) DESC '
                                   'LIMIT 1', (quarter,))
            else:
                if quarter is None:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                   'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                   'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                   'WHERE Calendar.Year = %s '
                                   'GROUP BY Wine.WineKey '
                                   'ORDER BY SUM(SalesPerWOC.RevenueInDollars) DESC '
                                   'LIMIT 1', (year,))
                else:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                   'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                   'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                   'WHERE Calendar.Year = %s AND Calendar.Quarter = %s '
                                   'GROUP BY Wine.WineKey '
                                   'ORDER BY SUM(SalesPerWOC.RevenueInDollars) DESC '
                                   'LIMIT 1', (year, quarter,))
            result = cursor.fetchone()

            # Set the max revenue wine label text
            if result:
                max_revenue_wine = result[0]
                self.max_revenue_label.setText(f'Maximum Revenue Wine in {year}, {quarter or " All Quarters"}: {max_revenue_wine}')
            else:
                self.max_revenue_label.setText(f'No revenue data available for {year}, {quarter or " All Quarters"}')



        elif option == 'Units Sold':
            if year == "All Years":
                if quarter is None:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                       'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                       'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                       'GROUP BY Wine.WineKey '
                                       'ORDER BY SUM(SalesPerWOC.UnitsSold) DESC '
                                       'LIMIT 1')
                else:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                       'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                       'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                       'WHERE Calendar.Quarter = %s '
                                       'GROUP BY Wine.WineKey '
                                       'ORDER BY SUM(SalesPerWOC.UnitsSold) DESC '
                                       'LIMIT 1', (quarter,))
            else:
                if quarter is None:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                       'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                       'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                       'WHERE Calendar.Year = %s '
                                       'GROUP BY Wine.WineKey '
                                       'ORDER BY SUM(SalesPerWOC.UnitsSold) DESC '
                                       'LIMIT 1', (year,))
                else:
                    cursor.execute('SELECT Wine.WineName FROM Wine '
                                       'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
                                       'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
                                       'WHERE Calendar.Year = %s AND Calendar.Quarter = %s '
                                       'GROUP BY Wine.WineKey '
                                       'ORDER BY SUM(SalesPerWOC.UnitsSold) DESC '
                                       'LIMIT 1', (year, quarter,))
            result = cursor.fetchone()


            # Set the max units sold wine label text
            if result:
                max_units_sold_wine = result[0]
                self.max_revenue_label.setText(f'Maximum Wine Units Sold in {year}, {quarter or " All Quarters"}: {max_units_sold_wine}')
            else:
                self.max_revenue_label.setText(f'No sales data available for {year}, {quarter or " All Quarters"}')

        conn.commit()
        conn.close()
        

class YearwiseAnalysisDialog(QDialog):
    def __init__(self):
        
        super().__init__()

        # Set dialog properties
        self.setWindowTitle("Yearwise Analysis")
        self.setFixedSize(1000, 600)

        # Create layout for the dialog
        layout = QVBoxLayout()

        # Add wine dropdown and label
        wine_label = QLabel("Select a wine:")
        self.wine_dropdown = QComboBox()
        
        # Add year dropdown and label
        year_label = QLabel("Select a year:")
        self.year_dropdown = QComboBox()

        input_layout = QHBoxLayout()
        input_layout.addWidget(wine_label)
        input_layout.addWidget(self.wine_dropdown)
        input_layout.addWidget(year_label)
        input_layout.addWidget(self.year_dropdown)
                
        # Reduce the spacing between wine label and wine dropdown
        input_layout.setContentsMargins(0, 0, 0, 0)  # Adjust the right margin as needed

        # Add the input layout to the main layout
        layout.addLayout(input_layout)
        
        # Create the figure and canvas for the plot
        self.figure = plt.figure()  # Adjust the figure size
        self.canvas = FigureCanvas(self.figure)                       

        # Add the canvas to the layout
        layout.addWidget(self.canvas)

        # Set the layout for the dialog
        self.setLayout(layout)
               
        # Connect the signals to the slots
        self.wine_dropdown.currentTextChanged.connect(self.update_plots)
        self.year_dropdown.currentTextChanged.connect(self.update_plots)
        
         # Populate wine dropdown from the wine data
        self.wine_data()
                

    def update_plots(self):
        
        
        # Clear the previous plots
        self.figure.clear()
        
        # Get the selected wine and year
        selected_wine = self.wine_dropdown.currentText()
        selected_year = self.year_dropdown.currentText()
                
        # Create the subplot for quarter-wise revenue (ax1)
        ax1 = self.figure.add_subplot(2, 2, 1)
        # Create the subplot for all years revenue (ax2)
        ax2 = self.figure.add_subplot(2, 2, 2)
        # Create the subplot for quarter-wise units sold (ax3)
        ax3 = self.figure.add_subplot(2, 2, 3)
        # Create the subplot for all years units sold (ax4)
        ax4 = self.figure.add_subplot(2, 2, 4)

        # Call the show_rev method for ax1, ax2, ax3 and ax4 with the selected wine and year
        self.show_rev(ax1, ax2, selected_wine, selected_year)
        self.show_units_sold(ax3, ax4, selected_wine, selected_year)
        
        # Adjust the spacing between subplots
        self.figure.tight_layout()

        # Draw the plots on the canvas
        self.canvas.draw()      
        
        
    def wine_data(self):
        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Execute query to get year values
        cursor.execute('SELECT DISTINCT WineName FROM Wine')
        wine_data = [result[0] for result in cursor.fetchall()]
        
        # Add "All Years" option
        wine_data.insert(0, "")
        wine_data.insert(1, "All Wines")

        # Set year values to the combo box
        self.wine_dropdown.clear()
        self.wine_dropdown.addItems(wine_data)
        self.wine_dropdown.setCurrentIndex(0)
        
        # Execute query to get years
        cursor.execute('SELECT DISTINCT Year FROM Calendar ORDER BY Year ASC')
        year_data = [str(result[0]) for result in cursor.fetchall()]

        # Add blank option at the beginning
        year_data.insert(0, "")

        # Set years to the combo box
        self.year_dropdown.clear()
        self.year_dropdown.addItems(year_data)
        self.year_dropdown.setCurrentIndex(0)
        
        #conn.close()
        
    def show_rev(self, ax1, ax2, selected_wine, selected_year):
        
        # Get the selected wine
        selected_wine = self.wine_dropdown.currentText()
        selected_year = self.year_dropdown.currentText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()
        
        # Prepare the SQL query to get revenue data for the selected wine and year
        query_selected = 'SELECT Calendar.Quarter, SUM(SalesPerWOC.RevenueInDollars) '
        query_selected += 'FROM Wine '
        query_selected += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_selected += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        query_selected += 'WHERE Wine.WineName = %s AND Calendar.Year = %s '
        query_selected += 'GROUP BY Calendar.Quarter '
        query_selected += 'ORDER BY Calendar.Quarter'

        cursor.execute(query_selected, (selected_wine, selected_year))
        revenue_data_selected = cursor.fetchall()

        conn.commit()
        #conn.close()

        # Extract the quarters and revenue values for the selected wine from the database results
        quarters_selected = [f"{row[0]}" for row in revenue_data_selected]
        revenue_values_selected = [row[1] for row in revenue_data_selected]

        # Prepare the SQL query to get revenue data for all wines for the selected year
        query_all_wines = 'SELECT Calendar.Quarter, SUM(SalesPerWOC.RevenueInDollars) '
        query_all_wines += 'FROM Wine '
        query_all_wines += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_all_wines += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        query_all_wines += 'WHERE Calendar.Year = %s '
        query_all_wines += 'GROUP BY Calendar.Quarter '
        query_all_wines += 'ORDER BY Calendar.Quarter'

        cursor.execute(query_all_wines, (selected_year,))
        revenue_data_all_wines = cursor.fetchall()

        conn.commit()
        #conn.close()

        # Extract the quarters and revenue values for all wines from the database results
        quarters_all_wines = [f"{row[0]}" for row in revenue_data_all_wines]
        revenue_values_all_wines = [row[1] for row in revenue_data_all_wines]

        # Clear the previous plot
        ax1.clear()
        ax2.clear()       
        
        # Create the subplot for quarter-wise revenue
        if selected_wine == "All Wines":
            ax2.bar(quarters_all_wines, revenue_values_all_wines, color='Green')
            chart_title = f"Revenue Analysis for All Wines ({selected_year})"
        else:
            ax2.bar(quarters_selected, revenue_values_selected)
            chart_title = f"Revenue Analysis for \n {selected_wine} ({selected_year})"
        ax2.set_xlabel('Quarters')
        ax2.set_ylabel('Revenue in USD')
        ax2.set_title(chart_title)

        # Adjust the spacing between subplots
        self.figure.tight_layout()

        # Draw the plot on the canvas
        self.canvas.draw()
    

        # Prepare the SQL query to get revenue data for the selected wine across all years
        query_all_years = 'SELECT Calendar.Year, SUM(SalesPerWOC.RevenueInDollars) '
        query_all_years += 'FROM Wine '
        query_all_years += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_all_years += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        if selected_wine != "All Wines":
            query_all_years += 'WHERE Wine.WineName = %s '
        query_all_years += 'GROUP BY Calendar.Year '
        query_all_years += 'ORDER BY Calendar.Year'

        # Execute the query with the selected wine as the parameter if it's not "All Wines"
        if selected_wine != "All Wines":
            cursor.execute(query_all_years, (selected_wine,))
        else:
            cursor.execute(query_all_years)

        wine_data_all_years = cursor.fetchall()

        conn.commit()
        conn.close()

        # Extract the years and revenue values from the database results
        years = [str(row[0]) for row in wine_data_all_years]
        revenue_values_all_years = [row[1] for row in wine_data_all_years]

        # Create the second subplot for all years revenue
        ax1.bar(years, revenue_values_all_years, color='Green')
        ax1.set_xlabel('Years')
        ax1.set_ylabel('Revenue in USD')
        
        if selected_wine == "All Wines":
            chart_title_all_years = "Revenue Analysis for All Wines (Over Years)"
        else:
            chart_title_all_years = f"Revenue Analysis for \n {selected_wine} (Over Years)"

        ax1.set_title(chart_title_all_years)
        
        # Adjust the spacing between subplots
        self.figure.tight_layout()
       
        # Draw the plot on the canvas
        self.canvas.draw()
        
    def show_units_sold(self, ax3, ax4, selected_wine, selected_year):
        
        # Get the selected wine
        selected_wine = self.wine_dropdown.currentText()
        selected_year = self.year_dropdown.currentText()

        # Connect to the database
        conn = make_connection(config_file='bossbunch_wh.ini')
        cursor = conn.cursor()

        # Prepare the SQL query to get units sold data for the selected wine and year
        query_selected = 'SELECT Calendar.Quarter, SUM(SalesPerWOC.UnitsSold) '
        query_selected += 'FROM Wine '
        query_selected += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_selected += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        query_selected += 'WHERE Wine.WineName = %s AND Calendar.Year = %s '
        query_selected += 'GROUP BY Calendar.Quarter '
        query_selected += 'ORDER BY Calendar.Quarter'

        cursor.execute(query_selected, (selected_wine, selected_year))
        units_sold_data_selected = cursor.fetchall()

        conn.commit()

        # Extract the quarters and units sold values for the selected wine from the database results
        quarters_selected = [f"{row[0]}" for row in units_sold_data_selected]
        units_sold_values_selected = [row[1] for row in units_sold_data_selected]

        # Prepare the SQL query to get units sold data for all wines for the selected year
        query_all_wines = 'SELECT Calendar.Quarter, SUM(SalesPerWOC.UnitsSold) '
        query_all_wines += 'FROM Wine '
        query_all_wines += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_all_wines += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        query_all_wines += 'WHERE Calendar.Year = %s '
        query_all_wines += 'GROUP BY Calendar.Quarter '
        query_all_wines += 'ORDER BY Calendar.Quarter'

        cursor.execute(query_all_wines, (selected_year,))
        units_sold_data_all_wines = cursor.fetchall()

        conn.commit()
        #conn.close()

        # Extract the quarters and units sold values for all wines from the database results
        quarters_all_wines = [f"{row[0]}" for row in units_sold_data_all_wines]
        units_sold_values_all_wines = [row[1] for row in units_sold_data_all_wines]

        # Clear the previous plot
        #self.figure.clear()
        ax3.clear()
        ax4.clear()
        
        # Create the subplot for quarter-wise units sold
        if selected_wine == "All Wines":
            ax4.bar(quarters_all_wines, units_sold_values_all_wines)
            chart_title = f"Units Sold Analysis for All Wines ({selected_year})"
        else:
            ax4.bar(quarters_selected, units_sold_values_selected)
            chart_title = f"Units Sold Analysis for \n {selected_wine} ({selected_year})"
        ax4.set_xlabel('Quarters')
        ax4.set_ylabel('Units Sold')
        ax4.set_title(chart_title)
        
        # Adjust the spacing between subplots
        self.figure.tight_layout()

        # Draw the plot on the canvas
        self.canvas.draw()
        
        
        # Prepare the SQL query to get units sold data for the selected wine across all years
        query_units_sold_all_years = 'SELECT Calendar.Year, SUM(SalesPerWOC.UnitsSold) '
        query_units_sold_all_years += 'FROM Wine '
        query_units_sold_all_years += 'INNER JOIN SalesPerWOC ON Wine.WineKey = SalesPerWOC.WineKey '
        query_units_sold_all_years += 'INNER JOIN Calendar ON SalesPerWOC.CalendarKey = Calendar.CalendarKey '
        if selected_wine != "All Wines":
            query_units_sold_all_years += 'WHERE Wine.WineName = %s '
        query_units_sold_all_years += 'GROUP BY Calendar.Year '
        query_units_sold_all_years += 'ORDER BY Calendar.Year'

        # Execute the query with the selected wine as the parameter if it's not "All Wines"
        if selected_wine != "All Wines":
            cursor.execute(query_units_sold_all_years, (selected_wine,))
        else:
            cursor.execute(query_units_sold_all_years)

        units_sold_data_all_years = cursor.fetchall()

        conn.commit()
        conn.close()

        # Extract the years and units sold values from the database results
        years = [str(row[0]) for row in units_sold_data_all_years]
        units_sold_values_all_years = [row[1] for row in units_sold_data_all_years]

        # Create the third subplot for units sold over years
        ax3.bar(years, units_sold_values_all_years)
        ax3.set_xlabel('Years')
        ax3.set_ylabel('Units Sold')

        if selected_wine == "All Wines":
            chart_title_units_sold_all_years = "Units Sold Analysis for All Wines (Over Years)"
        else:
            chart_title_units_sold_all_years = f"Units Sold Analysis for \n {selected_wine} (Over Years)"

        ax3.set_title(chart_title_units_sold_all_years)

        # Adjust the spacing between subplots
        self.figure.tight_layout()

        # Draw the plot on the canvas
        self.canvas.draw()
        


if __name__ == '__main__':
    app = QApplication([])
    window = RevenueAnalysis()
    window.show()
    app.exec_()
