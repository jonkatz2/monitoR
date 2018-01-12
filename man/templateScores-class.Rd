\name{templateScores-class}
\Rdversion{1.1}
\docType{class}
\alias{templateScores-class}

\title{Class \code{"templateScores"}}
\description{
These objects contain template scores, which indicate how well templates match a single survey recording, with a value for each time bin.
Additionally, all the objects which were used to create these scores are also saved within the objects.
Objects of this class represent an intermediate step in the template detection process--detections need to be found in the scores using \code{\link{findPeaks}}. 
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("templateScores", ...)}.
However, they should always be created with the \code{\link{corMatch}} or \code{\link{binMatch}} function.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{survey.name}:}{Object of class \code{character}. The name of the survey file, or \code{"A Wave object"} if the survey was not read in from a file.}
    \item{\code{survey}:}{Object of class \code{\link[tuneR]{Wave}}. The survey data, as a \code{"Wave"} object.}
    \item{\code{survey.data}:}{Object of class \code{list}. A named list, with one element for each template. Each element contains data from a Fourier transform of the original survey: \code{amp} is a matrix of amplitudes (frequency by time), \code{t.bins} is a numeric vector with the values of the time bins (left-aligned--first bin is always 0.0), and \code{frq.bins} is a numeric vector with the values of the frequency bins (top-aligned--last bin is always the upper limit). There is a separate element for each template because each template may use different parameters for the Fourier transform (see \code{\linkS4class{Template}}).}
    \item{\code{templates}:}{Object of class \code{list}. A named list of templates, which is identical to the original \code{\linkS4class{TemplateList}} used for template matching. This template list can be extracted with \code{\link{getTemplates}}.}
    \item{\code{scores}:}{Object of class \code{list}. A named list, with one element for each template. Each element is a data frame with three columns: \code{date.time} is the absolute time of the score, \code{time} is the relative time of the score (relative to the survey start), and \code{score} is the score. Times are based on the center of the template, and so \code{time} will not correspond to values in \code{t.bins} in the \code{survey.data} above if the template spans an even number of time bins.}
    \item{\code{time}:}{Object of class \code{character}. Information on the time \code{\link{corMatch}} or \code{\link{binMatch}} took to run. The first element is the run time (s), and the second element is ``real-time factor'' (survey length divided by the run time).}
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "templateScores")}: ... }
    \item{summary}{\code{signature(object = "templateScores")}: ... }
	 }
}

\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{findPeaks}}, 
\code{\linkS4class{detectionList}}
}
\examples{
showClass("templateScores")



}
\keyword{classes}
