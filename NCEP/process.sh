for fname in *.Grb
do
	dst1="${fname%.Grb}.temp.tif"
	dst2="${fname%.Grb}.tif"
	gdalwarp -te -107.9 23.5 -85.9 38.3 -t_srs EPSG:4326 $fname $dst1
	gdal_translate -tr 0.04 -0.04 -r nearest $dst1 $dst2
	rm $dst1 
done
