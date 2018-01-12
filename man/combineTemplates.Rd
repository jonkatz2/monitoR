\name{combineTemplates}
\alias{combineCorTemplates}
\alias{combineBinTemplates}

\title{
Combine Acoustic Template Lists
}

\description{
Use these functions to combine any number of templates together into a larger template list.
They can combine template lists that themselves contain any number of templates.
}

\usage{
combineCorTemplates(...)

combineBinTemplates(...)
}

\arguments{
  \item{\dots}{Correlation \emph{or} binary template lists (class \code{\linkS4class{corTemplateList}} or \code{\linkS4class{binTemplateList}}).}
}

\details{
  These functions are the only way to create template lists containing more than one template, and so should be used often.
  Only \code{binTemplateList} objects should be used with \code{combineBinTemplates}, and only \code{corTemplateList} objects should be used with \code{combineCorTemplates}.
  If you combine templates that use the same name, a suffix (\code{.2}) will be added to the later name.
}

\value{
A \code{\linkS4class{TemplateList}} object that contains all the templates submitted to the function.
}

\author{
  Sasha D. Hafner
}

\seealso{
\code{\link{makeCorTemplate}},  
\code{\link{makeBinTemplate}}, 
\code{\link{templateNames}}
}

\examples{
# First need to make some template lists to combine
# Load data
data(btnw)
data(oven)
data(survey)

# Write Wave objects to file (temporary directory used here)
btnw.fp <- file.path(tempdir(), "btnw.wav")

oven.fp <- file.path(tempdir(), "oven.wav")

writeWave(btnw, btnw.fp)

writeWave(oven, oven.fp)

# Create four correlation templates
wct1 <- makeCorTemplate(btnw.fp, name = "w1")

wct2 <- makeCorTemplate(btnw.fp, t.lim = c(1.5, 2.1), frq.lim = c(4.2, 5.6), 
                        name = "w2")

oct1 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), name = "o1")

oct2 <- makeCorTemplate(oven.fp, t.lim = c(1, 4), frq.lim = c(1, 11), dens = 0.1, 
                        name = "o2")

# Combine all of them
ctemps <- combineCorTemplates(wct1, wct2, oct1, oct2)
ctemps

# Binary templates are similar
# Create four templates
wbt1 <- makeBinTemplate(btnw.fp, amp.cutoff = -40, name = "w1")

wbt2 <- makeBinTemplate(btnw.fp, amp.cutoff = -30, t.lim = c(1.5, 2.1), 
                        frq.lim = c(4.2, 5.6), buffer = 2, name = "w2")

obt1 <- makeBinTemplate(oven.fp, amp.cutoff = -20, t.lim = c(1, 4), 
                        frq.lim = c(1, 11), name = "o1")

obt2 <- makeBinTemplate(oven.fp, amp.cutoff = -17, t.lim = c(1, 4), 
                        frq.lim = c(1, 11), buffer = 2, name = "o2")

# Combine all of them
btemps <- combineBinTemplates(wbt1, wbt2, obt1, obt2)
btemps

# Clean up (only because these files were created in these examples)
file.remove(btnw.fp)

file.remove(oven.fp)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}
\keyword{utilities}
