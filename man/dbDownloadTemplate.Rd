\name{dbDownloadTemplate}
\alias{dbDownloadTemplate}
\title{Retrieve templates from an acoustics database}

\description{
Download Acoustic Templates from a Database
}

\usage{
dbDownloadTemplate(db.name = "acoustics", uid, pwd, type, names, 
                   species, FFTwl, FFTovlp, FFTwn, ...)
}

\arguments{
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{type}{Type of templates to select. Character value of either "BIN" or "COR".  Some partial matching is performed to accept "bt" and "ct", for example.}
  \item{names}{Optional character value or vector of template names to filter selection from the database. If missing all templates matching other filters are selected.}
  \item{species}{Optional character value or vector of species to filter selection from the database. If missing all templates matching other filters are selected.}
  \item{FFTwl}{Optional character value or vector of FFT window lengths to filter selection from the database. If missing all templates matching other filters are selected.}
  \item{FFTovlp}{Optional character value or vector of FFT window overlap to filter selection from the database. If missing all templates matching other filters are selected.}
  \item{FFTwn}{Optional character value or vector of FFT window names to filter selection from the database. If missing all templates matching other filters are selected.}
  \item{\dots}{Additional arguments to \code{\link[RODBC]{odbcConnect}}.}
}

\details{
This function assumes a database structure identical to that provided in the acoustics schema.  If the username and password are present in the ODBC datasource they do not need to be provided.  It is possible to store only the username in the datasource and enter a password, but the reverse will not work.
}

\value{
An object of class \code{\linkS4class{TemplateList}}.
}

\author{
Jon Katz
}

\note{
In the acoustics database templates are broken into components, and vectors are stored as text objects in various fields. To stay beneath the maximum download vector size of \code{\link[RODBC]{sqlQuery}}, extraneous characters are removed from each vector during upload; some must be re-inserted during download.  Space characters are not replaced, but all amplitude values for correlation templates are sign-inverted and converted from integers to floating point decimal.  All decimals were rounded to the hundredth's place during upload.  These measures are sometimes insufficient and users may find it useful to increase the maximum download vector size in sqlQuery (see the vignette \dQuote{MySQL_DataSources_RODBC} for further details).  Large templates may take more than several seconds to download; 2-10 seconds is normal for binary point matching templates, and 5-30 seconds is normal for correlation templates.
}

\seealso{
\code{\link{dbUploadTemplate}}
}

\examples{
\dontrun{
#If using the 'acoustics' schema verbatim:
btnw <- dbDownloadTemplate(
        type = "BIN", 
        names= c("template1", "template2")
        FFTwl = 512, 
        FFTovlp = 0, 
        FFTwn = "hanning")
        
#'acoustics' schema, different database name:
btnw <- dbDownloadTemplate(
        db.name = "LocalSQLdb", 
        uid = "EntryOnly" , 
        pwd = "07H23BBM", 
        type = "COR", 
        species = c("BTNW", "OVEN") 
        FFTwl = 512, 
        FFTovlp = 0, 
        FFTwn = "hanning")}
}

\keyword{database}
\keyword{utilities}
