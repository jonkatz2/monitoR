# NEWS for monitoR R package

# monitoR 1.2 2025 April 11
## BUG FIXES
* A few issues on R-devel and even R-release. 
  Includes some R code and DESCRIPTION file.
  See issues [#23](https://github.com/jonkatz2/monitoR/issues/23)
  and [#19](https://github.com/jonkatz2/monitoR/issues/19).
  No changes in functionality expected.

# monitoR 1.1 2024 March 21
## FUNCTIONALITY
* `binMatch()` and `corMatch()` can now work with Wave objects without using `write.wav = TRUE`.
  See issue [#21](https://github.com/jonkatz2/monitoR/issues/21)

## BUG FIXES
*A few fixes. See issue [#18](https://github.com/jonkatz2/monitoR/issues/18).

# monitoR 1.0.7 2018 February 14

## NEW ARGUMENTS
*corMatch() and binMatch() now have a "quiet" argument that will suppress console
messages when set to TRUE (thanks to GitHub user gannebamm). The unused warn 
argument has been removed.

*spectro() has a new "..." argument. Now "warn" could be used and passed to 
binMatch() and corMatch() functions.

## BUG FIXES
*Minor fixes

# monitoR 1.0.5 2017 February 17

## CHANGED FUNCTION NAME
*The cutw() function was renamed cutWave() in the last version of monitoR to 
avoid conflict with the cutw() function in the seewave package. The cutw() 
function has now been removed.

# monitoR 1.0.4 2015 September 18
## MAILING LIST
There is now a monitoR mailing list. To subscribe, send a message with the
subject "monitoR: subscribe" to sdh11@cornell.edu or jonkatz4@gmail.com.
Subscribers will receive an update whenever a new version of the package or new
documentation is available.

## BUG FIXES
*New rec.tz argument in fileCopyRename() and templateMatching(). This optional
argument can prevent problems resulting from a time zone mismatch between a
recorder and R (computer operating system), e.g., when the operating system
adjusts its clock for daylight savings but the recorder does not.

*Other minor bug fixes

## CHANGED FUNCTION NAME
*The cutw() function has been renamed cutWave() to avoid conflict with the
cutw() function in the seewave package. Users can still call cutw() in this
version of monitoR (with a warning) but it will be removed in the next update.

# monitoR 1.0.3 2015 April 23
* Added hours.offset argument to fileCopyRename() for manual override of 
timezone management.

* Global time-zone detection in binMatch() and corMatch() when
time.source="filename".

* Streamlined database functions; most query arguments are now optional.

* Added write.wav argument to makeCorTemplate(), makeBinTemplate(),
corMatch(), and binMatch. If a Wave object is used for the first argument 
(clip or survey), these function no longer automatically write the object to
file (but will do so if write.wav=TRUE). 

* makeBinTemplate() New behavior for dens argument: points are now randomly 
sampled, and repeated selection of an area increases the density. 

* New function templatePath() for extracting or replacing the paths for Wave 
files.

* Added option to plot template over detections using argument box="template" 
in showPeaks().

# monitoR 1.0.2 2014 May 15
* Minor bug fixes.

# monitoR 1.0.1 2014 March 28
* seewave and its dependencies no longer required for installation of monitoR.

# 2014 March 27 monitoR 1.0.0
Initial upload to CRAN.


