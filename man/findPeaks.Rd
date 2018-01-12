\name{findPeaks}
\alias{findPeaks}

\title{
  Find Score Peaks and Detections in a \code{templateScores} Object
  }

\description{
  This function accepts \code{templateScores} objects and returns information on all score peaks and those peaks that are considered detections.
  }

\usage{
findPeaks(score.obj, fd.rat = 1, frame, parallel = FALSE)
  }

\arguments{
  \item{score.obj}{
    A \code{templateScores} object, produced by \code{corMatch} or \code{binMatch}.
  }

  \item{fd.rat}{
    A ratio of frame width (twice minimum peak separation) to template duration. 
  }

  \item{frame}{
    If you want the same frame width for templates with varying duration, specify a value directly.
    \code{fd.rate} will be ignored if \code{frame} is specified.
  }

  \item{parallel}{
    Set to \code{TRUE} for parallel processing using \code{\link[parallel]{mclapply}}.
    This option is not available for Windows operating systems.
  }
}

\details{
The \code{findPeaks} function translates raw scores from template matching to detection information, by finding peaks in the score data, and determining which peaks, if any, exceed the score cutoffs specified in the templates (see the two functions for making templates, \code{\link{makeBinTemplate}} and \code{\link{makeCorTemplate}} and \code{\link{templateCutoff}} for more details on cutoffs). 
}

\value{
An S4 object of class \code{templateScores}, with the following slots:

  \item{survey.name}{The file path to the survey that the scores apply to.}
  \item{survey}{The actual survey as a \code{Wave} object.}
  \item{survey.data}{A named list with one element per template.
    Each element is a named list with time-domain results for the survey.
  }
  \item{templates}{The templates (an S4 object of class \code{corTemplateList} or \code{binTemplateList}) used to calculate the scores.}
  \item{scores}{A named list with an element for each template.
    Each element contains the scores for an individual template.
  }
  \item{peaks}{A named list with peak information (as a data frame) for each template.}
  \item{detections}{A named list with detection information (as a data frame) for each template.}
}

\author{
  Sasha D. Hafner and Jon Katz
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}, 
\code{\link{corMatch}}, 
\code{\link{binMatch}}, 
\code{\link{getDetections}}, 
\code{\link{getPeaks}}
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

# Finally, find peaks and detections
cdetects <- findPeaks(cscores)

cdetects

plot(cdetects)

# plotting help:
method?plot('detectionList')

# Binary example
\dontrun{
# Not run because of the time required (maybe 2-5 seconds) Create two templates
wbt <- makeBinTemplate(btnw.fp, amp.cutoff = -30, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6),
                       buffer = 2, name = "w")

obt <- makeBinTemplate(oven.fp, amp.cutoff = -20, t.lim = c(1, 4), frq.lim = c(1, 11), 
                       name = "o")

# Combine them
btemps <- combineBinTemplates(wbt, obt)

# Calculate scores
bscores <- binMatch(survey.fp, btemps)

# Finally, find peaks and detections
bdetects <- findPeaks(bscores)

bdetects

plot(bdetects)
}

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
file.remove(survey.fp)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}

