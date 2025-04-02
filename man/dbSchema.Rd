\name{dbSchema}
\alias{dbSchema}

\title{
Upload a MySQL Database Schema to Create Tables in an Acoustics Database
}
\description{
Use this function to select a schema and upload it to an existing MySQL database.  All tables in the schema will be created in the database.
}
\usage{
dbSchema(schema, name.on.host, tables = FALSE, 
         schema.name = "NOH", db.name = "acoustics", uid, pwd, 
         ...)
}

\arguments{
  \item{schema}{File path to schema (.txt or .sql).}
  \item{name.on.host}{Database name on MySQL host.}
  \item{tables}{\code{TRUE} will return the result of \code{\link[RODBC]{sqlTables}}}
  \item{schema.name}{Current name of schema to be replaced by \code{name.on.host}}
  \item{db.name}{Connection name in ODBC data source.}
  \item{uid}{Database User ID, if not in ODBC data source.}
  \item{pwd}{Database Password, if not in ODBC data source.}
  \item{...}{Additional arguments to \code{\link[RODBC]{odbcConnect}}.}
}
\details{
Creating a MySQL database typically requires three steps:\cr
1. Design/test/export schema\cr
2. Create a MySQL instance on the host (locally or on a server)\cr
3. Import schema to create tables, keys, and relationships\cr
\cr
The default acoustics database schema will allow the user to skip step 1; this function will take care of step 3.  The user must ensure that a database instance exists and is present in the ODBC data source list before attempting to use this function.  This function was tested using a schema automatically generated using the default "forward engineer" export function in MySQL Workbench with DROP statements. The default acoustics schema can be downloaded at \url{https://www.uvm.edu/rsenr/vtcfwru/R/?Page=monitoR/monitoR.htm}.
}
\value{
If \code{tables}, a list:\cr
  \item{upload.time}{Duration of upload and processing.}
  \item{tables}{Description tables in the acoustics database.}
\cr
Otherwise a report of the duration of upload and processing time to indicate completion.
}
\author{
Jon Katz
}

\examples{
\dontrun{
dbSchema(
    schema = "acoustics.sql", 
    name.on.host = "acoustics", 
    tables = TRUE, 
    schema.name = 'myschema', 
    db.name = "acoustics", 
    uid = "Admin", 
    pwd = "BadPassword!" )
     
## $upload.time
## [1] "Upload time 10.977 secs"
##
## $tables
##    TABLE_CAT TABLE_SCHEM           TABLE_NAME TABLE_TYPE
## 1     JKATZ3                   tblAnnotations      TABLE
## 2     JKATZ3                       tblArchive      TABLE
## 3     JKATZ3                          tblCard      TABLE
## 4     JKATZ3                  tblCardRecorder      TABLE
## 5     JKATZ3                     tblCovariate      TABLE
## 6     JKATZ3             tblEnvironmentalData      TABLE
## 7     JKATZ3                      tblLocation      TABLE
## 8     JKATZ3                  tblOrganization      TABLE
## 9     JKATZ3                        tblPerson      TABLE
## 10    JKATZ3                 tblPersonContact      TABLE
## 11    JKATZ3                       tblProject      TABLE
## 12    JKATZ3                      tblRecorder      TABLE
## 13    JKATZ3                        tblResult      TABLE
## 14    JKATZ3                 tblResultSummary      TABLE
## 15    JKATZ3                       tblSpecies      TABLE
## 16    JKATZ3                 tblSpeciesPriors      TABLE
## 17    JKATZ3                        tblSurvey      TABLE
## 18    JKATZ3                      tblTemplate      TABLE
## 19    JKATZ3                 tblTemplatePrior      TABLE
##                                                          REMARKS
## 1                          For annotated song events in surveys.
## 2              For archiving sound clips extracted from surveys.
## 3              This table stores information about memory cards.
## 4                 Track survey, recorder, and memory card links.
## 5  Describe covariates and types of enviromental data collected.
## 6                   Non-acoustic data: environmental covariates.
## 7   Information about about locations for surveys and templates.
## 8             Store the organization name and contact info here.
## 9                     Names of people in the monitoring program.
## 10            Contact info, including Cell/Work Phone and email.
## 11   Store the names of multiple projects per organization here.
## 12          This table stores information about recording units.
## 13                    Table to store the results of findPeaks().
## 14                         Store probability of survey presence.
## 15          Store BBL codes or other 4, 6, or 8 character codes.
## 16                    Store site & species specific priors here.
## 17         This table stores attributes of the survey recording.
## 18                        Store templates and template metadata.
## 19               Store beta parameter estimates for error rates.


}
}

\keyword{database}
\keyword{utilities}
