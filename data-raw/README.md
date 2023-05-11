Data were downloaded from https://reporter.nih.gov/exporter/projects, 
by clicking on individual links.

The data processing steps assuming that raw data are organized like this:

```
downloads/
|-- ClinicalStudies.csv
|-- Patents.csv
|-- projects
|   |-- RePORTER_PRJ_C_FY1985.csv
|   |-- RePORTER_PRJ_C_FY1985.zip
|   |-- RePORTER_PRJ_C_FY1986.csv
|   |-- RePORTER_PRJ_C_FY1986.zip
|   |-- RePORTER_PRJ_C_FY1987.csv
|   |-- RePORTER_PRJ_C_FY1987.zip
|   |-- RePORTER_PRJ_C_FY1988.csv
|   |-- RePORTER_PRJ_C_FY1988.zip
|   |-- RePORTER_PRJ_C_FY1989.csv
|   |-- RePORTER_PRJ_C_FY1989.zip
|   |-- RePORTER_PRJ_C_FY1990.csv
|   |-- RePORTER_PRJ_C_FY1990.zip
|   |-- RePORTER_PRJ_C_FY1991.csv
|   |-- RePORTER_PRJ_C_FY1991.zip
|   |-- RePORTER_PRJ_C_FY1992.csv
|   |-- RePORTER_PRJ_C_FY1992.zip
|   |-- RePORTER_PRJ_C_FY1993.csv
|   |-- RePORTER_PRJ_C_FY1993.zip
|   |-- RePORTER_PRJ_C_FY1994.csv
|   |-- RePORTER_PRJ_C_FY1994.zip
|   |-- RePORTER_PRJ_C_FY1995.csv
|   |-- RePORTER_PRJ_C_FY1995.zip
|   |-- RePORTER_PRJ_C_FY1996.csv
|   |-- RePORTER_PRJ_C_FY1996.zip
|   |-- RePORTER_PRJ_C_FY1997.csv
|   |-- RePORTER_PRJ_C_FY1997.zip
|   |-- RePORTER_PRJ_C_FY1998.csv
|   |-- RePORTER_PRJ_C_FY1998.zip
|   |-- RePORTER_PRJ_C_FY1999.csv
|   |-- RePORTER_PRJ_C_FY1999.zip
|   |-- RePORTER_PRJ_C_FY2000.csv
|   |-- RePORTER_PRJ_C_FY2000.zip
|   |-- RePORTER_PRJ_C_FY2001.csv
|   |-- RePORTER_PRJ_C_FY2001.zip
|   |-- RePORTER_PRJ_C_FY2002.csv
|   |-- RePORTER_PRJ_C_FY2002.zip
|   |-- RePORTER_PRJ_C_FY2003.csv
|   |-- RePORTER_PRJ_C_FY2003.zip
|   |-- RePORTER_PRJ_C_FY2004.csv
|   |-- RePORTER_PRJ_C_FY2004.zip
|   |-- RePORTER_PRJ_C_FY2005.csv
|   |-- RePORTER_PRJ_C_FY2005.zip
|   |-- RePORTER_PRJ_C_FY2006.csv
|   |-- RePORTER_PRJ_C_FY2006.zip
|   |-- RePORTER_PRJ_C_FY2007.csv
|   |-- RePORTER_PRJ_C_FY2007.zip
|   |-- RePORTER_PRJ_C_FY2008.csv
|   |-- RePORTER_PRJ_C_FY2008.zip
|   |-- RePORTER_PRJ_C_FY2009.csv
|   |-- RePORTER_PRJ_C_FY2009.zip
|   |-- RePORTER_PRJ_C_FY2010.csv
|   |-- RePORTER_PRJ_C_FY2010.zip
|   |-- RePORTER_PRJ_C_FY2011.csv
|   |-- RePORTER_PRJ_C_FY2011.zip
|   |-- RePORTER_PRJ_C_FY2012.csv
|   |-- RePORTER_PRJ_C_FY2012.zip
|   |-- RePORTER_PRJ_C_FY2013.csv
|   |-- RePORTER_PRJ_C_FY2013.zip
|   |-- RePORTER_PRJ_C_FY2014.csv
|   |-- RePORTER_PRJ_C_FY2014.zip
|   |-- RePORTER_PRJ_C_FY2015.csv
|   |-- RePORTER_PRJ_C_FY2015.zip
|   |-- RePORTER_PRJ_C_FY2016.zip
|   |-- RePORTER_PRJ_C_FY2016_new.csv
|   |-- RePORTER_PRJ_C_FY2017.zip
|   |-- RePORTER_PRJ_C_FY2017_new.csv
|   |-- RePORTER_PRJ_C_FY2018.zip
|   |-- RePORTER_PRJ_C_FY2018_new.csv
|   |-- RePORTER_PRJ_C_FY2019.zip
|   |-- RePORTER_PRJ_C_FY2019_new.csv
|   |-- RePORTER_PRJ_C_FY2020.csv
|   |-- RePORTER_PRJ_C_FY2020.zip
|   |-- RePORTER_PRJ_C_FY2021.csv
|   `-- RePORTER_PRJ_C_FY2021.zip
|-- publinks
|   |-- REPORTER_PUBLNK_C_2016.csv
|   |-- REPORTER_PUBLNK_C_2017.csv
|   |-- REPORTER_PUBLNK_C_2018.csv
|   |-- REPORTER_PUBLNK_C_2019.csv
|   |-- REPORTER_PUBLNK_C_2020.csv
|   |-- RePORTER_PUBLNK_C_1980.csv
|   |-- RePORTER_PUBLNK_C_1981.csv
|   |-- RePORTER_PUBLNK_C_1982.csv
|   |-- RePORTER_PUBLNK_C_1983.csv
|   |-- RePORTER_PUBLNK_C_1984.csv
|   |-- RePORTER_PUBLNK_C_1985.csv
|   |-- RePORTER_PUBLNK_C_1986.csv
|   |-- RePORTER_PUBLNK_C_1987.csv
|   |-- RePORTER_PUBLNK_C_1988.csv
|   |-- RePORTER_PUBLNK_C_1989.csv
|   |-- RePORTER_PUBLNK_C_1990.csv
|   |-- RePORTER_PUBLNK_C_1991.csv
|   |-- RePORTER_PUBLNK_C_1992.csv
|   |-- RePORTER_PUBLNK_C_1993.csv
|   |-- RePORTER_PUBLNK_C_1994.csv
|   |-- RePORTER_PUBLNK_C_1995.csv
|   |-- RePORTER_PUBLNK_C_1996.csv
|   |-- RePORTER_PUBLNK_C_1997.csv
|   |-- RePORTER_PUBLNK_C_1998.csv
|   |-- RePORTER_PUBLNK_C_1999.csv
|   |-- RePORTER_PUBLNK_C_2000.csv
|   |-- RePORTER_PUBLNK_C_2001.csv
|   |-- RePORTER_PUBLNK_C_2002.csv
|   |-- RePORTER_PUBLNK_C_2003.csv
|   |-- RePORTER_PUBLNK_C_2004.csv
|   |-- RePORTER_PUBLNK_C_2005.csv
|   |-- RePORTER_PUBLNK_C_2006.csv
|   |-- RePORTER_PUBLNK_C_2007.csv
|   |-- RePORTER_PUBLNK_C_2008.csv
|   |-- RePORTER_PUBLNK_C_2009.csv
|   |-- RePORTER_PUBLNK_C_2010.csv
|   |-- RePORTER_PUBLNK_C_2011.csv
|   |-- RePORTER_PUBLNK_C_2012.csv
|   |-- RePORTER_PUBLNK_C_2013.csv
|   |-- RePORTER_PUBLNK_C_2014.csv
|   |-- RePORTER_PUBLNK_C_2015.csv
|   |-- RePORTER_PUBLNK_C_2021.csv
|   |-- RePORTER_PUBLNK_C_FY1980.zip
|   |-- RePORTER_PUBLNK_C_FY1981.zip
|   |-- RePORTER_PUBLNK_C_FY1982.zip
|   |-- RePORTER_PUBLNK_C_FY1983.zip
|   |-- RePORTER_PUBLNK_C_FY1984.zip
|   |-- RePORTER_PUBLNK_C_FY1985.zip
|   |-- RePORTER_PUBLNK_C_FY1986.zip
|   |-- RePORTER_PUBLNK_C_FY1987.zip
|   |-- RePORTER_PUBLNK_C_FY1988.zip
|   |-- RePORTER_PUBLNK_C_FY1989.zip
|   |-- RePORTER_PUBLNK_C_FY1990.zip
|   |-- RePORTER_PUBLNK_C_FY1991.zip
|   |-- RePORTER_PUBLNK_C_FY1992.zip
|   |-- RePORTER_PUBLNK_C_FY1993.zip
|   |-- RePORTER_PUBLNK_C_FY1994.zip
|   |-- RePORTER_PUBLNK_C_FY1995.zip
|   |-- RePORTER_PUBLNK_C_FY1996.zip
|   |-- RePORTER_PUBLNK_C_FY1997.zip
|   |-- RePORTER_PUBLNK_C_FY1998.zip
|   |-- RePORTER_PUBLNK_C_FY1999.zip
|   |-- RePORTER_PUBLNK_C_FY2000.zip
|   |-- RePORTER_PUBLNK_C_FY2001.zip
|   |-- RePORTER_PUBLNK_C_FY2002.zip
|   |-- RePORTER_PUBLNK_C_FY2003.zip
|   |-- RePORTER_PUBLNK_C_FY2004.zip
|   |-- RePORTER_PUBLNK_C_FY2005.zip
|   |-- RePORTER_PUBLNK_C_FY2006.zip
|   |-- RePORTER_PUBLNK_C_FY2007.zip
|   |-- RePORTER_PUBLNK_C_FY2008.zip
|   |-- RePORTER_PUBLNK_C_FY2009.zip
|   |-- RePORTER_PUBLNK_C_FY2010.zip
|   |-- RePORTER_PUBLNK_C_FY2011.zip
|   |-- RePORTER_PUBLNK_C_FY2012.zip
|   |-- RePORTER_PUBLNK_C_FY2013.zip
|   |-- RePORTER_PUBLNK_C_FY2014.zip
|   |-- RePORTER_PUBLNK_C_FY2015.zip
|   |-- RePORTER_PUBLNK_C_FY2016.zip
|   |-- RePORTER_PUBLNK_C_FY2017.zip
|   |-- RePORTER_PUBLNK_C_FY2018.zip
|   |-- RePORTER_PUBLNK_C_FY2019.zip
|   |-- RePORTER_PUBLNK_C_FY2020.zip
|   `-- RePORTER_PUBLNK_C_FY2021.zip
`-- pubs
    |-- REPORTER_PUB_C_2016.csv
    |-- REPORTER_PUB_C_2017.csv
    |-- REPORTER_PUB_C_2018.csv
    |-- REPORTER_PUB_C_2019.csv
    |-- REPORTER_PUB_C_2020.csv
    |-- RePORTER_PUB_C_1980.csv
    |-- RePORTER_PUB_C_1981.csv
    |-- RePORTER_PUB_C_1982.csv
    |-- RePORTER_PUB_C_1983.csv
    |-- RePORTER_PUB_C_1984.csv
    |-- RePORTER_PUB_C_1985.csv
    |-- RePORTER_PUB_C_1986.csv
    |-- RePORTER_PUB_C_1987.csv
    |-- RePORTER_PUB_C_1988.csv
    |-- RePORTER_PUB_C_1989.csv
    |-- RePORTER_PUB_C_1990.csv
    |-- RePORTER_PUB_C_1991.csv
    |-- RePORTER_PUB_C_1992.csv
    |-- RePORTER_PUB_C_1993.csv
    |-- RePORTER_PUB_C_1994.csv
    |-- RePORTER_PUB_C_1995.csv
    |-- RePORTER_PUB_C_1996.csv
    |-- RePORTER_PUB_C_1997.csv
    |-- RePORTER_PUB_C_1998.csv
    |-- RePORTER_PUB_C_1999.csv
    |-- RePORTER_PUB_C_2000.csv
    |-- RePORTER_PUB_C_2001.csv
    |-- RePORTER_PUB_C_2002.csv
    |-- RePORTER_PUB_C_2003.csv
    |-- RePORTER_PUB_C_2004.csv
    |-- RePORTER_PUB_C_2005.csv
    |-- RePORTER_PUB_C_2006.csv
    |-- RePORTER_PUB_C_2007.csv
    |-- RePORTER_PUB_C_2008.csv
    |-- RePORTER_PUB_C_2009.csv
    |-- RePORTER_PUB_C_2010.csv
    |-- RePORTER_PUB_C_2011.csv
    |-- RePORTER_PUB_C_2012.csv
    |-- RePORTER_PUB_C_2013.csv
    |-- RePORTER_PUB_C_2014.csv
    |-- RePORTER_PUB_C_2015.csv
    |-- RePORTER_PUB_C_2021.csv
    |-- RePORTER_PUB_C_FY1980.zip
    |-- RePORTER_PUB_C_FY1981.zip
    |-- RePORTER_PUB_C_FY1982.zip
    |-- RePORTER_PUB_C_FY1983.zip
    |-- RePORTER_PUB_C_FY1984.zip
    |-- RePORTER_PUB_C_FY1985.zip
    |-- RePORTER_PUB_C_FY1986.zip
    |-- RePORTER_PUB_C_FY1987.zip
    |-- RePORTER_PUB_C_FY1988.zip
    |-- RePORTER_PUB_C_FY1989.zip
    |-- RePORTER_PUB_C_FY1990.zip
    |-- RePORTER_PUB_C_FY1991.zip
    |-- RePORTER_PUB_C_FY1992.zip
    |-- RePORTER_PUB_C_FY1993.zip
    |-- RePORTER_PUB_C_FY1994.zip
    |-- RePORTER_PUB_C_FY1995.zip
    |-- RePORTER_PUB_C_FY1996.zip
    |-- RePORTER_PUB_C_FY1997.zip
    |-- RePORTER_PUB_C_FY1998.zip
    |-- RePORTER_PUB_C_FY1999.zip
    |-- RePORTER_PUB_C_FY2000.zip
    |-- RePORTER_PUB_C_FY2001.zip
    |-- RePORTER_PUB_C_FY2002.zip
    |-- RePORTER_PUB_C_FY2003.zip
    |-- RePORTER_PUB_C_FY2004.zip
    |-- RePORTER_PUB_C_FY2005.zip
    |-- RePORTER_PUB_C_FY2006.zip
    |-- RePORTER_PUB_C_FY2007.zip
    |-- RePORTER_PUB_C_FY2008.zip
    |-- RePORTER_PUB_C_FY2009.zip
    |-- RePORTER_PUB_C_FY2010.zip
    |-- RePORTER_PUB_C_FY2011.zip
    |-- RePORTER_PUB_C_FY2012.zip
    |-- RePORTER_PUB_C_FY2013.zip
    |-- RePORTER_PUB_C_FY2014.zip
    |-- RePORTER_PUB_C_FY2015.zip
    |-- RePORTER_PUB_C_FY2016.zip
    |-- RePORTER_PUB_C_FY2017.zip
    |-- RePORTER_PUB_C_FY2018.zip
    |-- RePORTER_PUB_C_FY2019.zip
    |-- RePORTER_PUB_C_FY2020.zip
    `-- RePORTER_PUB_C_FY2021.zip
```
