\name{viewSpec}
\alias{viewSpec}
\title{
Interactively View and Annotate Spectrograms
}

\description{
Interactively page through short or long spectrograms of wav or mp3 files or \code{\link[tuneR]{Wave}} objects.  Extract short or long wave files, play audio while viewing spectrogram, and annotate sounds in the spectrogram.  Load annotations from csv files for viewing.  
}

\usage{
viewSpec(clip, interactive = FALSE, start.time = 0, 
    units = "seconds", page.length = 30, 
    annotate = FALSE, anno, channel = "left", 
    output.dir = getwd(), frq.lim = c(0, 12), spec.col = gray.3(), 
    page.ovlp = 0.25, player = "play", wl = 512, ovlp = 0, 
    wn = "hanning", consistent = TRUE, 
    mp3.meta = list(kbps = 128, samp.rate = 44100, stereo = TRUE), 
    main = NULL, ...)
}

\arguments{
  \item{clip}{File path to wav file, mp3 file, or wave object.  See Details.}
  \item{interactive}{Logical.  \code{FALSE} displays the first 30 seconds (or more, if \code{page.length} is increased) of a spectrogram.  \code{TRUE} enables the options to page through spectrograms, zoom in time and frequency, play, extract segments, and annotate.  See Details.}
  \item{start.time}{Time in file to start reading.}
  \item{units}{Units for start.time.  Available units are \code{c("seconds", "minutes", "hours")} Defaults to "seconds".}
  \item{page.length}{Duration of page length to view, in seconds.  Can be repeatedly halved and doubled within the function.}
  \item{annotate}{Logical, to allow sounds to be highlighted and named on the spectrogram.  See Details.}
  \item{anno}{Character, file path to csv containing annotations.  Read in only if \code{annotate = TRUE}.}
  \item{channel}{Character value in \code{c("left", "right", "both")}.  Stereo recordings may be viewed as single channel or multi-channel spectrograms.  See Details.}
  \item{output.dir}{File path to directory where extracted clips and annotations will be saved, if other than the current working directory.}
  \item{frq.lim}{Initial frequency limits to spectrogram, in kHz.  Accepts a 2 element vector.  Can be adjusted from within the function.}
  \item{spec.col}{Color (or grayscale) gradient to apply to the spectrogram.  See Details.}
  \item{page.ovlp}{Numeric value between 0 and 1.  Proportion of page.length to overlap when moving to a new page.}
  \item{player}{Character value specifying an audio player to play the portion of the file corresponding to the visible spectrogram.}
  \item{wl}{Numeric value specifying number of samples per window in the Fourier Transform.  Accepts powers of 2: \code{c(128, 256, 512, 1024, 2048)}}
  \item{ovlp}{Numeric value specifying window overlap in the Fourier Transform.  Specified as a percent between 0 and 99.}
  \item{wn}{Character value specifying window function in the Fourier Transform.  Defaults to \code{"hanning"}; \code{"hamming"} is also implemented.}
  \item{consistent}{Logical, offers a method of maintaining color gradient map from page to page.  See Details.}
  \item{mp3.meta}{List of metadata used when paging through mp3 files using mp3splt.  \code{kbps} is the compression rate, \code{samp.rate} is the sample rate, and \code{stereo} is logical where \code{TRUE} represents both stereo and JntStereo.}  
  \item{main}{Optional character object with which to name the spectrogram.  If \code{NULL} the file name will be used if possible.}
  \item{\dots}{Additional arguments to \code{\link{spectro}}}
}

\details{
When \code{interactive = TRUE}, during the function session the console will display a command menu that prints commands to scroll or nudge to the next/previous page, zoom in/out in the time axis (by halving or doubling the page.length), play the page, save the page as a wave file, change spectrogram parameters (e.g. \code{frq.lim, start.time, wl, ovlp, } etc), or quit. An option not presented on-screen is "i" to identify the RMS amplitude in a selected portion of the spectrogram.\cr  

\code{viewSpec} relies on the WaveIO functions in \code{\link[tuneR]{tuneR}}, with some modifications.  Seeking in wave files and wave objects is accurate to the nearest sample, but the decoding required for mp3 files is "bare bones".  Users can install the software mp3splt which will allow seeking in mp3 files very similar (albeit slightly less accurate) to that that exists for wave files.  When using mp3splt a short mp3 file the duration of each page is extracted from the \code{clip} file or object and saved to the working directory for each new page.\cr

When \code{annotation} is set to TRUE the default is to start a new annotation file, unless a csv file containing annotations is specified with the argument \code{anno}.  Annotation adds the option to annotate to the console command menu, and annotations can be made after typing "a" into the console and pressing enter.  Annotation is accomplished by selecting first the upper-left corner of a bounding box around an event in the spectrogram followed by the lower-right corner; after the selection is complete the console will prompt to name the annotation.  At a minimum the first annotation must be named, but subsequent annotations will recycle the previous name if a new one is not provided.  When in annotation mode the console menu is not shown; instructions for annotation are displayed instead.  To exit annotation mode right-click an appropriate number of times, and the console command menu will return.  One or more annotations can be deleted by typing "d" in the console after the command menu is displayed, then bounding all annotations to delete in the same manner as if creating a new annotation.  Annotations are saved when the command to exit the function is initiated ("q").  Occasionally unrecognized commands may cause the function to exit before annotations can be saved; to guard against losing annotations in such an event, annotations are auto-saved to a file called "TMPannotations.csv" in the working directory, from where they can be retrieved until written over during the next session.  Annotation is only possible in one channel per function invocation.  The channel will revert to \code{"left"} if \code{annotate = TRUE} and \code{channel = "both"}.\cr  

Spectrogram colors are adjustable, and users may opt to create their own gradients for display.  A few are provided with monitoR including \code{\link{gray.1}}, \code{\link{gray.2}}, \code{\link{gray.3}}, \code{\link{rainbow.1}}, and \code{\link{topo.1}}, all of which are based on existing R colors.  The gradient is mapped to the values in the spectrogram each time the page is loaded.  In \code{gray.2}, for example, this means that every page will display the highest dB value as black and the lowest value as white.  The highest dB value likely changes from page to page, which can result in successive pages being displayed with wildly different color values.  Setting \code{consistent = TRUE} (the default) offers a way to minimize this effect, as it artificially weights a single cell in the lower-left corner with a value of 0 dB, which is usually mapped to a black.  Under normal circumstances this artificially black cell will not be noticed, but at high magnification it may stand out as erroneous, in which case setting \code{consistent = FALSE} may be warranted.\cr

Spectrograms of existing \code{Wave} objects are titled with the first argument of the call, which is assumed to be \code{clip}.\cr

The default audio player, "play", is the shell command for SoX, the multi-OS media player. Windows will detect the file type and use the default media player with "start", or you can specify one (such as Windows Media Player) with "start wmplayer.exe". On Ubuntu try Rhythmbox ("rhythmbox"), and on Mac OS try afplay ("afplay").           

}
\value{
A spectrogram plot.  Certain options invoked during the function may write new wave or csv files to the working directory.
}

\note{
The time axis is presented with a fair amount of rounding.  It becomes progressively more accurate as the zoom level increases.
}

\author{
Jon Katz, Sasha D. Hafner
}

\seealso{
\code{\link{dbUploadAnno}}
}

\examples{
data(survey)
viewSpec(survey)

\dontrun{
# Start a new annotation file
viewSpec(survey, annotate = TRUE)

# View previous annotations
data(survey_anno)
write.csv(survey_anno, "survey_anno.csv", row.names = FALSE)
viewSpec(survey, interactive = TRUE, annotate = TRUE, anno = "survey_anno.csv", start.time = 5)

# Disable consistent spectrograms
viewSpec(survey, interactive = TRUE, annotate = TRUE, page.length = 10, consistent = FALSE)
}}

\keyword{iplot}
