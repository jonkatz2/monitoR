\name{readTemplates}
\alias{readBinTemplates}
\alias{readCorTemplates}

\title{
Read Acoustic Templates from a Local Disk
}
\description{
Read single templates stored on a local disk, or read in entire directories of templates.
}
\usage{
readBinTemplates(files = NULL, dir = ".", ext = "bt", parallel = FALSE)
readCorTemplates(files = NULL, dir = ".", ext = "ct", parallel = FALSE)
}
\arguments{
  \item{files}{Optional named vector of file names. See details.}
  \item{dir}{Name of directory to read files from. Default is working directory.}
  \item{ext}{Extension of files that should be read in. Files in \code{dir} without this extension will be skipped. Not necessary if \code{files} is provided.}
  \item{parallel}{Logical.  \code{TRUE} uses mclapply, otherwise lapply is used.}
}
\details{
These functions can be used in three different ways, in both cases combing all templates read in into a single template list.
By specifying a character vector of file names for \code{files}, they will read in the named files, and assign names based on file names.
If \code{files} is a named vector, the vector names will be used in the resulting template list.
Finally, if \code{files} is not provided, the functions will read in all saved templates with the extension \code{ext}.
}
\value{
An object of class \code{\linkS4class{TemplateList}} containing either binary point templates or spectrogram cross-correlation templates.  
}

\author{
Sasha D. Hafner
}

\seealso{
\code{\link{writeBinTemplates}}, 
\code{\link{writeCorTemplates}}
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

# Correlation example
# Create one correlation templates
wct1 <- makeCorTemplate(btnw.fp, name = "w1")
wct2 <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), name = "w2")
oct1 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), name = "o1")
oct2 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, name = "o2")

# Combine all of them
ctemps <- combineCorTemplates(wct1, wct2, oct1, oct2)

\dontrun{
# Write ctemps to a directory "templates"
writeCorTemplates(ctemps, dir = "templates")

# Read in all correlation templates in a directory "templates"
ctemps <- readCorTemplates(dir = "templates")

# Read in two specific files
ctemps <- readCorTemplates(files = c("o1.ct", "o2.ct"), dir = "templates")

# Read in two specific files, and give them names
ctemps <- readCorTemplates(files = c(oven1 = "o1.ct", oven2 = "o2.ct"), dir = "templates")
}

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)
file.remove(oven.fp)
}

\keyword{IO}
\keyword{file}
