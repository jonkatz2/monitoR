\name{specCols}
\alias{gray.1}
\alias{gray.2}
\alias{gray.3}
\alias{rainbow.1}
\alias{topo.1}
\alias{specCols}

\title{
Color Vectors for Spectrograms
}
\description{
Functions to generate a selection of color vectors for spectrograms based on existing color vectors for images in \pkg{grDevices}.  Vectors are reversed relative to their parent (i.e. numerical sequences progress from 1 to 0 rather than 0 to 1). 
}
\usage{
gray.1(n = 30)
gray.2(n = 30)
gray.3(n = 30)
rainbow.1(n = 15)
topo.1(n = 12)
}

\arguments{
  \item{n}{A vector of desired color levels between 1 and 0; one indicates high amplitude ("black", "red", or "blue") and zero indicates low amplitude ("white", "purple", or "tan").}
  }
\details{
The \code{n} argument will divide the vector into \code{n} color levels.
}
\value{
A vector of colors.
}
\references{
Based on the color palettes from \pkg{grDevices}, and loosely on those used in \pkg{seewave}
}
\author{
Jon Katz, Sasha D. Hafner
}

\seealso{
\code{\link[grDevices]{gray}}, \code{\link[grDevices]{rainbow}}, \code{\link[grDevices]{topo.colors}}, \code{\link[grDevices]{terrain.colors}}
}
\examples{
spec.test <- function(mat, spec.col) image(z = t(mat), col = spec.col)

mat <- matrix(1:30, ncol = 6, byrow = TRUE)

spec.test(mat = mat, spec.col = gray.1())
spec.test(mat = mat, spec.col = gray.2())
spec.test(mat = mat, spec.col = gray.3())
spec.test(mat = mat, spec.col = rainbow.1())
spec.test(mat = mat, spec.col = topo.1())

\dontrun{
# Colors are defined as:
gray.1 <- function(n = 30) gray(seq(1, 0, length.out = n))
gray.2 <- function(n = 30) gray(1-seq(0, 1, length.out = n)^2)
gray.3 <- function(n = 30) gray(1-seq(0, 1, length.out = n)^3)
rainbow.1 <- function(n = 15) rev(rainbow(n))
topo.1 <- function(n = 12) rev(topo.colors(n))}
}

\keyword{color}

