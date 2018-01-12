\name{btnw}
\alias{btnw}
\docType{data}
\title{
Black-Throated Green Warbler (\emph{Setophaga virens}) Song
}

\description{
A 3 second wave recording of a Black-throated Green Warbler (\emph{Setophaga virens}) song.
}

\usage{
data(btnw)
}

\format{
The format is: \cr
\code{Formal class 'Wave' [package "tuneR"] with 6 slots
  ..@ left     : int [1:72001] -53 -65 -32 44 -15 -37 -5 26 26 55 ...
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
data(btnw)

viewSpec(btnw)
}

\keyword{datasets}
