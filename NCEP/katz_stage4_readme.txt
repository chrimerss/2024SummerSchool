                        STAGE IV DATA README FILE

Table of Contents

    Introduction
    Archive file naming convention
    How are the radar-only fields derived?
    How are the gage-only and multi-sensor fields derived?
    What kind of quality control steps are taken?
    What is the grid information?
    How do I decode these grids?
    How do I plot these grids?
    How do you denote missing/zero areas?
    Why are hours sometimes missing?
    Stage IV related references
    Who do I contact if I have a question?


INTRODUCTION

A prototype, real-time, hourly, multi-sensor National
Precipitation Analysis (NPA) has been developed at the National Centers for
Environmental Prediction (NCEP) in cooperation with the
Office of Hydrology (OH). This analysis merges two data sources that are
currently being collected in real-time by OH and NCEP.
Approximately 3000 automated, hourly raingage observations are available
over the contiguous 48 states via the GOES Data Collection
Platform (DCP), and ASOS.  In addition, hourly digital precipitation (HDP) radar
estimates are obtained as compressed digital files via the
AFOS network. The HDP estimates are created by the WSR-88D Radar Product
Generator on a 131 x 131 4-km grid centered over each
radar site. The data analysis routines, including a bias correction of the radar
estimates using the gage data, have been adapted by
NCEP on a national 4-km grid from algorithms developed by OH ("Stage II") and
executed regionally at NWS River Forecast Centers (RFC).


NATIONAL PRECIPITATION ANALYSIS ARCHIVE FILE NAMING CONVENTION

  All available files for each day can be found in tar files called
  grib4km.YYYYMMDD.  These contain individual GRIB files of 4km gridded
  analyses, including 1h, 6h, and 24h accumulations.  "Preview" gif files
  of the 1h and 24h multi-sensor analyses (and 24h RFC gage-only analysis)
  are available in the preview.YYYYMMDD tar files.

The format of the files is GRIB.  The files are compressed using
the UNIX "compress" command and "uncompress" must be used before
decoding.

FILE NAME INFO:

PRE.YYYYMMDD.HH.Z

1) PRE: Filename prefixes-
  mul4 - multi-sensor analysis (gage and unbiased radar)
  gag4 - gage-only analysis
  rad4 - radar estimate (no bias removal)
  ubr4 - radar estimate after bias removal
  rfc4 - gage-only analysis using 24h accumulated ("RFC") data

        The 4km grid:

        is a 1160x880 polar stereographic grid.
        point (1,1) is at 22.7736N  120.376W.
        point (1,880) is at 52.613N  136.394W.
        point (1160,1) is at 19.810N  80.802W.
        point (1160,880) is at 45.619N  60.079W.
        The y-axis is parallel to 105W.
        The resolution is 4.7625km at 60N.
        The pole point is (I,J) = (441,1601)

2) YYYYMMDD.HH: Valid date
This is the year, month, day, and hour for the end of the accumulation period
of the analysis.  Note that there are also files with YYYYMMDD.HH.06h.Z
and YYYYMMDD.HH.24h.Z, these are 6 and 24h summations of the 1h analyses.
These files are created by summing the 1h values, and if a grid point
is missing for one or more of those hours, it is missing for the entire
accumulation.  The only exception to this are the rfc4.YYYYMMDD.HH.24h.Z
files, which are gage-only analyses of 24h accumulated data.

3) "Preview" Gif files are also available in the preview.YYYYMMDD tar files
with nearly the same naming convention:

mul.YYYYMMDD.HH.gif     (hourly)
rfc.YYYYMMDD.HH.24h.gif (daily at 1200 UTC)
mul.YYYYMMDD.HH.24h.gif (daily at 1200 UTC)

These files were created from plots of coarser grid versions of the
analyses.  They are the same as what can be seen on our web pages.
(http://www.emc.ncep.noaa.gov/mmb/gcp/htmls/hdpprec.html, for example)


HOW ARE THE RADAR-ONLY PRECIP ESTIMATES DERIVED?

The first product with a completed prototype was the
national mosaic of radar precipitation HDP estimates. This radar-only product
consists of nearly 100 WSR-88D radars which report to NCEP in
real-time via AFOS. Each individual radar estimate is merged together
on the national Hydrologic Rainfall Analysis Project (HRAP)
grid and bins which contain more than one radar estimate are averaged
together using a simple inverse-distance weighted average.
Currently, there is no quality control of the HDP estimates, such as removal
of anomalous propagation.

There are current 2 types of radar-only estimates, biased and
unbiased. The radar bias removal algorithm follows Smith and Krajewski
(1991). The unbiased radar estimates are available after an
~6h delay, to allow gage data necessary to compute the biases to arrive.

For more information, please refer to "The WSR-88D Rainfall Algorithm"
in Weather and Forecasting by Fulton et al (1998).

HOW ARE THE GAGE-ONLY AND MULTI-SENSOR FIELDS DERIVED?

In contrast to the simple radar-only mosaic technique, the
analysis schemes used in the gage-only and multi-sensor analyses utilize
optimal estimation theory. These were developed by Seo (1998).
The schemes are fundamentally similar, and optimally estimate
rainfall fields using raingage and radar data under partial data
coverage conditions. This is preferred over previous statistically-based
techniques because it takes into account the variability due to
fractional coverage of rainfall, as well as within-storm variability. By
objectively taking the spatial coverage into account, more
accurate estimates of the rain versus no-rain area are obtained. Accurate
delineation of this area is as important as accurate estimation
of rainfall within the rain area. One of the underlying assumptions in the
radar-gage analysis scheme is that the radar estimates are
unbiased. Currently, radar biases are removed prior to the multi-sensor
analysis by the technique developed by Smith and Krajewski (1991).

For more information, please refer to "The WSR-88D Rainfall Algorithm"
in Weather and Forecasting by Fulton et al (1998).

WHAT TYPE OF QUALITY CONTROL STEPS ARE TAKEN?

In the initial stages, the NPA will omit manual quality control
steps that are a hallmark of the RFC "Stage III" analyses. However, some
initial quality control steps have been implemented into the
current NPA system. A list of consistently bad raingages has been created, so
that observations will be ignored from these reporting stations
in the analyses. This list was subjectively determined by examination of
numerous cases where the gages reported heavy rainfall for several
hours while nearby gage and radar reports contained zero rainfall.
As of this writing, a total of six gage stations have been omitted
from the analysis, four in California, one in northeast Kansas, and one
in New York. The only other quality control step currently in use
involves a gross check on gage data, making sure no reports greater
than 5in/hr get into the analysis system.


WHAT IS THE GRID INFORMATION?

The format of the files is GRIB. The files are compressed
using the UNIX "compress" command and "uncompress" must be used before
decoding.

For the 4km grid:

    It is a 1160x880 polar stereographic grid.
    Point (1,1) is at 22.7736N 120.376W.
    Point (1,880) is at 52.613N 136.394W.
    Point (1160,1) is at 19.810N 80.802W.
    Point (1160,880) is at 45.619N 60.079W.
    The y-axis is parallel to 105W.
    The resolution is 4.7625km at 60N.
    The pole point is (I,J) = (441,1601)

For the 15km grid:  (not available in long-term archive)

    The 15km grid is simply a 3x3 averaged remapping of the 4km grid.
    It is a 386x293 polar stereographic grid.
    Point (1,1) is at 22.813N 120.351W.
    Point (1,293) is at 52.564N 136.264W.
    Point (386,1) is at 19.876N 80.877W.
    Point (386,293) is at 45.646N 60.277W.
    The y-axis is parallel to 105W.
    The resolution is 14.2875km at 60N.
    The pole point is (I,J) = (147.323,534)


HOW CAN I DECODE THESE GRIDS?

NCEP has made a set of GRIB decoders available via anonymous ftp. 
The site is ftp.ncep.noaa.gov   /pub/nws/nmc/codes/grib.wafs
Here, you can obtain documentation and code for decoding GRIB messages.

1) GRIB Documentation

Acquire the specific guide to GRIB packing at /pub/nws/nmc/docs/gribed1
by a BINARY get of all six pdf (or wordperfect) files in this directory
(these six files are named by section number).

2) W3LIB Software

Once you acquire the README file in /pub/nws/nmc/codes/grib.wafs,
change to the subdirectory corresponding to the computer
platform you will be working on, e.g. for an SGI workstation
cd to /pub/nws/nmc/codes/grib.wafs/gribsgi
Once in your chosen platform subdirectory, acquire and
study the readme file there. Briefly, the latter file will
instruct you how to acquire, compile and execute the GRIB
unpacking codes that reside in that directory.

3) wgrib software

wgrib, an excellent GRIB decoding, inventory, and manipulation package
that is easy to compile on nearly any platform can be found at
http://wesley.wwb.noaa.gov/wgrib.html

HOW CAN I PLOT THESE GRIDS?

There are numerous grid plotting packages, many of which are
"GRIB-friendly". The two that I am most familiar with are GEMPAK and
NCARGRAPHICS.

For GEMPAK:

You will need to run nagrib, version 5.3 or higher I believe.
The 4km grid is over 1,000,000 points, so in order to use nagrib on these
grids, a recompile is necessary to expand the size of the maximum
allowable grid. The 15km grid is about 110,000 points, and should
be decodable with nagrib.

You will need to subset the 15km grids so that other GEMPAK
programs (GDPLOT, etc.) will be able to handle them. In nagrib:

    GBFILE = rad15.100912
    GDOUTF = testgrd.gem
    CPYFIL = gds
    GAREA = OK

where GAREA is the location of the subset you are interested
in, it can be nearly as large as the entire grid, but must be less than
100,000 points.

For NCARGRAPHICS:

I have made up a sample decoding and plotting code using
NCARGRAPHICS and W3LIB GRIB decoding routines. It is available for
downloading here. This code requires the W3LIB GRIB decoding
routines described earlier. This code will plot the 4km and 15km grids
and produces a map similar to those found on the web page.


HOW IS THE GRIB BITMAP USED TO DENOTE MISSING REGIONS?

Each type of analysis uses the GRIB bitmap feature to denote
the area of the domain that has enough data to provide an analyzed
value. In other words, the bitmap tells you if you are inside
the data domain or not. In the W3FI63 unpacker, a logical array is returned
that is .TRUE. where the bitmap is turned on, and .FALSE. where
the bitmap is turned off. The gribplot code takes advantage of this
feature to denote the extent of the data domain. The gage-only
analysis is considered to be inside the data domain within approximately
50km of the nearest gage report. The radar-only analysis is
considered inside of the data domain within approximately 200km of each
successfully decoded radar report. The multi-sensor analysis
will use the gage-only value if no radar data are available, and the
radar-only value if no gage data are available.

WHY ARE HOUR FILES SOMETIMES MISSING?
Missing data are most likely resulted from an interrupted
data feed (i.e. radar data not reaching us at all for a number of
hours - the data are piped through to us via the OSO gateway).  It
happens every now and then - for example, on 1 Dec 2001, there was no 
multi-sensor analysis for an hour.  A look into the radar data file 
showed that there was simply no radar data at all for that hour.

There is something like 1/4 time of one person working on the 
maintenance/upgrade of this product, so there is usually not much 
human QC done on the product.  If something goes wrong within the 
past 5 days or so, and if the data are available, repairs are usually made.

REFERENCES RELATED TO STAGE IV PROCESSING


Crosson, W.L., C.E. Duchon, R. Raghavan, S.J. Goodman, 1996:
Assesment of rainfall estimates using a standard Z-R relationship and
the probability matching method applied to composite radar
data in central Florida. J. Appl. Meteor., 35, 1203-1219.

Crum, T.D, R.L. Alberty, and D.W. Burgess, 1993: Recording,
Archiving, and Using WSR-88D Data. Bull. Amer. Meteor. Soc.,74,
645-653.

Crum, T.D, and R.L. Alberty, 1993: The WSR-88D and the WSR-88D
Operational Support Facility. Bull. Amer. Meteor. Soc.,74,
1669-1687.

Fulton, R.A., J.P. Breidenbach, D.J. Seo, D.A. Miller, and T. O'Bannon, 1998:
The WSR-88D rainfall algorithm.  Wea. and Fore.,13, 377-395.

Klazura, G.E., and D.A. Imy, 1993: A description of the initial
set of analysis products available from the NEXRAD WSR-88D System.
Bull. Amer. Meteor. Soc.,74, 1293-1311.

Seo, D.J., 1998: Optimal estimation of rainfall fields using
radar rainfall and rain gauge data. submitted to Journal of Hydrology

Seo, D.J., R. Fulton, J. Breidenbach, and E. Johnson, 1997:
Real-time estimation of mean field bias in radar rainfall data - A review of
current techniques and a proposed alternative. prepared for
submission to J. of Atm and Ocean Tech

Smith, J.A., and W.F. Krajewski, 1991: Estimation of mean
field bias of radar rainfall estimates. J. Appl. Meteor., 30, 397-412.

Vicente, Gilberto A., Roderick A. Scofield, W. Paul Menzel, 1998:
The Operational GOES Infrared Rainfall Estimation Technique.
Bulletin of the American Meteorological Society: Vol. 79, No. 9, pp. 1883-1898.

WHO TO CONTACT IF YOU HAVE QUESTIONS

     Stage IV analysis : Mike.Baldwin@noaa.gov
     Gage-only, multi-sensor techniques : Dongjun.Seo@noaa.gov
     Precipitation data: Sid.Katz@noaa.gov

     This readme file is similar to the Stage IV FAQ which can
     be fount at http://www.emc.ncep.noaa.gov/mmb/research/stage4.FAQ.html
 
