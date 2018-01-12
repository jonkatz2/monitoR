\name{oven}
\alias{oven}
\docType{data}
\title{
Ovenbird (\emph{Seiurus aurocapilla}) Song
}
\description{
A 3 second wave recording of an Ovenbird (\emph{Seiurus aurocapilla}) song.
}
\usage{data(oven)}

\format{
The format is: \cr
\code{Formal class 'Wave' [package "tuneR"] with 6 slots
  ..@ left     : int [1:120001] 84 170 281 142 129 55 120 181 126 178 ...
  ..@ right    : num(0)
  ..@ stereo   : logi FALSE
  ..@ samp.rate: int 24000
  ..@ bit      : int 16
  ..@ pcm      : logi TRUE
}
}

\source{
Sound clips were recorded in Vermont, USA in 2010.  Equipment was a Wildlife Acoustics SM1(TM) recorder recording in WAC0 format, converted to wave using the Wildlife Acoustics Wac2Wav (TM) converter.  Recording has a sample rate of 24kHz and is 16-bit mono.
}

\examples{
data(oven)
viewSpec(oven)
}
\keyword{datasets}
