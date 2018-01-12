\name{eventEval}
\alias{eventEval}
\title{
Evaluate Detected Events with Known Event Sources and Times
}
\description{
Evaluate whether the detected events are True +, True -, False +, or False - detections by comparing the results to a table of events with known sources and times (such as annotations from \code{\link{viewSpec}}).  Events to evaluate may be either directly from an object of class \code{\linkS4class{detectionList}}, a csv file or data frame resulting from a call to \code{\link{getPeaks}} or \code{\link{getDetections}}, or a data frame downloaded from an acoustics database.  A value for score.cutoff must be supplied to distinguish between True + and False -, even if assessing all peaks.
}
\usage{
eventEval(detections, what = "detections", which.one, standard, 
score.cutoff = 11, tol = 1)
}

\arguments{
  \item{detections}{An object of class \code{\linkS4class{detectionList}}, a csv file, or data frame containing detection results.  See Details.}

  \item{what}{If a \code{detectionList} object is supplied for \code{detections} the character value of either "detections" (default; all peaks above the score cutoff) or all "peaks" may be selected.}

  \item{which.one}{If the detection process involved multiple templates only one may be selected for evaluation.  Value can be either character (identifying the template name), or numerical (identifying the position in names(detections['template']).  See Details.}

  \item{standard}{The "standard" is the results from annotation with \code{viewSpec} (i.e. Gold Standard) containing the source and time of each event.  Can be a data frame or a file path to a csv file.}

  \item{score.cutoff}{If no template is supplied a \code{score.cutoff} can be supplied to evaluate false negatives.}

  \item{tol}{Numeric value for tolerance, with units seconds.  If a detected event is within this value (actually +/- 0.5 x \code{tol}), the events are assumed to co-occur and be of the same origin.}
}

\details{
Little checking is performed to ensure that evaluation is possible based on the values for detections and standard.  The standard must contain the fields \code{c("start.time", "end.time", "min.frq", "max.frq", "name")}.  Objects are assumed to be from an acoustics database if they contain the fields \code{c("fldTime", "fldScore", "fldTemplateName")}.  Data frames are assumed to be objects formerly of class \code{\linkS4class{detectionList}} if they contain the fields \code{c("time", "score", "template")}.\cr

Results from only one template from one survey may be evaluated in each call to \code{eventEval}.
}

\value{
The detections data frame with an outcome field appended.
}

\author{
Jon Katz
}

\note{
\code{eventEval} performs the evaluation by merging the detections and standard data frames, ordering by time, and checking to see which rows occur within a value of \code{tol} to the row above. True + are defined as a detected event that co-occurrs in time with an event from the standard AND scores above or equal to the score.cutoff.  Such an event that scores below the score.cutoff is classified as a False -.  False - events may also be the product of an event from the standard failing to co-occur with any detected events.  True - events don't co-occur with any standard events, and False + events similarly don't co-occur with standard events but score above or equal to the score.cutoff.
}

\seealso{
The function \code{\link{timeAlign}} operates similarly, but rather than evaluate a set of detections against a standard it merges detections from multiple templates and retains only the co-occurring detections with the highest scores.
}

\examples{
# Load data
data(btnw)
data(survey)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")
survey.fp <- file.path(tempdir(), "survey2010-12-31_120000_EST.wav")
writeWave(btnw, btnw.fp)
writeWave(survey, survey.fp)

# Make a template
btemp <- makeBinTemplate(btnw.fp, frq.lim = c(2, 8), select = "auto", name = "btnw1", buffer =
                         4, amp.cutoff = -31, binary = TRUE)

# Binary point matching
scores <- binMatch(survey = survey.fp, templates = btemp, time.source = "fileinfo")

# Isolate peaks
pks <- findPeaks(scores)

# Evaluate peaks
data(survey_anno)

survey_anno <- survey_anno[survey_anno['name'] == 'BTNW', ]  # Extract the "BTNW" rows

peaks <- getPeaks(pks) 

eval <- eventEval(detections = peaks, standard = survey_anno, score.cutoff = 15)



}

\keyword{manip}
