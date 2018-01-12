\name{collapseClips}
\alias{collapseClips}

\title{
Summarize/Archive Song Events
}
\description{
Read in a \code{\link[tuneR]{Wave}} object, extract the song events, and bind them into a single \code{Wave} object for archiving or comparison viewing.
}
\usage{
collapseClips(rec, start.times, end.times, return.times = FALSE)

}
\arguments{
  \item{rec}{Object of class \code{Wave} or file path to wave file.}
  \item{start.times}{Vector of event start times, in seconds.}
  \item{end.times}{Vector of event end times, in seconds.}
  \item{return.times}{Logical.  \code{TRUE} will return }
}
\details{
A stripped-down version of \code{\link{bindEvents}}, perhaps more readily applied to the output of \code{\link{findPeaks}}.
}

\value{
If \code{return.times = FALSE}, an object of class \code{Wave}.
If \code{return.times = TRUE}, a list:
  \item{times}{A data frame with the start and end times of events in the wave object}
  \item{wave}{An object of class \code{Wave}}
}

\author{
Sasha D. Hafner
}

\seealso{
\code{\link{viewSpec}}, \code{\link{bindEvents}}, \code{\link[tuneR]{bind}}.
}

\examples{
data(survey_anno)

data(survey)

events <- collapseClips(rec = survey, start.times = survey_anno[, "start.time"], 
                        end.times = survey_anno[, "end.time"], return.times = FALSE)
}

\keyword{manip}
