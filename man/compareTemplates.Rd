\name{compareTemplates}
\alias{compareTemplates}

\title{
Compare Performance of Templates
}
\description{
Provided a \code{\linkS4class{detectionList}} object containing results from N templates scored against the same survey with Y song events, \code{compareTemplates} will create a Y x N matrix to compare how each template scored each song event.  If the song events are the sound clips used to create each template, \code{compareTemplates} may be a means of measuring overall similarity among sound events.  Can be used to identify template clips that may match more than one song type.
}
\usage{
compareTemplates(detection.obj, cutoff.return, cutoff.ignore, tol, n.drop = 0)
}

\arguments{
  \item{detection.obj}{Object of class \code{\linkS4class{detectionList}}.}
  \item{cutoff.return}{Score cutoff below which events are not returned.}
  \item{cutoff.ignore}{Score cutoff below which events are ignored.}
  \item{tol}{Tolerance (s). If a peak is within \code{tol} of a peak from another template, they are in the same event.}
  \item{n.drop}{Rows with this many templates or fewer will be dropped. \code{n.drop = 0} drops none.}
}
\details{
The matrix is created by comparing the score for each event to the average score for that event.  For cases in which a template does not score an event above \code{cutoff} a value of \code{NA} is placed in the matrix for that template-event junction.  Similarly, if a template scores an event above \code{cutoff} but is beyond \code{tol} of the mean of other events, it will enter the matrix as its own event and an \code{NA} will be placed in the matrix for the event's junctions with other templates.
 
}
\value{
A list:
  \item{times.mean}{Vector of mean times for each row of the matrix.}
  \item{times}{Matrix of times for each event detection and template.}
%%  \item{date.time}{} %% Omitted from documentation, should we remove it from the function?
  \item{scores}{Matrix of scores for each event detection and template.}
}

\author{
Sasha D. Hafner
}
\note{
It can be difficult to make this function do the same grouping of peaks that a human might do.
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}
}
\examples{
# Load data
data(btnw)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")

writeWave(btnw, btnw.fp)

# Make three templates to compare
btnw.1 <- makeBinTemplate(clip = btnw.fp, frq.lim = c(2.75, 7), t.lim = c(.5, 2.5), 
                          amp.cutoff = -20, name = -20)

btnw.2 <- makeBinTemplate(clip = btnw.fp, frq.lim = c(2.75, 7), t.lim = c(.5, 2.5), 
                          amp.cutoff = -27, name = -27)

btnw.3 <- makeBinTemplate(clip = btnw.fp, frq.lim = c(2.75, 7), t.lim = c(.5, 2.5), 
                          amp.cutoff = -34, name = -34)

# Combine templates
templates <- combineBinTemplates(btnw.1, btnw.2, btnw.3)

survey <- bind(btnw, btnw, btnw)

survey.fp <- file.path(tempdir(), "survey.wav")

writeWave(survey, survey.fp)

scores <- binMatch(survey = survey.fp, templates = templates, time.source = "fileinfo")

pks <- findPeaks(scores)

compareTemplates(detection.obj = pks, cutoff.return = 12, cutoff.ignore = 6, tol = 1, 
                 n.drop = 0) 

# Clean up
file.remove(btnw.fp)
file.remove(survey.fp)
}


\keyword{manip}

