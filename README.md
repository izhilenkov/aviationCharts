The purpose of this utility is to process the freely provided FAA/Aeronav digital aviation charts 
into seamless mbtiles suitable use in mapping applications.

It has only been tested under Ubuntu 14.10

# TODO
    - Handle charts which cross the anti-meridian
    - Pull out insets and georeference them as necessary
    - Pursue a multithreaded gdal2tiles that can auto determine zoom levels

# Requirements
    - wget
    - pngquant (sudo apt-get install pngquant)
    - mbutil (git clone https://github.com/mapbox/mbutil.git)
    - gdal2mbtiles (https://github.com/mj10777/gdal2mbtiles.git)
	perhaps not totally necessary, I've been using this instead of the stock gdal2tiles

# Getting Started
    - Edit allCharts.sh and update these variables and create the corresponding directories as needed
	''''
	#Full path to root of downloaded chart info
	chartsRoot="/media/sf_Shared_Folder/charts/"
	
	#Full path to toot of directories where our processed images etc will be saved
	destinationRoot="${HOME}/Documents/myPrograms/mergedCharts'
	''''
      
    - Update this information as appropriate for dirname of current enroute chart cycle
	''''
	#This will need to be updated for every cycle
	originalEnrouteDirectory="$chartsRoot/aeronav.faa.gov/enroute/01-08-2015/"
	''''
      
    * Edit makeMbtiles.sh to update the location of these commands on your system
	''''
	~/Documents/github/gdal2mbtiles/gdal2mbtiles.py 
	~/Documents/github/mbutil/mb-util
	''''
      
    * Execute allCharts.sh
      ./allCharts.sh
      
    * Wait a very long time (assuming all went correctly)
  