# Define the source file name
for fname in *.nc4
do

	# Define the destination file name by replacing the postfix
	destination_file="${fname%.nc4}.tif"

	# Run the gdalwarp command
	gdalwarp -te -107.9 23.5 -85.9 38.3 -tr 0.04 0.04 -r average NETCDF:"$fname":precipitation "$destination_file"

done
