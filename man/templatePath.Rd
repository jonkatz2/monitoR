\name{templatePath}
\alias{templatePath}
\alias{templatePath<-}

\title{
  Song clip path of Templates
}

\description{
  Functions to check or change the song clip path of templates within an acoustic template list.
}

\usage{
  templatePath(object)
  templatePath(object) <- value
}

\arguments{
  \item{object}{An acoustic template list, i.e., a \code{\linkS4class{corTemplateList}} or \code{\linkS4class{binTemplateList}} object.}
  \item{value}{A character vector of paths. May be named.}
}

\details{
This function works in the same way as the function \code{\link[base]{names}}.
No check is performed to ensure that the specified path is valid.
}

\value{
For \code{filePath}, \code{NULL} or a character vector of the same length as \code{object}. For \code{filePath <- }, the updated template list, i.e., the original template list with only the clip.path values changed.
}

\author{
Sasha D. Hafner
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}, 
\code{\link{templateComment}}, 
\code{\link{templateCutoff}}, 
\code{\link{templateNames}}, 
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

# To check paths
templatePath(ctemps)

# Change the first two
templatePath(ctemps)[1:2] <- c("~/templates/btnw.wav", "~/templates/btnw.wav")

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{attribute}
