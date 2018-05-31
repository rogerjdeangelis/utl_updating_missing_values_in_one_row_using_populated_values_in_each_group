Updating missing values in one row using populated values in each group

same result in WPS and SAS

github
https://tinyurl.com/y8zd44rp
https://github.com/rogerjdeangelis/utl_updating_missing_values_in_one_row_using_populated_values_in_each_group

StackOverflow SAS
https://tinyurl.com/y7pd8xqk
https://stackoverflow.com/questions/50564574/updating-value-in-one-row-to-another-row-based-on-same-column-value

Tom's Profile
https://stackoverflow.com/users/4965549/tom

* you do get warnngs but it does work
data want;
  update have have(keep=fruit colour where=(not missing(colour)));
  by fruit;
run;quit;

INPUT
=====

 WORK.HAVE total obs=6           |         RULES use the non missing colors by fruit
                                 |         to fill in the missing values
   FRUIT     COUNTRY    COLOUR   | COLOR
                                 |
   Apple                         | Red
   Apple      USA       Red      | Red
                                 |
   Banana                        | Yellow
   Banana     Spain     Yellow   | Yellow
                                 |
   Pear       China     Green    | Green
   Pear                          | Green


PROCESS
=======

data want;
  merge have(drop=colour) have(keep=fruit colour where=(not missing(colour)));
  by fruit;
run;


OUTPUT
======

   WORK.WANT total obs=6

     FRUIT     COUNTRY    COLOUR

     Apple                Red
     Apple      USA       Red
     Banana               Yellow
     Banana     Spain     Yellow
     Pear       China     Green
     Pear                 Green

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data have;
  input FRUIT $ COUNTRY $ COLOUR $;
cards4;
Apple . .
Apple USA Red
Banana . .
Banana Spain Yellow
Pear China Green
Pear . .
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

see process for SAS solution

%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
data wrk.want;
  merge wrk.have(drop=colour) wrk.have(keep=fruit colour where=(not missing(colour)));
  by fruit;
run;quit;
proc print;
run;quit;
');

