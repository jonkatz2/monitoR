\name{internals}
\alias{dBweight}
\alias{ftwindow}
\alias{hamming.w}
\alias{hanning.w}
\alias{blacktop.w}
\alias{flattop.w}
\alias{rectangle.w}
\alias{rbindf}
\alias{spectro}
\alias{stft}
\alias{findDetections}
\alias{getClip}
\alias{getOneClip}
\alias{readClip}
\alias{readOneBinTemplate}
\alias{readOneCorTemplate}
\alias{writeOneBinTemplate}
\alias{writeOneCorTemplate}
\alias{mp3Subsamp.one}

\title{
\code{monitoR} Internal Functions
}
\description{
These functions are used by other functions in the monitoR package, but are not intended to be called by users.
The functions are:
\code{dBweight}, 
\code{ftwindow}, 
\code{hamming.w}, 
\code{hanning.w}, 
\code{blackman.w}, 
\code{flattop.w}, 
\code{rectangle.w}, 
\code{rbindf}, 
\code{spectro}, 
\code{stft}, 
\code{findDetections}, 
\code{getClip}, 
\code{getOneClip}, 
\code{readClip}, 
\code{readOneBinTemplate}, 
\code{readOneCorTemplate}, 
\code{writeOneBinTemplate}, 
\code{writeOneCorTemplate}, 
and \code{mp3Subsamp.one}
}

\details{
The first six functions listed above are functions of the same name in the excellent \pkg{seewave} package, written by Jerome Sueur, Thierry Aubin, and Caroline Simonis.
Except for \code{spectro}, these functions were copied directly from \pkg{seewave}.
Our version of \code{spectro} is used only for the Fourier transform here, and so excludes the plotting options of the \code{seewave} version, and also includes a few small changes in identifying values for time and frequency bins.
The remaining five functions taken from \pkg{seewave} are called only by the \code{spectro} function.
The author list given below includes the \pkg{seewave} authors to acknowledge our use of their code.
The remaining seven functions listed above are used to read audio files or read and write templates to file.
To carry out these tasks, users should use the functions listed below in the \dQuote{See Also} section.
}

\author{
Sasha D. Hafner, 
Jon Katz, 
Jerome Sueur, 
Thierry Aubin, 
Caroline Simonis
}

\seealso{
\code{\link[tuneR]{writeWave}}, 
\code{\link[tuneR]{readWave}}, 
\code{\link{writeBinTemplates}}, 
\code{\link{writeCorTemplates}}, 
\code{\link{readBinTemplates}}, 
\code{\link{readCorTemplates}}, 
\code{\link[seewave]{spectro}}
}

\keyword{internal}

