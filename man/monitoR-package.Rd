\name{monitoR}
\alias{monitoR-package}
\alias{monitoR}
\docType{package}

\title{Automated Acoustic Monitoring--overview and examples}

\description{monitoR contains functions for template matching, template construction, spectrogram viewing and annotation, and direct MySQL database connectivity.  This package offers two fully-supported template matching algorithms: binary point matching and spectrogram cross-correlation.  The direct database connection facilitates efficient data management when batch processing as well as template storage and sharing.  It supplies a database schema that is useful for managing recorders in the field as well as functions for reading metadata from sound files when they are copied from external media.}

\details{
For an introduction to the package see the vignette. For some introductory examples, see \sQuote{Examples} below.
}

\section{Acknowledgments}{A Fourier transformed is used in the \pkg{monitoR} package to transform time-domain acoustic data to frequency-domain data (i.e., the data displayed in the spectrograms used to produce templates). The \code{spectro} function used in our package is a pared-down version of a function of the same name in Jerome Sueur's excellent package \pkg{seewave}. To use \code{spectro}, the \pkg{seewave} functions \code{dBweight}, \code{ftwindow}, \code{hamming.w} and other window functions, and \code{stft} are from \pkg{seewave}. The function \code{\link{readMP3}} is modified from Uwe Ligges' package \pkg{tuneR}. And several other \pkg{tuneR} functions are used directly from the \pkg{tuneR} package. Without \pkg{seewave} and \pkg{tuneR} this project would have gotten off to a much slower start.   

Generous funding for this work was provided by the National Park Service, the U.S. Geological Survey, and the National Phenology Network.
}

\section{Disclaimer}{\dQuote{Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.}
}

\section{Functions in monitoR}{
Create a MySQL database (\code{\link{dbSchema}}), to which survey metadata, templates and metadata, and results can be sent. Copy sound files from external media (\code{\link{fileCopyRename}}) and upload the metadata to the database (\code{\link{dbUploadSurvey}}).  View and interactively annotate sound files of any length (\code{\link{viewSpec}}). Download a table of surveys from the database (\code{\link{dbDownloadSurvey}}), construct a template (\code{\link{makeBinTemplate}} or \code{\link{makeCorTemplate}}), detect/score events in a survey (\code{\link{binMatch}}, \code{\link{corMatch}}), apply a threshold to the scores (\code{\link{findPeaks}}), send the results to the database (\code{\link{dbUploadResult}}).
}

\author{
Sasha D. Hafner \email{sdh11@cornell.edu} and Jon Katz \email{jonkatz4@gmail.com}, with code for the Fourier transform from the seewave package (by Jerome Sueur, Thierry Aubin, and Caroline Simonis), and code for the readMP3 function from the tuneR package (by Uwe Ligges).

Maintainer: Sasha D. Hafner \email{sdh11@cornell.edu}
}

\references{
Ligges, Uwe.  2011. tuneR: Analysis of music. \url{http://r-forge.r-project.org/projects/tuner/}

Sueur J, Aubin, T, Simonis, C. 2008. Seewave: a free modular tool for sound analysis and synthesis. \emph{Bioacoustics} \bold{18}, 213-226.

Towsey M, Planitz, B, Nantes, A, Wimmer, J, Roe, P.  2012.  A toolbox for animal call recognition.  \emph{Bioacoustics} \bold{21}, 107-125.
}

\examples{
# View spectrograms
data(survey)
viewSpec(survey)

# Annotate features
\dontrun{
# Not run because it is interactive and a file is written to user's working directory
viewSpec(survey, annotate = TRUE)

# View previous annotations
data(survey_anno)

write.csv(survey_anno, "survey_anno.csv", row.names = FALSE)

viewSpec(survey, annotate = TRUE, anno = "survey_anno.csv", start.time = 5)
}

# Load example Wave object
data(btnw)
data(oven)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")
oven.fp <- file.path(tempdir(), "oven.wav")
survey.fp <- file.path(tempdir(), "survey2010-12-31_120000_EST.wav")

writeWave(btnw, btnw.fp)
writeWave(oven, oven.fp)
writeWave(survey, survey.fp)

# Correlation example
# Create two correlation templates
wct <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), name = "w")

oct <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, name = "o")

# Combine them
ctemps <- combineCorTemplates(wct, oct)

# Calculate scores
cscores <- corMatch(survey.fp, ctemps)

# Find peaks and detections
cdetects <- findPeaks(cscores)
\dontrun{
# Not run because it takes a second to draw the plot
# View results
plot(cdetects, hit.marker = "points")

# Interactively inspect individual detections
# Not run because it is interactive
cdetects <- showPeaks(cdetects, which.one = "w1", flim = c(2, 8), point = TRUE, 
                      scorelim = c(0, 1), verify = TRUE)
}
}

\keyword{package}
\keyword{iplot}
\keyword{IO}
\keyword{database}
