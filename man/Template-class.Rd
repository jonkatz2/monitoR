\name{Template-class}
\Rdversion{1.1}
\docType{class}
\alias{Template-class}
\alias{corTemplate-class}
\alias{binTemplate-class}

\title{Class \code{"Template"}}
\description{
  A template is an object with acoustic information (frequency, time, and amplitude) on an animal volcalization.
  Objects of class \code{"corTemplate"} are correlation templates, which contain quantitative data on amplitude.
  Objects of class \code{"binTemplate"} are binary templates, which contain only qualitative data on amplitude: only whether the it is high (``on'' cells) or low (``off'') cells.
  The class \code{"Template"} is a virtual class, and both types of templates have this class.
  Templates are always stored as part of a \code{\linkS4class{TemplateList}}, either a \code{\linkS4class{corTemplateList}} or a \code{\linkS4class{binTemplateList}}.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("corTemplate", ...)} or \code{new("binTemplate", ...)}.
However, users should not work directly with objects of this class, but only with \code{corTemplateList} or \code{binTemplateList}, which can be created as described in the documentation for \code{TemplateList}.
}
\section{Slots}{
  \describe{
    \item{\code{clip.path}:}{Object of class \code{character}.  The file path of the original recording used to create the template.}
    \item{\code{samp.rate}:}{Object of class \code{integer}.  The sample rate of the recording.}
    \item{\code{pt.on}:}{Object of class \code{matrix} (\code{binTemplate} class only). A two-dimensional matrix with time (column 1) and frequency (column 2) bins for ``on'' points. Bin locations are relative to the first bin (``on'' or ``off''), which has a value of 1.}
    \item{\code{pt.off}:}{Object of class \code{matrix} (\code{binTemplate} class only). A two-dimensional matrix with time (column 1) and frequency (column 2) bins for ``off'' points. Bin locations are relative to the first bin (``on'' or ``off''), which has a value of 1.}
    \item{\code{pts}:}{Object of class \code{"matrix"} (\code{corTemplate} class only). A two-dimensional matrix with time (column 1) and frequency (column 2) bins, and amplitude (column 3).}
    \item{\code{t.step}:}{Object of class \code{numeric}.  Time step between time bins (sec).}
    \item{\code{frq.step}:}{Object of class \code{numeric}.  Frequency step between frequency bins (kHz).}
    \item{\code{n.t.bins}:}{Object of class \code{integer}.  Total number of time bins in the template.}
    \item{\code{first.t.bin}:}{Object of class \code{numeric}.  Time of the first time bin in the original recording (sec).}
    \item{\code{n.frq.bins}:}{Object of class \code{integer}.  Total number of frequency bins.}
    \item{\code{duration}:}{Object of class \code{numeric}.  Template duration (sec).}
    \item{\code{frq.lim}:}{Object of class \code{numeric}.  Frequency limits (kHz).}
    \item{\code{wl}:}{Object of class \code{integer}.  Value of argument \code{wl} used in the \code{\link{spectro}} function call when the template was created.}
    \item{\code{ovlp}:}{Object of class \code{integer}.   Value of argument \code{ovlp} used in the \code{\link{spectro}} function call when the template was created.}
    \item{\code{wn}:}{Object of class \code{character}.  Value of argument \code{wn} used in the \code{\link{spectro}} function call when the template was created.}
    \item{\code{score.cutoff}:}{Object of class \code{numeric}.  The cutoff that will be used to identify detections when this template is used.}
  }
}
\section{Extends}{
Classes \code{corTemplate} and \code{binTemplate} extend \code{Template}, directly.
}
\section{Methods}{
  No methods defined with these classes in the signature.
  But see \code{\linkS4class{TemplateList}}.
}
\author{
  Sasha D. Hafner
}
\seealso{
  \code{\linkS4class{binTemplateList}}, 
  \code{\linkS4class{corTemplateList}}, 
  \code{\linkS4class{TemplateList}}
}
\examples{
showClass("Template")

showClass("corTemplate")

showClass("binTemplate")
}
\keyword{classes}
