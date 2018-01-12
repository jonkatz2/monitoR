\name{plot-methods}
\docType{methods}
\alias{plot-methods}
\alias{plot,TemplateList,ANY-method}
\alias{plot,detectionList,ANY-method}
\title{Methods for the \code{plot} Function}
\description{Plotting acoustic templates and template scores}

\usage{
\S4method{plot}{TemplateList,ANY}(x, which.one = names(x@templates), click = FALSE, 
ask = if(length(which.one)>1) TRUE else FALSE, spec.col = gray.3(), on.col = '#FFA50075', 
off.col = '#0000FF75', pt.col = '#FFA50075', line.col = 'black')

\S4method{plot}{detectionList,ANY}(x, flim = c(0, 12), scorelim, 
which.one = names(x@templates), box = TRUE, spec.col = gray.2(), t.each = 30, 
hit.marker = 'lines', 
color = c('red', 'blue', 'green', 'orange', 'purple', 'pink', 'darkgreen', 'turquoise', 
'royalblue', 'orchid4', 'brown', 'salmon2'), legend = TRUE, all.peaks = FALSE, 
ask = if(dev.list() == 2) TRUE else FALSE)
}

\arguments{
  \item{x}{A template list (\code{\linkS4class{TemplateList}} object) or detection list (\code{\linkS4class{detectionList}} object).}
  \item{which.one}{Names of templates to be plotted.}
  \item{click}{Set to \code{TRUE} to see values of locations on plot by mouse clicks.}
  \item{ask}{Set to \code{FALSE} to eliminate pause between plots.}
  \item{spec.col}{Color ramp for spectrogram.}
  \item{on.col}{Color for ``on'' points (binary templates only).}
  \item{off.col}{Color for ``off'' points (binary templates only).}
  \item{pt.col}{Color for template points (correlation templates only).}
  \item{line.col}{Color for lines if \code{click = TRUE}.}
  \item{flim}{Frequency limits for plot.}
  \item{scorelim}{Score limits for plot.}
  \item{box}{If \code{TRUE} boxes are plotted in spectrogram for each detection.}
  \item{t.each}{Duration shown in each individual plot (s).}
  \item{hit.marker}{Type of marker used to show detections in score plot. Can be \code{"lines"} or \code{"points"}.}
  \item{color}{Colors used for individual templates.}
  \item{legend}{Show legend?}
  \item{all.peaks}{Indicate location of all peaks?}
}

\author{
Sasha D. Hafner
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}
}

\examples{
\dontrun{
# Not run because of the time required (maybe 5-10 seconds)
# Also some plot calls require user input by default
# Load data
data(btnw)
data(survey)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")
oven.fp <- file.path(tempdir(), "oven.wav")
survey.fp <- file.path(tempdir(), "survey2010-12-31_120000_EST.wav")
writeWave(btnw, btnw.fp)
writeWave(survey, survey.fp)

# Create a template list
ctemp1 <- makeCorTemplate(btnw.fp, name = "w1")
ctemp2 <- makeCorTemplate(btnw.fp, t.lim = c(0.5, 2.5), frq.lim = c(1, 10), dens = 0.1, name = "w2")
ctemps <- combineCorTemplates(ctemp1, ctemp2)

# Then it can be plotted like this
plot(ctemps)

# Next call is not useful for template w1 but good for w2:
plot(ctemps, pt.col = "red")

# Can plot just one template
plot(ctemps, which.one = 2, pt.col = "red")
plot(ctemps, which.one = "w2", pt.col = "red")

# And to check values
plot(ctemps, which.one = 1, click = TRUE)

# To plot detections, let's create some
cscores <- corMatch(survey.fp, ctemps)
cdetects <- findPeaks(cscores)

# And to plot them:
plot(cdetects)

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(survey.fp)
}
}

\keyword{methods}
\keyword{hplot}
