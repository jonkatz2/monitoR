\name{batchDetection}
\alias{batchCorMatch}
\alias{batchBinMatch}


\title{
Batch Template Detection
}

\description{
These functions are used to carry out template dection for multiple template and survey files in a single call.
These functions make it easy to analyze multiple survey files in a single call. They call \code{\link{corMatch}} or \code{\link{binMatch}}, followed by \code{\link{findPeaks}} and \code{\link{getDetections}} to do the work.
}

\usage{
batchCorMatch(dir.template, dir.survey = ".", ext.template = "ct", ext.survey = "wav", 
    templates, parallel = FALSE, show.prog = FALSE, cor.method = "pearson", warn = TRUE, 
    time.source = "filename", fd.rat = 1, ...)

batchBinMatch(dir.template, dir.survey = ".", ext.template = "bt", ext.survey = "wav", 
    templates, parallel = FALSE, show.prog = FALSE, warn = TRUE, 
    time.source = "filename", fd.rat = 1, ...)

}

\arguments{

  \item{dir.template}{
    A file path to a directory that contains template files to be used.
    Only used if \code{template} is missing.
  }

  \item{dir.survey}{
    A file path to a directory that contains survey files to be analyzed.
  }

  \item{ext.template}{
    Extension of the template files.
  }

  \item{ext.survey}{
    Extension of the survey files.
  }

  \item{templates}{
    A template list--a \code{\linkS4class{corTemplateList}} object for \code{corMatch} or a \code{\linkS4class{binTemplateList}} object for \code{binMatch}.
    If \code{templates} is missing, all the template files in \code{dir.template} will be used instead.
  }

  \item{parallel}{
    If \code{TRUE}, \code{\link[parallel]{mclapply}} from the \pkg{parallel} package is used for calculation of scores across all time bins for each template.
    This option is not available for Windows operating systems.
  }

  \item{show.prog}{
    If \code{TRUE}, progress will be reported during the score calculations.
  }

  \item{cor.method}{
    For \code{corMatch}, the method used to calculate correlation coefficients (see \code{\link[stats]{cor}}).
  }

  \item{warn}{
    Set to \code{FALSE} to suppress warnings about step mismatches. 
  }

  \item{time.source}{
    The source of date and time information.
    \code{filename} will look in the name of the survey file (\code{survey} argument) for a date and time with format YYYY-MM-DD_HHMMSS_TimeZone.
    \code{fileinfo} will take the date and time from the file modification information.
  }

  \item{fd.rat}{
    A ratio of frame width (twice minimum peak separation) to template duration.
    Used by \code{\link{findPeaks}}.
  }

%  \item{frame}{
%    If you want the same frame width for templates with varying duration, specify a value directly.
%    \code{fd.rate} will be ignored if \code{frame} is not missing.
%    Used by \code{\link{findPeaks}}.
%    
%  }

  \item{\dots}{
    Additional arguments to the \code{\link{spectro}} function.
  }
}

\details{
These functions are simple but do not provide flexibility in how results are handled.
Manually writing a \code{for} loop is a more flexible solution.
}

\value{
  A data frame of detections, as returned by \code{\link{getDetections}}.
}

\author{
  Sasha D. Hafner
}
 
\seealso{
\code{\link{corMatch}}, 
\code{\link{binMatch}}, 
\code{\link{findPeaks}}, 
\code{\link{getDetections}}
}

\examples{
\dontrun{
# Assume multiple survey files are in the subdirectory "Surveys" and templates 
# are in subdirectory "Templates"
detects <- batchCorMatch("Templates", "Surveys")

# Or, to use an existing template list instead
detects <- batchCorMatch(templates = ctemps, dir.survey = "Surveys")
}

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{IO}
\keyword{iteration}
