\name{templateComment}
\alias{templateComment}
\alias{templateComment<-}

\title{
Query or Set Template Cutoffs
}
\description{
Use this function to add or check comments to templates within template lists (\code{\linkS4class{corTemplateList}} or \code{\linkS4class{binTemplateList}} objects), scores (\code{\linkS4class{templateScores}} objects), or detection list (\code{\linkS4class{detectionList}} objects).
}
\usage{
templateComment(object)
templateComment(object) <- value

}

\arguments{
  \item{object}{A binary or correlation template list (class \code{binTemplateList} or \code{corTemplateList}).}
  \item{value}{A character vector with the new comment.}
}
\details{
\code{templateComment} is an accessor function and \code{templateComment <- } is a replacement function.\cr
For replacement, the \code{value} object should be as long as the number of templates in \code{object} (or the number selecting via indexing) unless it is a named vector (see Examples).
}
\value{
For extraction, a numeric vector of the same length as \code{object} with comments.  
For replacement, the updated object.
}
\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{templateNames}}, 
\code{\link{templateCutoff}}, 
\code{\link{getTemplates}}
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

# Create four correlation templates
wct1 <- makeCorTemplate(btnw.fp, name = "w1")
wct2 <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), name = "w2")
oct1 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), name = "o1")
oct2 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, name = "o2")

# Combine all of them
ctemps <- combineCorTemplates(wct1, wct2, oct1, oct2)
ctemps

# Add a comment for two templates
templateComment(ctemps) <- c(w1 = "This is the best template so far.", 
                           o1 = "Should we drop the lowest syllable?")

# Add a default comment also
templateComment(ctemps) <- c(w1 = "This is the best template so far.", 
                           o1 = "Should we drop the lowest syllable?", 
                           default = "These templates have not been tested.")
# View comments
templateComment(ctemps)

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
}

\keyword{manip}
\keyword{attribute}
