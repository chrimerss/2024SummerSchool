#!/opt/homebrew/Cellar/bash/5.2.21/bin/bash
start_date=$(gdate -I -d "2017-08-25 00:00:00") || exit -1
end_date=$(gdate -I -d "2017-09-05 00:00:00") || exit -1

d="$start_date"
while [[ "$d" < "$end_date" ]]; do
year="$(gdate -d "$d" +%Y)"
echo $d
month=$(gdate -d "$d" +%m)
day=$(gdate -d "$d" +%d)
for hour in {00..23}
do
if [[ $year -ge 2020 ]]
then

# 	web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/FLASH/QPE_ARIMAX/
# 	fname=QPE_ARIMAX_00.00_${year}${month}${day}-${hour}0000.grib2.gz
	# web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/MultiSensor_QPE_01H_Pass2/
	# fname=MultiSensor_QPE_01H_Pass2_00.00_${year}${month}${day}-${hour}0000.grib2.gz
	# echo ${hour}
	web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/PrecipFlag/
	fname=PrecipFlag_00.00_${year}${month}${day}-${hour}0000.grib2.gz
	# Download Unit streamflow
	#web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/FLASH/CREST_MAXUNITSTREAMFLOW/
	#fname=CREST_MAXUNITSTREAMFLOW_00.00_${year}${month}${day}-${hour}0000.grib2.gz
elif [[ $year -ge 2016 ]]
then
	web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/GaugeCorr_QPE_01H/
	fname=GaugeCorr_QPE_01H_00.00_${year}${month}${day}-${hour}0000.grib2.gz
else
        web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/RadarOnly_QPE_01H/
        fname=RadarOnly_QPE_01H_00.00_${year}${month}${day}-${hour}0000.grib2.gz
fi
# #echo ${web}${fname}
wget ${web}${fname}
done

d=$(gdate -I -d "$d + 1 day")

done

gunzip *.gz

for f in *.grib2
do
    gdalwarp -ot Float32 -t_srs EPSG:4326 -of GTiff -co COMPRESS=LZW -te -107.9 38.3 -85.9 23.5 -tr 0.04 -0.04 $f ${f}.tif
done
