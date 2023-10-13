# Package overview
The monitoR package is designed for bioacoustic detection and monitoring. 
Two different approaches are available for detecting animal vocalizations within recordings: binary point matching and spectrogram cross-correlation. 
Both require development of a template, which is easy to make once a suitable recording has been identified. 
Additional monitoR functions provide tools for extracting and evaluating results; saving and reading templates; and managing a complete monitoring program, including connecting with a MySQL database.

# Installation
You can install monitoR from CRAN directly in R using the menus or with:

```
install.packages("monitoR")
```

For releases on GitHub but not (yet) on CRAN you need the devtools package.
Typically, you should install the latest release:

```
devtools::install_github("jonkatz2/monitoR@*release", build_vignettes = TRUE)
```

Alternatively, to get the current master branch version, use:

```
devtools::install_github("jonkatz2/monitoR", build_vignettes = TRUE)
```

Or the dev branch:

```
devtools::install_github("jonkatz2/monitoR", ref = "dev", build_vignettes = TRUE)
```

Or for a particular commit:


```
devtools::install_github("jonkatz2/monitoR@3b9d99bc3615898e1c901dc81c57894765ae651c", build_vignettes = TRUE)
```


# Learning to use monitoR
To learn how to use the package, the best place to start is with the package vignette, available from the monitoR CRAN webpage, and also installed with the package. 
If you have installed it with the package, you can view the vignette with this R command:

```
vignette("monitoR_QuickStart")
```

For more details, see the help files on individual functions. 
You can view all available functions in the reference manual, also available on the monitoR CRAN webpage, or returned by this command: 

```
library(help = "monitoR")
```

The following two papers describe the package and its use in some detail:

Katz, J., Hafner, S.D., Donovan, T. 2016. Tools for automated acoustic monitoring within the R package monitoR. Bioacoustics 25: 197-210. (download [here](https://drive.google.com/file/d/1wmcs0UgSs8OG2cOcD8v7f2ckx8q9-UWB/view?usp=sharing))

Katz, J., Hafner, S.D., Donovan, T. 2016. Assessment of Error Rates in Acoustic Monitoring with the R package monitoR. Bioacoustics 25: 177-196. (download [here](https://drive.google.com/file/d/1OG2QKCf_erxv9REAJwNHGh17NSmWHTcS/view?usp=sharing))

# Mailing list
If you want to join the monitoR mailing list, send a message with the subject "monitoR: subscribe" to sdh11@cornell.edu or jonkatz4@gmail.com. 
Subscribers will receive an update whenever a new version of the package or new documentation is available.



