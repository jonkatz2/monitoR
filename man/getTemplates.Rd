\name{getTemplates}
\alias{getTemplates}

\title{
  Extract a Template List
}

\description{
  Use this function to extract template lists from \code{\linkS4class{templateScores}} or \code{\linkS4class{detectionList}} objects.
}

\usage{
getTemplates(object, which.ones = names(object@templates))
}

\arguments{
  \item{object}{
    The \code{templateScores} or \code{detectionList} object that contains the templates that are to be extracted. 
  }

  \item{which.ones}{
    Which templates should be included?
    A character vector of templates names, or an integer vector.
    Default is all templates.
  }
}

\details{
  This function would typically be used to extract and save a complete set of templates from a \code{\linkS4class{detectionList}} object if \code{\link{templateCutoff}} has been used to modify the template list after scores were calculated. 
  \code{getTemplates} could also be used to extract a subset of templates present in a template list, but indexing with square brackets is an easier approach.
}

\value{
  A template list of class \code{corTemplateList} or \code{binTemplateList}.
}

\author{
  Sasha D. Hafner
}

\seealso{
  \code{\link{makeCorTemplate}}, 
  \code{\link{makeBinTemplate}}, 
  \code{\link{templateCutoff}}, 
  \code{\link{templateComment}}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}

