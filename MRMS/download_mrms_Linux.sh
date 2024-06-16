start_date=$(date -I -d "2017-08-25 00:00:00") || exit -1
end_date=$(date -I -d "2017-09-05 00:00:00") || exit -1

d="$start_date"
while [[ "$d" < "$end_date" ]]; do
year="$(date -d "$d" +%Y)"
echo $d
month=$(date -d "$d" +%m)
day=$(date -d "$d" +%d)
for hour in {00..23}
do
if [[ $year -ge 2020 ]]
then

	web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/MultiSensor_QPE_01H_Pass2/
	fname=MultiSensor_QPE_01H_Pass2_00.00_${year}${month}${day}-${hour}0000.grib2.gz
elif [[ $year -ge 2016 ]]
then
	web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/GaugeCorr_QPE_01H/
	fname=GaugeCorr_QPE_01H_00.00_${year}${month}${day}-${hour}0000.grib2.gz
else
        web=https://mtarchive.geol.iastate.edu/$year/$month/$day/mrms/ncep/RadarOnly_QPE_01H/
        fname=RadarOnly_QPE_01H_00.00_${year}${month}${day}-${hour}0000.grib2.gz
fi
#echo ${web}${fname}
wget ${web}${fname}
done

d=$(date -I -d "$d + 1 day")

done

gunzip *.gz

for f in *.grib2
do
    gdalwarp -ot Float32 -of GTiff -co COMPRESS=LZW $f ${f}.tif
done

