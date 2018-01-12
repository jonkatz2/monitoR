\name{extract-methods}
\docType{methods}
\alias{[-methods}
\alias{[,detectionList-method}
\alias{[,TemplateList-method}
\alias{[,templateScores-method}

\title{Indexing (Extraction) Methods for \pkg{monitoR} Package}
\description{
These methods can be used to index detection list (\code{\linkS4class{detectionList}}), template lists (\code{\linkS4class{TemplateList}}), and template scores (\code{\linkS4class{templateScores}}) objects.
Indexing is analogous to indexing a vector--with single square brackets, and character (template name) or integer (template position) values.
}
\section{Methods}{
\describe{

\item{\code{signature(x = "detectionList")}}{
Index by name or position of template(s).
}

\item{\code{signature(x = "TemplateList")}}{
Index by name or position of template(s).
}

\item{\code{signature(x = "templateScores")}}{
Index by name or position of template(s).
}
}}
\keyword{methods}
