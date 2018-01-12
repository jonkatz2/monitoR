\name{showPeaks}
\alias{showPeaks}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
View or Verify Detections or Peaks
}
\description{
Use this function to view a spectrogram and score plot of detections or peaks.
In its simplest usage, \code{showPeaks} will show all detections within for the first template within the detection list object, one after the other.
With the verify option (\code{verify = TRUE}), the user can tag detections or peaks as \code{TRUE} or \code{FALSE}, and these results will be saved in an updated detection list object.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
showPeaks(detection.obj, which.one = names(detection.obj@templates)[1], fd.rat = 4, 
frame = fd.rat * detection.obj@templates[[which.one]]@duration, id = 1:nrow(pks), 
t.lim, flim = c(0, 20), point = TRUE, ask = if (verify) FALSE else TRUE, 
scorelim = NULL, verify = FALSE, what = "detections", box = TRUE, 
player = "play", spec.col = gray.3(), on.col = '#FFA50075', off.col = '#0000FF75', 
pt.col = '#FFA50075')
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{detection.obj}{
    A detection list object (\code{\linkS4class{detectionList}}).
}
  \item{which.one}{
    Which template should be shown? Identify by name or position. Length-one integer or character vector.
}
  \item{fd.rat}{
    Ratio of plot frame (time duration of plots) to template duration.
}
  \item{frame}{
    Or, specify the plot frame (x limits of plots) instead of \code{fr.rate}. Length-one numeric vector.
}
  \item{id}{
    Use to specify which peaks or detections will be shown. Integer vector.
}
  \item{t.lim}{
    Or, to view only those detections or peaks within a certain time range, specify it here. Length-two numeric vector.
}
  \item{flim}{
    Frequency limits (y axis limits) for the spectrogram. Length-two numeric vector.
}
  \item{point}{
    If \code{TRUE}, plot points to show detection or peak locations.
}
  \item{ask}{
    The setting of the \code{\link{par}} setting \code{ask}. Default value is based on other arguments, and should suffice in most cases.
}
  \item{scorelim}{
    Score limits (y axis limits) for the score plot.
}
  \item{verify}{
    If \code{TRUE}, R will prompt user to identify whether detections are \code{TRUE}
}
  \item{what}{
    Should all peaks (\code{what = "peaks"}) or just detections (\code{what = "detections"}) be shown?
}
  \item{box}{
    If \code{TRUE} plot a box around detections in the spectrogram. Box boundaries are based on template duration and frequency limits. Can also be set to "template" to see the template points plotted over the detection.
}
  \item{player}{
    If \code{verify = TRUE}, the user will have the option to play the detection or peak. This argument is the command used for starting the player. See Details.
}
  \item{spec.col}{
    A vector of colors for the spectrogram.
}
  \item{on.col}{
    Colors for the on points of a binary point template, if \code{box = "template"}. Default is #RRGGBBAA, where AA is the transparency.
}
  \item{off.col}{
    Colors for the off points of a binary point template, if \code{box = "template"}. Default is #RRGGBBAA, where AA is the transparency.
}
  \item{pt.col}{
    Colors for the points of a correlation template, if \code{box = "template"}. Default is #RRGGBBAA, where AA is the transparency.
}
}
\details{
Note that almost all of the arguments have a default value.\cr
The default audio player, "play", is the shell command for SoX, the multi-OS media player. Windows will detect the file type and use the default media player with "start", or you can specify one (such as Windows Media Player) with "start wmplayer.exe". On Ubuntu try Rhythmbox ("rhythmbox"), and on Mac OS try afplay ("afplay").        
}
\value{
\code{NULL}, invisibly, or, if \code{verify = TRUE}, an updated detection list object (\code{\linkS4class{detectionList}}).
}
\author{
Sasha D. Hafner
}

\seealso{
  \code{\link{findPeaks}}, 
  \code{\link{plot-methods}}
}
\examples{
# Load data
data(btnw)
data(oven)
data(survey)

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
cdetects

# Interactively inspect individual detections, no return value
\dontrun{
# Not run because user input is required
showPeaks(detection.obj = cdetects, which.one = "w", flim = c(2, 8), point = TRUE, 
          scorelim = c(0, 1))

# Interactively verify individual detections, return adds verification field
cdetects <- showPeaks(detection.obj = cdetects, which.one = "w", flim = c(0, 20), 
                      point = TRUE, scorelim = c(0, 1), verify = TRUE)
}

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{dynamic}
\keyword{iplot}
