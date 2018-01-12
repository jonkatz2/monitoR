\name{detectionList-class}
\Rdversion{1.1}
\docType{class}
\alias{detectionList-class}

\title{Class \code{"detectionList"}}
\description{
These objects contain information on template detections, as well as (almost) all the information contained in \code{\linkS4class{templateScores}} 
These objects represent the final result of the template detection process.
Various functions exist for working with these objects.
Information on the detections alone can be extracted with \code{\link{getDetections}}.
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("detectionList", ...)}.
However, these objects should always be created by applying the \code{\link{findPeaks}} to \code{\linkS4class{templateScores}} objects.
There are other functions the exist for modifying existing \code{detectionList} objects, including \code{\link{showPeaks}}, and the combination of \code{\link{templateCutoff}} and \code{\link{findDetections}}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{survey.name}:}{Object of class \code{"character"}. The name of the survey file, or \code{"A Wave object"} if the survey was not read in from a file.}

    \item{\code{survey}:}{Object of class \code{\link[tuneR]{Wave}}. The survey data, as a \code{"Wave"} object.} 

    \item{\code{survey.data}:}{Object of class \code{list}. A named list, with one element for each template. Each element contains data from a Fourier transform of the original survey: \code{amp} is a matrix of amplitudes (frequency by time, r by column), \code{t.bins} is a numeric vector with the values of the time bins (left-aligned--first bin is always 0.0), and \code{frq.bins} is a numeric vector with the values of the frequency bins (top-aligned--last bin is always the upper limit). There is a separate element for each template because each template may use different parameters for the Fourier transform (see \code{\linkS4class{Template}}).}

    \item{\code{templates}:}{Object of class \code{list}. A named list of templates, which is identical to the original \code{\linkS4class{TemplateList}} used for template matching. This template list can be extracted with \code{\link{getTemplates}}.}

    \item{\code{scores}:}{Object of class \code{list}. A named list, with one element for each template. Each element is a data frame with three columns: \code{date.time} is the absolute time of the score, \code{time} is the relative time of the score (relative to the survey start), and \code{score} is the score. Times are based on the center of the template, and so \code{time} will not correspond to values in \code{t.bins} in the \code{survey.data} above if the template spans an even number of time bins.}

    \item{\code{peaks}:}{Object of class \code{list}. A named list, with one element for each template. Each element is a data frame that contains information on peaks that were found. The first three columns are identical to those in the \code{scores} data frames (above) (but of course only contain those values that were identified as peaks). The fourth column is logical and indicates whether the peak was also a detection.}

    \item{\code{detections}:}{Object of class \code{list}. A named list, with one element for each template. Each element is a data frame that contains information on detections. The columns are identical to those in the \code{scores} data frames (above) (but of course only contain those values that were identified as detections (i.e., peaks with a score above the \code{score.cutoff}).}
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "detectionList")}: ... }
    \item{summary}{\code{signature(object = "detectionList")}: ... }
  }
}
\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{findPeaks}}, 
\code{\link{getDetections}}, 
\code{\link{templateCutoff}}, 
\code{\linkS4class{templateScores}}
}
\examples{
showClass("detectionList")



}
\keyword{classes}
