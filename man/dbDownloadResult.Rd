\name{dbDownloadResult}
\alias{dbDownloadResult}
\title{
Create \code{\linkS4class{detectionList}} Objects from Data Stored in a Database 
}
\description{
This function creates \code{detectionList} objects corresponding to a specified survey and \code{\linkS4class{TemplateList}} from data available in an acoustics database.
}
\usage{
dbDownloadResult(db.name = "acoustics", uid, pwd, survey, templates, 
                 type, FFTwl, FFTwn, FFTovlp, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{db.name}{Name of the ODBC connector data source corresponding to the acoustics database.}
  \item{uid}{User ID to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{pwd}{Password to allow ODBC connector to connect to database, if not present in ODBC connector.}
  \item{survey}{Character value, name of survey as it appears in the acoustics database}
  \item{templates}{object of class \code{TemplateList} or character vector of template names as they appear in an acoustics database}
  \item{type}{Character value in c("BIN", "COR") to filter the results for either \code{\link{binMatch}} or \code{\link{corMatch}} results, respectively}
  \item{FFTwl}{Filter for templates with specific FFT window lengths.}
  \item{FFTovlp}{Filter for templates with specific FFT window overlap.}
  \item{FFTwn}{Filter for templates with specific FFT window names.}
  \item{\dots}{Additional arguments to \code{sqlQuery}.  For example, if the function fails on an error such as: Error in as.POSIXlt.character(x, tz, ...) : character string is not in a standard unambiguous format, adding \code{as.is = TRUE} may help circumnavigate the problem (although it will not solve the data issue!)}
}
\details{
This function allows database data to be coerced back into an object of class \code{detectionList}, which is useful in that data can be pulled from the database and used in functions that require \code{detectionList} objects such as \code{plot} and \code{\link{showPeaks}}.  

The resulting \code{detectionList} object will be incomplete as it is missing the complete scores list, which is used to plot the scores in the second row of the above plotting functions.  Hit markers are still plotted, and these can still be useful if set to \code{hit.marker = "points"}. 
}
\value{
An object of class \code{detectionList}
}
\author{
Jon Katz, 
Sasha D. Hafner
}
\seealso{
\code{\linkS4class{detectionList}}, \code{\linkS4class{TemplateList}}, \code{\link{binMatch}}, \code{\link{corMatch}}, \code{\link{showPeaks}}
}
\examples{
\dontrun{
#If using the 'acoustics' schema verbatim:
examp <- dbDownloadResult(
        survey = "INTV02_2011-06-25_081000_EDT.mp3", 
        templates = templates, type = "BIN")
        
#'acoustics' schema, different database name:
examp <- dbDownloadResult(
        db.name = "LocalSQLdb", 
        uid = "EntryOnly" , 
        pwd = "07H23BBM", 
        survey = "INTV02_2011-06-25_081000_EDT.mp3", 
        templates = templates, 
        type = "BIN")}
}

\keyword{database}
\keyword{utilities}
