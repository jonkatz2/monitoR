\name{fileCopyRename}
\alias{fileCopyRename}
\title{
Copy and Rename Sound Files from Portable Media
}
\description{
Collects a variety of metadata about recordings that will be acoustic surveys and encodes the date modified into the file name.  Copies files between directories to move them for an SD card to a hard disk, for example.
}
\usage{
fileCopyRename(files, from = ".", to, csv.dir = to, csv.name, loc.prefix, ext, 
rec.tz = NA, hours.offset = 0, CardRecorderID = NA, kaleidoscope = TRUE, 
split.channels = FALSE, metadata.only = FALSE, full.survey.names = FALSE, 
rename = TRUE, copy = TRUE)
}

\arguments{
  \item{files}{Optional vector of mp3, WAC, or WAV files to extract surveys from.}

  \item{from}{Directory containing mp3, WAC, or WAV recordings to extract survey from; required only if \code{files} is missing.}

  \item{to}{Directory where surveys will be placed after extraction.}

  \item{csv.dir}{Directory where csv file of survey metadata will be saved; defaults to the \code{to} directory.}

  \item{csv.name}{Name to save csv file of metadata, character value ending in .csv}

  \item{loc.prefix}{Character value identifying the location at which the recording was made.  Will be used in the file name (see Details) and the csv file name.  Must be in tblLocation.fldLocationName in the acoustics database.}

  \item{ext}{three-characters.  The file extension defining the type of files to move, rename, and collect metadata on.  Typically in \code{c("wav", "wac")}}

  \item{rec.tz}{Time zone for which the recordings were made (optional). Needed if different from the time zone setting of the operating system, when times will be adjusted to the \sQuote{correct} time zone. See details.}

  \item{hours.offset}{Hours to offset the modification time. Minimally useful when the recorder clock was set incorrectly. Use not at all, or if you must, with caution.}

  \item{CardRecorderID}{Numeric key value from tblCardRecorder.pkCardRecorderID, which links the recorder that made the recording with the location it was recorded.}

  \item{kaleidoscope}{Logical. If \code{ext = "wac"} files must be converted to .wav in Kaleidoscope.  Setting to \code{TRUE} anticipates the renaming by Kaleidoscope.}

  \item{split.channels}{Logical. If \code{ext = "wac"} files must be converted to .wav in Kaleidoscope.  Setting to \code{TRUE} anticipates further renaming by Kaleidoscope.}

  \item{metadata.only}{Logical.  If \code{ext = "wac"} files must be converted to .wav before metadata can be collected; this argument typically is used in the second pass to collect the metadata.}

  \item{full.survey.names}{Logical.  \code{TRUE} will use the full file path for the survey name in the resulting metadata table.  In those cases the full path name will be stored in the database as well.  Useful for coping with nested or disparate survey directories.}

  \item{rename}{Logical.  \code{FALSE} will disable renaming.}

  \item{copy}{Logical.  \code{FALSE} will disable file copying.}
}
\details{
The file name is where two important pieces of metadata are encoded: the location (as the location prefix) and the date and time of recording (as the date modified of the original file). The detection functions \code{\link{corMatch}} \code{\link{binMatch}} are capable of using this data as a time reference. Time zone management is tricky; if recordings were made in a different time zone than the OS running \code{fileCopyRename}, specify the correct time zone for the recordings with the \code{rec.tz} argument. Unexpected results are possible, as time zone abbreviations in general use may not match those in the Internet Assigned Numbers Authority tz database. The most reliable way to specify time zone is to use the full name, most quickly seen using \code{\link[base]{OlsonNames}}, and also found on wikipedia: \url{https://en.wikipedia.org/wiki/List_of_tz_database_time_zones}.
Metadata cannot be read for non-wave recordings, so typically a first function call is used to encode the location prefix and date modified into the file name and move it from the portable media, and a second function call with \code{metadata.ony = TRUE} is used after conversion to wave format to fill in the missing metadata.  
The \code{full.survey.names} argument is designed to permit the batch processing of sound files saved in different directories.
}
\value{
A data frame of metadata about the surveys.  Contains column names "fldOriginalDateModified", "fldOriginalRecordingName", "fldSurveyName", "fldRecordingFormat", "fkCardRecorderID", "fldSurveyLength", "fldSampleRate", "fldBitsperSample", and "fldChannels".  Column names reflect the assumption that this data will become a catalog of surveys stored in the database.
}
\references{
Time zone conversion assisted by a post on David Smith's Revolutions blog, June 02, 2009: https://blog.revolutionanalytics.com/2009/06/converting-time-zones.html
}

\author{
Jon Katz
}

\seealso{
\code{\link{mp3Subsamp}}
}
\examples{
\dontrun{
# Not run because it will create a file in user's working directory
data(survey)

writeWave(survey, "survey.wav")

meta <- fileCopyRename(
            files = "survey.wav", 
            to = getwd(), 
            csv.name = "sampleMeta.csv", 
            loc.prefix = "MABI06", 
            ext = "wav", 
            CardRecorderID = 1)
            
# If your recorder's clock is set to GMT but your OS is not:            
altmeta <- fileCopyRename(
               files = "survey.wav", 
               to = getwd(), 
               csv.name = "sampleMeta.csv", 
               loc.prefix = "MABI06", 
               ext = "wav", 
               rec.tz = "GMT", 
               CardRecorderID = 1)
            
file.remove("survey.wave")}
}

\keyword{IO}
\keyword{file}
