\name{dbDownload}
\alias{dbDownloadCardRecorderID}
\alias{dbDownloadSurvey}
\title{Retrieve Card-Recorder ID Values or Survey Names from a Database}

\description{Convenience functions to execute a prewritten SQL query.  Wrappers for \code{RODBC::sqlQuery} with no additional processing.}

\usage{
dbDownloadCardRecorderID(db.name = "acoustics", uid, pwd, 
                         date.deployed, date.collected, 
			 loc.prefix, ...)

dbDownloadSurvey(db.name = "acoustics", uid, pwd, start.date, 
                 end.date, loc.prefix, samp.rate, ext, ...)
}

\arguments{
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{date.deployed, date.collected, start.date, end.date}{Dates to filter results, as a character string formatted to your database storage; in the example we use \code{YYYY/MM/DD}, but be aware that you may need to include a full timestamp: \code{YYYY/MM/DD 00:00:00}.}
  \item{loc.prefix}{Location prefix or vector of six-character prefixes by which to filter results.}
  \item{samp.rate}{Numerical sampling rate of surveys (Hz).}
  \item{ext}{Character file extension "wav" or "mp3".}
  \item{\dots}{Additional arguments to \code{RODBC::odbcConnect}.}
}

\details{
These functions assume a database structure identical to that provided in the acoustics schema.  \code{dbDownloadCardRecorderID} may be used to look up CardRecorderID values before uploading survey metadata; \code{dbDownloadSurvey} may be used to generate a table of survey names to work through for batch detection with either \code{\link{corMatch}} or \code{\link{binMatch}}.
If the username and password are present in the ODBC datasource they do not need to be provided.  It is possible to store only the username in the datasource and enter a password, but the reverse will not work.
}

\value{
  \code{dbDownloadCardRecorderID} returns a data frame with fields pkCardRecorderID, fldLocationNameAbbreviation, fldSerialNumber, and pkCardID. \code{dbDownloadSurvey} returns a data frame with a single field: fldSurveyName.
}

\author{
Jon Katz
}

\note{
These are convenience functions for users who are unfamiliar with SQL syntax and/or have not established an alternative front-end for their acoustics database.  Users capable of doing so may find more utility and flexibility writing custom queries directly either with an alternative front-end or \code{RODBC::sqlQuery}.  No processing is performed; data from the database is returned as it exists in the database.
}

\seealso{
\code{\link[RODBC]{sqlQuery}}, \code{\link{dbDownloadTemplate}}, \code{\link{dbUploadSurvey}}
}

\examples{
\dontrun{
#If using the 'acoustics' schema verbatim:
CRs <- dbDownloadCardRecorderID(
        date.deployed = "2012/05/22", 
        date.collected = "2012/05/29", 
        loc.prefix = "MABI01")
        
surveys <- dbDownloadSurvey(
        start.date = "2012/05/22", 
        end.date = "2012/05/29", 
        loc.prefix = "MABI01", 
        samp.rate = 24000, 
        ext = "wav")
        
#'acoustics' schema, different database name:
CRs <- dbDownloadCardRecorderID(
        db.name = "LocalSQLdb", 
        uid = "EntryOnly", 
        pwd = "07H23BBM", 
        date.deployed = "2012/05/22", 
        date.collected = "2012/05/29", 
        loc.prefix = "MABI01")
        
surveys <- dbDownloadSurvey(
        db.name = "LocalSQLdb", 
        uid = "EntryOnly", 
        pwd = "07H23BBM", 
        start.date = "2012/05/22", 
        end.date = "2012/05/29", 
        loc.prefix = "MABI01", 
        samp.rate = 24000, 
        ext = "wav")
}
}

\keyword{database}
\keyword{utilities}
