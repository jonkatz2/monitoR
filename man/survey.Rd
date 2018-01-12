\name{survey}
\alias{survey}
\docType{data}
\title{
Sample Acoustic Survey (Short)
}

\description{
A composite wave file 23.5 seconds long containing 3 black-throated green warbler (\emph{Setophaga virens}) songs (at 1.8, 10.5, and 21.6 seconds) and 4 ovenbird (\emph{Seiurus aurocapilla}) songs (at 5.8, 9.1, 14.8, and 22.0 seconds).  The ovenbird song at 14.8 seconds is considerably lower amplitude than the others.
}

\usage{data(survey)}

\format{
The format is: \cr
\code{Formal class 'Wave' [package "tuneR"] with 6 slots
  ..@ left     : int [1:564000] 135 192 230 163 158 230 289 277 249 280 ...
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
data(survey)
viewSpec(survey)
}

\keyword{datasets}
