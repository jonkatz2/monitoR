\name{mp3Subsamp}
\alias{mp3Subsamp}
\title{
Extract Short Surveys from Longer mp3 Recordings
}
\description{
Extract short surveys from longer mp3 recordings without decoding and re-encoding.  Collects metadata about surveys for upload to an acoustic database and renames files with original date modified.  Timing options are one or more surveys per hour starting at the beginning time of the recording or one survey per hour starting on each hour.
}
\usage{
mp3Subsamp(files, from = ".", to, csv.dir = to, csv.name, duration = 600, 
           mins.between = 50, index = "hour", loc.prefix, CardRecorderID = NA,
           kbps = 128, samp.rate = 44100, channels = 2, split = TRUE)
}

\arguments{
  \item{files}{Optional vector of mp3 file paths to extract surveys from.}
  \item{from}{Directory containing mp3 recordings to extract survey from; required only if \code{files} is missing.}
  \item{to}{Directory where surveys will be placed after extraction.}
  \item{csv.dir}{Directory where csv file of survey metadata will be saved; defaults to the \code{to} directory.}
  \item{csv.name}{Name assigned to csv file of metadata (character value ending in .csv).}
  \item{duration}{Duration of surveys to extract (numeric, units = 'seconds'). Defaults to 600 seconds (10 minutes).}
  \item{mins.between}{Number of minutes to skip between surveys (numeric). If \code{index = "hour"}, the value for \code{mins.between + duration * 60} (duration converted to minutes) equals the repeat period.  Defaults to 50 minutes, for a 60 minute repeat period.}
  \item{index}{Character value indicating whether to take the first survey at the next hour in the recording (identified based on file date modified) or simply from the start of the recording.  In \code{c("hour", "time0")}.  Defaults to \code{"hour"}.}
  \item{loc.prefix}{Six characters identifying the location at which the recording was made.  Will be used in the file name (see Details) and the csv file name.  Must be in \emph{tblLocation.fldLocationName} in the acoustics database.}
  \item{CardRecorderID}{Numeric key value from \emph{tblCardRecorder.pkCardRecorderID}, which links the recorder that made the recording with the location it was recorded.}
  \item{kbps}{Numeric value for mp3 bitrate.  Common values are \code{c(64, 128, 160, 192, 224, 256, 320)}.  Must match the bitrate set by the recording device.}
  \item{samp.rate}{Numeric value for mp3 sample rate.  Common values are \code{c(22050, 44100, 48000)}.  Must match the sample rate set by the recording device.}
  \item{channels}{Numeric value for number of audio channels in mp3 file.  Both "Stereo" and "Joint Stereo" are 2-channel recordings.  "Mono" is a 1-channel recording.}
  \item{split}{Logical.  The default \code{TRUE} will send the call to mp3splt to subsample the surveys; \code{FALSE} will generate metadata only.}
}

\details{
This function calls mp3splt, a third party library that must be installed separately from \url{http://mp3splt.sourceforge.net}.  Supplemental installation instructions are provided in the document "Installing_mp3splt.pdf", available the monitoR website \url{http://www.uvm.edu/rsenr/vtcfwru/R/?Page=monitoR/monitoR.htm}.  This function supplants \code{\link{fileCopyRename}} as a file copying function and a metadata collection tool when using the acoustic database.  

The survey file names produced will be of the form PREFIX_YYYY-mm-dd_HHMSS.mp3.  Surveys from the same location can be linked by the location prefix and differentiated by different modification dates.
}

\value{
Data frame with metadata about the surveys.  Metadata includes: the date modified (fldOriginalDateModified), the original recording name (fldOriginalRecordingName), the new survey name (fldSurveyName), the recording format (fldRecordingFormat), the value for pkCardrecorderID (fkCardRecorderID), the duration of each survey (fldSurveyLength), the sample rate (fldSampleRate), the bit depth (fldBitsperSample), and the number of channels (fldChannels).
}

\author{
Jon Katz
}

\note{
\code{\link{dbUploadSurvey}} assumes a database structure identical to that provided in the acoustics schema.
}

\seealso{
See \code{\link{fileCopyRename}} to move wave files and prepare metadata for the database; \code{\link{dbUploadSurvey}} to upload the survey metadata to the acoustics database.
}

\examples{
# Specify individual files, 10 minutes every hour from the file start:
\dontrun{metadata <- mp3Subsamp(files = '~/media/SDcard/MA01.mp3', to = '~/Desktop/Acoustics/Recordings', 
csv.dir = '~/Desktop/Acoustics/Results', index = "time0", loc.prefix = 'MABI01', CardRecorderID = 1}

# 10 minute surveys at the top of every hour, from an entire SD card:
\dontrun{metadata <- mp3Subsamp(from = '~/media/SDcard', to = '~/Desktop/Acoustics/Recordings', 
csv.dir = '~/Desktop/Acoustics/Results', loc.prefix = 'MABI01', CardRecorderID = 1}

# 5 minute surveys every 30 minutes starting at the top of every hour, from an entire SD card:
\dontrun{metadata <- mp3Subsamp(from = '~/media/SDcard', to = '~/Desktop/Acoustics/Recordings', 
csv.dir = '~/Desktop/Acoustics/Results', duration = 300, mins.between = 25, loc.prefix = 'MABI01', 
CardRecorderID = 1}





}

\keyword{IO}
\keyword{file}
