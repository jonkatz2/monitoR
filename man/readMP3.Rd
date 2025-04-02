\name{readMP3}
\alias{readMP3}

\title{
Read MP3 Files into a Wave Object
}
\description{
A variation of the MP3 file reader supplied in \code{\link[tuneR]{tuneR}}.  Reads MP3 files in as 16bit PCM data stored in a Wave object.
}
\usage{
readMP3(filename, from, to)
}

\arguments{
  \item{filename}{Filename of MP3 file.}
  \item{from}{Seconds to begin reading, measured from beginning of file.  See details.}
  \item{to}{Seconds to end reading, measured from beginning of file.  See details.}
}
\details{
The bare bones MP3 file reader supplied in \code{\link[tuneR]{tuneR}} reads the entire file in.  When the user installs the third party software mp3splt and libmp3splt, this variant will allow \code{from} and \code{to} to be specified, and mp3splt will attempt to read in the MP3 segment without first decoding the file.  Because mp3splt will cut the MP3 file at frame boundaries the \code{from} and \code{to} arguments are necessarily only guiding values; actual values may differ.  Supplemental mp3splt installation instructions are provided in the document "Installing_mp3splt.pdf", available the monitoR website \url{https://www.uvm.edu/rsenr/vtcfwru/R/?Page=monitoR/monitoR.htm}.
}
\value{
An object of class \code{\link[tuneR]{Wave}}.
}
\references{
mp3splt is documented at http://mp3splt.sourceforge.net/mp3splt_page/home.php.
}
\author{
Jon Katz
}
\note{
If mp3splt is not installed a prompt will suggest falling back on the version from tuneR.
}

\seealso{
\code{\link[tuneR]{readMP3}}, \code{\link[tuneR]{readWave}}
}
\examples{
\dontrun{
# Assume myMP3 is an MP3 file with a duration of at least 60 seconds:
readMP3 (filename = "myMP3.mp3", from = "30", to = "60")} 
}

\keyword{IO}
\keyword{file}
