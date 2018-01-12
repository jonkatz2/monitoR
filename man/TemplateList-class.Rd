\name{TemplateList-class}
\Rdversion{1.1}
\docType{class}
\alias{corTemplateList-class}
\alias{binTemplateList-class}
\alias{TemplateList-class}

\title{Class \code{"TemplateList"}}
\description{
  A template is an object with acoustic information (frequency, time, and volume) on an animal volcalization.
  In monitoR, all templates are stored within a template list, which has the (virtual) class \code{TemplateList}.
  Because the structure of the two types of templates differs slightly (see \code{\linkS4class{Template}}), there are actually two classes for template lists: \code{corTemplateList} and \code{binTemplateList}, and the virtual class \code{TemplateList} (which includes both types of template lists) is used to define most methods.
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("corTemplateList", ...)} or \code{new("binTemplateList", ...)}.
  However, objects should always be created with the template-creation functions \code{\link{makeCorTemplate}} or \code{\link{makeBinTemplate}}, or else by reading from a file using \code{\link{readCorTemplates}} or \code{\link{readBinTemplates}}.
  There are also functions for modifying existing template lists or extracting template lists from other objects.
}
\section{Slots}{
  \describe{
    \item{\code{templates}:}{Object of class \code{"list"} A list of either \code{\linkS4class{corTemplate}} or \code{\linkS4class{binTemplate}} objects.}
  }
}
\section{Extends}{
Classes \code{corTemplateList} and \code{binTemplateList} extend the virtual class \code{TemplateList}, directly.
}
\section{Methods}{
  \itemize{
    \item{show}{ \code{signature(object = "corTemplateList")}: ... }
    \item{summary}{ \code{signature(object = "corTemplateList")}: ... }
    \item{show}{ \code{signature(object = "binTemplateList")}: ... }
    \item{summary}{ \code{signature(object = "binTemplateList")}: ... }
    \item{plot}{ \code{signature(x = "TemplateList", y = "ANY")}: ... }
  }
}
\author{
  Sasha D. Hafner
}
\note{
  For details on the structure of the actual templates, see \code{\linkS4class{Template}}.
}

\seealso{
  \code{\linkS4class{Template}}, 
  \code{\link{combineBinTemplates}}, 
  \code{\link{templateCutoff}}, 
  \code{\link{templateComment}}, 
  \code{\link{getTemplates}}, 
  \code{\link{plot-methods}}, 
  \code{\link{[-methods}}
}
\examples{
showClass("TemplateList")

showClass("corTemplateList")

showClass("binTemplateList")

}
\keyword{classes}
