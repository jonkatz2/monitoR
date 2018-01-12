\name{show-methods}
\docType{methods}
\alias{show-methods}
\alias{show,binTemplateList-method}
\alias{show,corTemplateList-method}
\alias{show,detectionList-method}
\alias{show,templateScores-method}
\alias{summary-methods}
\alias{summary,binTemplateList-method}
\alias{summary,corTemplateList-method}
\alias{summary,TemplateList-method}
\alias{summary,detectionList-method}
\alias{summary,templateScores-method}

\title{Methods for the \code{show} and \code{summary} Functions}

\description{
These methods are used for viewing template lists and other objects.
For all types of objects documented here, \code{show} and \code{summary} will produce identical results.
}

\section{Methods}{
\describe{

\item{\code{signature(object = "binTemplateList")}}{
Displays a summary of \code{\linkS4class{binTemplateList}} objects.
}

\item{\code{signature(object = "corTemplateList")}}{
Displays a summary of \code{\linkS4class{corTemplateList}} objects.
}

\item{\code{signature(object = "TemplateList")}}{
Displays a summary of \code{\linkS4class{TemplateList}} objects.
}

\item{\code{signature(object = "detectionList")}}{
Displays a summary of \code{\linkS4class{detectionList}} objects.
}

\item{\code{signature(object = "templateScores")}}{
Displays a summary of \code{\linkS4class{templateScores}} objects.
}
}}

\author{
Sasha D. Hafner
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}
}

\examples{
# Load data
data(btnw)
data(oven)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")
oven.fp <- file.path(tempdir(), "oven.wav")
writeWave(btnw, btnw.fp)
writeWave(oven, oven.fp)

# Correlation example
# Create two correlation templates
wct <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), name = "w")
oct <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, name = "o")

# Combine them
ctemps <- combineCorTemplates(wct, oct)

# Then for a quick summary:
ctemps

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
}

\keyword{methods}
\keyword{print}
