\name{survey_anno}
\alias{survey_anno}
\docType{data}
\title{
Annotations for \code{\link{survey}}
}
\description{
Data frame containing annotations for the data file \code{\link{survey}}.
}
\usage{data(survey_anno)}

\format{
  The format is:
    'data.frame':	7 obs. of  5 variables:
     $ start.time: num  1.06 4.21 7.55 9.85 13.84 ...
     $ end.time  : num  2.59 7.41 10.7 11.06 15.85 ...
     $ min.frq   : num  3.61 2.58 2.63 3.88 2.82 ...
     $ max.frq   : num  6.35 9.54 9.33 6.25 6.39 ...
     $ name      : Factor w/ 2 levels "BTNW", "OVEN": 1 2 2 1 2 2 1
}
\details{
These annotations can be plotted onto the spectrogram by loading them in with the \code{anno} argument of \code{\link{viewSpec}}. 
}

\examples{
\dontrun{
# View annotations
data(survey)
data(survey_anno)
write.csv(survey_anno, "survey_anno.csv", row.names = FALSE)
viewSpec(survey, annotate = TRUE, anno = "survey_anno.csv")
}
}
\keyword{datasets}
