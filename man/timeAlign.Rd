\name{timeAlign}
\alias{timeAlign}
\title{
Condense Detections or Peaks from Multiple Templates
}
\description{
Condense detections or peaks from a number of templates (of the same detection type); events that occur within an adjustable time buffer of one another are assumed to be duplicate detections.  In such cases the event with the highest score is saved.  Functions with detections for a single species or multiple species.
}
\usage{
timeAlign(x, what = "detections", tol = 1)
}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{An object of class \code{\linkS4class{detectionList}}, a single data frame of detections, or list of either file paths to a csv file or of data frames.}
  \item{what}{Character, in \code{c("detections", "peaks")}.  Detections are peaks above a score cutoff.  Peaks are all peaks.  Required only if \code{x} is of class \code{detectionList}}
  \item{tol}{Numeric value for tolerance, with units seconds.  If a detected event is within this value (actually +/- 0.5\code{tol}), the events are assumed to co-occur and be of the same origin.  A somewhat arbitrary value (like epsilon), but should be less than 2/3 the template duration.}
}

\details{
If input is an object of class \code{\linkS4class{detectionList}}, a single data frame, or list of either file paths or data frames.  Must be called for each survey.
}

\value{
Returns a single data frame of detections (the input \code{x}) with duplicated events removed, leaving only the event that had the highest score.
}

\author{
Jon Katz
}

\note{
Events are assumed to be duplicated if they co-occur within a time duration of \code{tol}, but they are only compared to the event above and below when ordered by time.  Events with similar times can be spuriously discarded if \code{tol} is set larger than the separation of unrelated peaks.  Excessive deletion of events may also occur if the value for \code{tol} is set larger than the duration of the template.   Note that in this function \code{tol} specifies seconds, whereas in \code{\link{findPeaks}} \code{tol} specifies a ratio.   
}

\seealso{
The function \code{\link{eventEval}} operates similarly, but rather than merge detection results from multiple templates it compares them to known events and reports the True +, True -, False +, and False - rates.
}

\examples{
\dontrun{
# Not run because it will create files in user's working directory
data(survey)
data(btnw)

writeWave(btnw, "btnw.wav")

btnw2 <- cutw(survey, from = 0.75, to = 3)

writeWave(btnw2, "btnw2.wav")

# Template construction
btnw1 <- makeBinTemplate(
        "btnw.wav", 
        frq.lim = c(2, 8), 
        select = "auto", 
        name = "btnw1", 
        buffer = 4, 
        amp.cutoff = -31, 
        binary = TRUE)

btnw2 <- makeBinTemplate(
        "btnw2.wav", 
        frq.lim = c(2, 8), 
        select = "auto", 
        name = "btnw2", 
        buffer = 4, 
        amp.cutoff = -24, 
        binary = TRUE)

# Join templates
btnw <- combineBinTemplates(btnw1, btnw2)

# Binary point matching
scores <- binMatch(survey = survey, templates = btnw, time.source = 'fileinfo')

# Isolate peaks
pks <- findPeaks(scores)

# View detections
getDetections(pks)

# Compare to output of timeAlign
timeAlign(pks)}
}

\keyword{manip}
