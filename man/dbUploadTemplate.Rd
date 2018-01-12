\name{dbUploadTemplate}
\alias{dbUploadTemplate}
\title{Upload Acoustic Templates to a Database}

\description{
Upload a binary point matching or correlation template list containing one or more templates to tblTemplate in an acoustics database.  One or more templates may be indexed by name or position from the template list for upload.
}

\usage{
dbUploadTemplate(templates, which.one, db.name = "acoustics", uid , pwd, analyst, 
locationID = "", date.recorded = "", recording.equip = "", species.code, 
type, ...)
}

\arguments{
  \item{templates}{\code{TemplateList} object of class \code{binTemplateList} or \code{corTemplateList} to upload.}
  \item{which.one}{Indexing option for individual templates within the \code{TemplateList} object.  Indexing may be by name or numerical position.  If missing, all templates within the list are uploaded.}
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{analyst}{Numerical key value corresponding to the user's tblPerson.pkPersonID value in the acoustics database.}
  \item{locationID}{Numerical key value corresponding to the location's tblLocation.pkLocationID value in the acoustics database.}
  \item{date.recorded}{Dates template clip was recorded, in a recognizable POSIX format: YYYY/MM/DD.}
  \item{recording.equip}{Equipment used to record template clip.}
  \item{species.code}{Character value corresponding to the species' tblSpecies.fldSpeciesCode value in the acoustics database; usually a 4, 6, or 8-character code.  Codes not in the database will return a cryptic error and cause upload to fail.}
  \item{type}{Character value identifying template type, in c("BIN", "COR").  Some partial matching is performed.}
  \item{\dots}{Additional arguments to \code{RODBC::odbcConnect}.}
}

\details{
\code{dbUploadTemplate} assumes a database structure identical to that provided in the acoustics schema.  If the username and password are present in the ODBC datasource they do not need to be provided.  It is possible to store only the username in the datasource and enter a password, but the reverse will not work.
  
The following must be true for upload to succeed:
The value for analyst must be present in tblPeople.pkPeopleID
The value for locationID must be present in tblLocation.pkLocationID
the value for species.code must be present in tblSpecies.fldSpeciesCode}
\value{This function is invoked for its side effect, which is to insert the template list into tblTemplate in an acoustics database.  Successful upload is marked by a report of the upload time; unsuccessful upload will report any errors encountered.
}

\author{
Jon Katz
}

\note{
In the acoustics database templates are broken into components, and vectors are stored as text objects in various fields.  Ultimately templates must be downloaded again to be used; to stay beneath the maximum download vector size of \code{\link[RODBC]{sqlQuery}}, extraneous characters are removed from each vector during upload.  All amplitude values for correlation templates are sign-inverted and converted from floating point decimal to integers, and all decimals are rounded to the hundredth's place before upload; after upload all spaces, new-line, and carriage return characters are removed.  Removal of these characters is usually the most time-consuming part of the upload process, and the console will report "cleaning up" while this is taking place.  These measures sometimes inadequately trim character count, and users may find it necessary to increase the maximum download vector size in sqlQuery (see the vignette "MySQL_DataSources_RODBC" for further details).  Large templates may take more than several seconds to upload; 2-5 seconds is normal for binary point matching templates, and 5-20 seconds is normal for correlation templates.
}

\seealso{
\code{\link{dbDownloadTemplate}}
}

\examples{
# Template construction
\dontrun{
data(btnw)
b4 <- makeBinTemplate(
    "btnw.wav", 
    frq.lim = c(2, 8), 
    select = "auto", 
    name = "b4", 
    buffer = 4, 
    amp.cutoff = -31, 
    binary = TRUE)

\dontrun{
#If using the 'acoustics' schema verbatim:
dbUploadTemplate(
    templates = b4, 
    analyst = 1, 
    locationID = "MABI01", 
    date.recorded = "2012/05/22", 
    recording.equip = "SM2", 
    species.code = "BTNW", 
    type = "BIN")
    
#'acoustics' schema, different database name:
dbUploadTemplate(
    templates = b4, 
    which.one = 1, 
    db.name = "LocalSQLdb", 
    uid = "EntryOnly", 
    pwd = "07H23BBM", 
    analyst = 1, 
    locationID = "MABI01", 
    date.recorded = "2012/05/22", 
    recording.equip = "SM2", 
    species.code = "BTNW", 
    type = "BIN")}
}
}

\keyword{database}
\keyword{utilities}
