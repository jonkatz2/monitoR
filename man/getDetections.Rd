\name{getDetections}
\alias{getDetections}
\alias{getPeaks}

\title{
  Extract Detections or Peaks from a \code{detectionList} Object
}

\description{
  These functions return detection and peak timing and scores from a \code{detectionList} object for one or more templates used to create the object.
}

\usage{
getDetections(detection.obj, which.one = names(detection.obj@detections), id = NULL, 
              output = "data frame")

getPeaks(detection.obj, which.one = names(detection.obj@detections), id = NULL, 
         output = "data frame")
}

\arguments{
  \item{detection.obj}{
    The \code{detectionList} object.
  }

  \item{which.one}{
    The name(s) of the template(s) for which results should be returned.
    Character vector.
  }

  \item{id}{
    Additional information that will be added as an additional column in the returned data frame(s).
    By default, no column is added.
    Length-one vector.
  }

  \item{output}{
    Type of output, can be \code{"data frame"} or \code{"list"}.
    List output contains a single element (a data frame) for each template.
  }

}
\details{
  The \code{id} argument is for adding an identifying \dQuote{tag} to the output.
  This could be useful when, e.g., extracting detections for multiple surveys and then combining all results into a single data frame.
}

\value{
  A data frame with up to six (seven for \code{getPeaks}) columns: \code{id} (from the \code{id} argument) (optional), template name (\code{template}), date and time (\code{date.time}, relative \code{time} (relative to the recording start), \code{score}, and verification results (\code{true}) (only present if the \code{detectionList} contains verification results from \code{showPeaks}).
  Or, a list with a separate data frame for each template.
  For \code{getPeaks}, there is also a \code{detection} column, with \code{TRUE} when a peak has been identified as a detection.
}

\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{findPeaks}}
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

# Combine both of them
ctemps <- combineCorTemplates(wct, oct)

# Calculate scores
cscores <- corMatch(survey.fp, ctemps)

# Find peaks
cdetects <- findPeaks(cscores)

# Finally, get detections
getDetections(cdetects)

# If list is preferred
getDetections(cdetects, output = "list")

# For select templates
getDetections(cdetects, which.one = 1)
getDetections(cdetects, which.one = "w")

# Or for all peaks
getPeaks(cdetects)
getPeaks(cdetects, output = "list")
getPeaks(cdetects, which.one = 1)

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
file.remove(survey.fp)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}

