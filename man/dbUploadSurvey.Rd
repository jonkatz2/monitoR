\name{dbUploadSurvey}
\alias{dbUploadSurvey}
\title{Upload Survey Metadata to an Acoustics Database}

\description{
Upload survey metadata to tblSurvey in an acoustics database.
}

\usage{
dbUploadSurvey(db.name = "acoustics", uid, pwd, survey.meta, update.query = FALSE, 
               tz, ...)
}

\arguments{
  \item{survey.meta}{Object containing survey metadata, typically gathered in one or more invocations of \code{\link{fileCopyRename}}.}
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{update.query}{Logical value to control the type of query.  See Details.}
  \item{tz}{Time zone, if not in file names or metadata.  See Details.}
  \item{\dots}{Additional arguments to \code{RODBC::odbcConnect}.}
}

\details{
\code{dbUploadSurvey} assumes a database structure identical to that provided in the acoustics schema.  If the username and password are present in the ODBC datasource they do not need to be provided.  It is possible to store only the username in the datasource and enter a password, but the reverse will not work.

Surveys recorded as wav files have metadata read from the header of the file automatically; these data can be uploaded to the database in a single call to \code{dbUploadSurvey}.  Metadata for surveys recorded in proprietary compressed file formats cannot be gathered in the same manner; some basic metadata is gleaned from the initial transfer of the surveys from memory-card to storage drive, and the rest is read after the conversion from proprietary format to wav file. If recording in a proprietary format, normal operation would thus call for two invocations of \code{dbUploadSurvey}: the first with partial metadata, and the second as an update query to fill in the missing values.  Therefore, standard use (\code{update.query = FALSE}) passes a simple INSERT INTO query to the database and parses the fields appropriately.  When \code{update.query = TRUE}, the assumption is made that many of the fields in survey.meta have already been entered into the database, but some remain \code{NULL}.

If no 'fldOriginalDateModified' exists in the metadata it will be automatically generated from the date coded in the file name during \code{fileCopyRename}.
}

\value{
Invoked for its side effect, which is to insert the detection results into tblResult in an acoustics database.  Successful upload is marked by a report of the upload time; unsuccessful upload will report any errors encountered.
}

\author{
Jon Katz
}

\note{
This is a convenience function for users who are unfamiliar with SQL syntax and/or have not established an alternative front-end for their acoustics database.  Users capable of doing so may find more utility and flexibility writing custom queries directly either with an alternative front-end or \code{RODBC::sqlQuery}.  No processing is performed; data is uploaded to the database as it exists in the metadata object.
}

\seealso{
\code{\link{fileCopyRename}}, \code{\link{mp3Subsamp}}
}

\examples{
\dontrun{
# metadata for wav files:
metadata <- fileCopyRename(
        from = '~/media/SDcard', 
        to = '~/Desktop/Acoustics/Recordings', 
        csv.dir = '~/Desktop/Acoustics/Results', 
        loc.prefix = 'MABI01', 
        ext = 'wav', 
        CardRecorderID = 1, 
        kaleidoscope = FALSE)
        
# If using the 'acoustics' schema verbatim:
dbUploadSurvey(survey.meta = metadata)

# 'acoustics' schema, different database name:
dbUploadSurvey(
    survey.meta = metadata, 
    db.name = "LocalSQLdb", 
    uid = "EntryOnly", 
    pwd = "07H23BBM")

# metadata for wac files:
metadata <- fileCopyRename(
        from = '~/media/SDcard', 
        to = '~/Desktop/Acoustics/Recordings', 
        csv.dir = '~/Desktop/Acoustics/Results', 
        loc.prefix = 'MABI01', 
        ext = 'wac', 
        CardRecorderID = 1)
        
# If using the 'acoustics' schema verbatim:
dbUploadSurvey(survey.meta = metadata)

# 'acoustics' schema, different database name:
dbUploadSurvey(
    survey.meta = metadata, 
    db.name = "LocalSQLdb", 
    uid = "EntryOnly", 
    pwd = "07H23BBM")

# After converting wac files to wav files use update.query = TRUE:
new.metadata <- fileCopyRename(
        from = '~/Desktop/Acoustics/Recordings', 
        to = '~/Desktop/Acoustics/Surveys', 
        csv.dir = '~/Desktop/Acoustics/Results', 
        loc.prefix = 'MABI01', 
        ext = 'wav', 
        CardRecorderID = 1, 
        metadata.only = TRUE)
        
# If using the 'acoustics' schema verbatim:
dbUploadSurvey(survey.meta = new.metadata, update.query = TRUE)

# 'acoustics' schema, different database name:
dbUploadSurvey(
    survey.meta = new.metadata, 
    db.name = "LocalSQLdb", 
    uid = "EntryOnly", 
    pwd = "07H23BBM", 
    update.query = TRUE)}
}

\keyword{database}
\keyword{utilities}
