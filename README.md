# EENG509 Project

Implementation of the Random Kitchen Sinks method applied to COVID-19 time series data.

Data was pulled from:
[https://github.com/CSSEGISandData/COVID-19]

File Descriptions: 
RKStake1.m -> Example code running RKS in a least squares fitting sense
Visualization.m -> Code to visualize the spread of the Covid-19 Virus across America, used the plagueDat data.
alphaFinder.m -> Calculates the RKS coefficients 
approx_average_distance.m -> approximates average distance between rows of a matrix
covid_time_series.m -> Attempt to try and use RKS to fit time-space data to the Covid-19 data
housing_data_X.csv -> California Housing Data, X values for algorithm
housing_data_Y.csv -> California Housing Data, Y values for algorithm
kernel_time_series_preproc.m -> Attempt to form space-time data into data usable with RKS.
plagueDat.csv -> Covid-19 data in America by county by day from January 23rd - April 5.
plagueDat2.csv -> Same data as above
randPicker.m -> Function to select random values from the window function.
time_series_ex.m -> Example of time series analysis
time_series_preproc.m -> preprocesses space-time data to time series data in terms of coefficients of space model
time_series_xy.m -> produces pairs of points using matrix and window size.
