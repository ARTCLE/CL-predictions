from netCDF4 import Dataset
import xarray as xr
import numpy as np
import pandas as pd
import glob

# Open the NetCDF file
data = Dataset(r'C:\\Users\\HONOR-ECC\\Desktop\\climate models\\BIO01_ipsl-cm5a-lr_rcp45_r1i1p1_1960-2099-mean_v1.0.nc', 'r')



starting_date = data.variables['time'].units[11:21]
ending_date = '2100-01-01'
date_range = pd.date_range(start =str(starting_date), end = str(ending_date), freq='20Y')


########## creating an empty pandas data frame ###########

df = pd.DataFrame(0,columns=['Annual mean temperature'], index = date_range)
dt = np.arange(0, data.variables['time'].size)


lat = data.variables['latitude'][:]
lon = data.variables['longitude'][:]
temp = data.variables['BIO01']






###### lat & lon of my location 
cities = pd.read_csv('C:\\Users\\HONOR-ECC\\Desktop\\climate models\\filtered_cities.csv')

for index, row in cities.iterrows() :
    location = row['City']
    location_latitude = row['Latitude']
    location_longitude = row['Longitude']
    #squarring the lat & long to avoid negative long and lat 

    sq_dist_lat = (lat - location_latitude)**2
    sq_dist_lon = (lon - location_longitude)**2

    ##### identifying the index of the minimum value for lat and lon

    min_index_lat = sq_dist_lat.argmin()
    min_index_lon = sq_dist_lon.argmin()
    for time_index in dt :
        df.iloc[time_index] = temp[time_index , min_index_lat, min_index_lon]
        df.to_csv(location + '.csv'  )

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




















