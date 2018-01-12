\name{bindEvents}
\alias{bindEvents}

\title{
Summarize/Archive Manually Derived Sound Events
}
\description{
Read in a table of song event times and the corresponding \code{\link[tuneR]{Wave}} object, extract the song events, and bind them into a single \code{Wave} object for archiving or comparison viewing.
}
\usage{
bindEvents(rec, file, by.species = TRUE, parallel = FALSE, return.times = FALSE)

}

\arguments{
  \item{rec}{File path to mp3 or wav file or object of class \code{\link[tuneR]{Wave}}}
  \item{file}{File path to csv file containing event times.  See details.}
  \item{by.species}{Logical.  Should each species be in its own \code{Wave} object?}
  \item{parallel}{Logical.  \code{FALSE} will use \code{\link[base]{lapply}}, \code{TRUE} will use \code{\link[parallel]{mclapply}}.}
  \item{return.times}{Logical.  \code{FALSE} returns only the \code{Wave} object with events.  \code{TRUE} will also return a data frame with the start and end times of each event in the new \code{Wave} object linked to their original start and end times.}
}
\details{
The csv file supplied must use a standard set of column names, which can occur in any order:

\itemize{
  \item{\code{name}}{ Species name}
  \item{\code{start.time}}{ Event start time, in seconds}
  \item{\code{end.time}}{ Event end time, in seconds}    
}

These column names are those supplied in an annotation file produced by \code{\link{viewSpec}}.
}
\value{
If \code{return.times = FALSE}, an object of class \code{\link[tuneR]{Wave}}. \cr
If \code{return.times = TRUE}, a list:
  \item{times}{A data frame with the start and end times of events in the \code{Wave} object}
  \item{wave}{An object of class \code{Wave}}
}

\author{
Sasha D. Hafner
}

\seealso{ 
  \code{\link{viewSpec}}, 
  \code{\link{collapseClips}}, 
  \code{\link[tuneR]{bind}}.  
}

\examples{ 

data(survey_anno) 
data(survey)

# Don't return times
events <- bindEvents( rec = survey, file = survey_anno, by.species = TRUE, parallel = FALSE,
                     return.times = FALSE)

# Return times       
events <- bindEvents( rec = survey, file = survey_anno, by.species = TRUE, parallel = FALSE,
                     return.times = TRUE)
        
}
\keyword{manip}
