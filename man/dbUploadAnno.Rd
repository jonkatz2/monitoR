\name{dbUploadAnno}
\alias{dbUploadAnno}
\title{Upload Spectrogram Annotations to an Acoustics Database}

\description{Spectrogram annotations from \code{viewSpec} can be uploaded to tblAnnotations in an acoustics database.  Annotations can be specified as either a file path to a csv document or as a data frame.  The name of the survey to associate with the annotations must be identical to tblSurvey.fldSurveyName to properly link the annotations to the survey.
}

\usage{
dbUploadAnno(annotations, survey, db.name = "acoustics", uid, 
             pwd, analyst = "", ...)
}

\arguments{
  \item{annotations}{Either a file path to a csv file or a data frame of annotations.}
  \item{survey}{Name of survey annotations belong to.  Must match tblSurvey.fldSurveyName}
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{analyst}{Numerical key value corresponding to the user's tblPerson.pkPersonID value in the acoustics database.}
  \item{\dots}{Additional arguments to RODBC::odbcConnect.}
}

\details{\code{dbUploadAnno} assumes a database structure identical to that provided in the acoustics schema.  If the username and password are present in the ODBC datasource they do not need to be provided.  It is possible to store only the username in the datasource and enter a password, but the reverse will not work.
Annotations are expected to be formatted by (or as if by) \code{viewSpec}, so if another piece of software is recording the annotations the field order must be altered to match output of \code{viewSpec}. 
}

\value{
Invoked for its side effect.  Successful upload is marked by a report of the upload time; unsuccessful upload will report any errors encountered.
}

\author{
Jon Katz
}

\note{
The expected field order is \code{c("start.time", "end.time", "min.frq", "max.frq", "name")}.  \code{"name"} is intentionally ambiguous; it may be used to store the species code, but it is not referenced back to tblSpecies.fldSpeciesCode for verification.
}

\seealso{
\code{\link{viewSpec}}
}

\examples{
# Assumes 'MABI01_2010-05-22_054400_0_000.wav' is a survey in tblSurvey.fldSurveyName
# Assumes 'MABI01_2010-05-22_054400.csv' is a file of annotations belonging to the above survey

\dontrun{
#If using the 'acoustics' schema verbatim:
dbUploadAnno(
    annotations = "MABI01_2010-05-22_054400.csv", 
    survey = "MABI01_2010-05-22_054400_0_000.wav", 
    analyst = 1)

#'acoustics' schema, different database name:
dbUploadAnno(
    annotations = "MABI01_2010-05-22_054400.csv", 
    survey = "MABI01_2010-05-22_054400_0_000.wav", 
    db.name = "LocalSQLdb", 
    uid = "EntryOnly", 
    pwd = "07H23BBM", 
    analyst = 1)}
}

\keyword{database}
\keyword{utilities}
