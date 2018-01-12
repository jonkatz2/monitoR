\name{changeSampRate}
\alias{changeSampRate}

\title{
Resample Wave objects
}
\description{
Downsample or upsample \code{\link[tuneR]{Wave}} objects by specifying either a new sample rate or matching the sample rate of a different \code{\link[tuneR]{Wave}} object.  Optional adjustable dithering. 
}
\usage{
changeSampRate(wchange, wkeep = NULL, sr.new = wkeep@samp.rate, dither = FALSE, 
               dith.noise = 32)

}
\arguments{
  \item{wchange}{Object of class \code{Wave} to resample.}
  \item{wkeep}{Object of class \code{Wave} to use to match sampling rate, or specify sampling rate with \code{sr.new}.}
  \item{sr.new}{Numerical sampling rate, if specified directly.}
  \item{dither}{Logical.  \code{TRUE} adds gaussian dithering.}
  \item{dith.noise}{Adjustable dithering.  If \code{dither = TRUE}, this value will be the \code{stdev} of the normally distributed noise.}
}
\details{
Both downsampling and upsampling are done by spline-fitting a curve to the waveform and resampling the resulting waveform.  Artifacts from resampling are nearly guaranteed.  Artifacts can be masked with dithering at a cost: dithering raises the amplitude of background noise but not signal.
}
\value{
An object of class \code{Wave} with a modified sample rate.
}

\author{
Sasha D. Hafner, 
Jon Katz
}

\seealso{
\code{\link[tuneR]{downsample}}
}
\examples{
data(survey)

survey <- changeSampRate(wchange = survey, sr.new = 24000)
}
\keyword{manip}
