\name{writeTemplates}
\alias{writeCorTemplates}
\alias{writeBinTemplates}

\title{
  Write Acoustic Templates to Text Files
}

\description{
  These functions write all templates within a template list to text files within a specified directory.
}

\usage{
writeCorTemplates(..., dir = ".", ext = "ct", parallel = FALSE)
writeBinTemplates(..., dir = ".", ext = "bt", parallel = FALSE)
}

\arguments{
  \item{...}{
    One or more template lists. 
  }

  \item{dir}{
    A file path to the directory where the files should be saved.
    If it doesn't exist, the function will create it.
    By default, the working directory.
  }

  \item{ext}{
    The file extension used for the new file(s).
  }

  \item{parallel}{
    Set to \code{TRUE} to use \code{mclapply} from the parallel package to speed up the call for large template lists (not available for Windows operating systems).
  }
}

\details{
For correlation templates (class \code{\linkS4class{corTemplateList}}) use \code{writeCorTemplates}, and use \code{writeBinTemplates} for binary templates (class \code{linkS4class{binTemplateList}}).
To write only some of the templates in a list to file, use indexing (\code{\link{[-methods}}).
}

\value{
\code{NULL}, invisibly.
}

\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{makeCorTemplate}}, 
\code{\link{makeBinTemplate}}, 
\code{\link{readBinTemplates}}, 
\code{\link{readCorTemplates}}
}

\examples{
# Load data
data(btnw)
data(oven)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")
oven.fp <- file.path(tempdir(), "oven.wav")
writeWave(btnw, btnw.fp)
writeWave(oven, oven.fp)

# Create four correlation templates
wct1 <- makeCorTemplate(btnw.fp, name = "w1")
wct2 <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), name = "w2")
oct1 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), name = "o1")
oct2 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, name = "o2")

# Combine all of them
ctemps <- combineCorTemplates(wct1, wct2, oct1, oct2)

# To write ctemps to a directory "templates"
\dontrun{
# Not run because it will write files outside of user's temporary directory
writeCorTemplates(ctemps, dir = "templates")
}

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
}


\keyword{IO}
\keyword{file}
