# Functions for sorting out sound clips
# It can accept (1) Wave objects or file paths to (2) wav or (3) mp3 objects, and return either 1 or 2
# Modified: 6 Sept 2015

getClip <- function(
  clip, 
  name = "clip", 
  output = "file", 
  write.wav = FALSE
) {

  if(inherits(clip, "list") | (inherits(clip, "character") && length(clip)>1)) {
    clist <- list()
    if(grepl(", ",name)) {
      name <- gsub(".*\\(", "", name)
      name <- gsub("\\)", "", name)
      name <- strsplit(name, ",")[[1]]
    }
    for(i in seq(length(clip))) {
      clist[[i]] <- getOneClip(clip[[i]], paste0(name[i], i), output, write.wav) 
    }
    return(clist)
  } 

  return(getOneClip(clip, name, output, write.wav))

}

getOneClip <- function(
  clip, 
  name, 
  output, 
  write.wav
) {

  if(output == "file") {
    if(inherits(clip, "Wave")) {
      fname <- paste0(name, ".wav")
      if(!write.wav) {
	warning("output argument is \"file\" but write.wav argument is FALSE.\nFor better or worse, the monitoR package was designed to use acoustic files, so a temporary file will be used here.\nSet write.wav = TRUE to create a (non-temporary) file, or else specify a wav file instead of a Wave object.")
        fname <- tempfile(fileext = ".wav")
      }
      if(file.exists(fname)) stop("Will not create a wav file from this clip because a file with name ", fname, " already exists.")
      else tuneR::writeWave(clip, fname) 
      return(fname)
    } else 
    if(inherits(clip, "character")) {
      if (grepl('^www.|^http:|^https:', clip)) {
        warning('It looks like clip argument is a URL, so (trying to) download and save an audio file')
        fname <- tempfile(fileext = substr(clip, nchar(clip) - 4, nchar(clip)))
        download.file(clip, fname, mode = 'wb')
        clip <- fname
      }
      if(!file.exists(clip)) stop("clip argument seems to be a file name but no file with the name ", clip, " exists.")
      return(clip)
    } else 
    stop("Can\'t figure out what to do with this clip:", clip, "with class:", class(clip))
  }

  if(output == "Wave") {
    if(inherits(clip, "Wave")) {
      return(clip)
    } else 
    if(inherits(clip, "character")) {
      if (grepl('^www.|^http:|^https:', clip)) {
        warning('It looks like clip argument is a URL, so (trying to) download and save an audio file')
        fname <- tempfile(fileext = substr(clip, nchar(clip) - 4, nchar(clip)))
        download.file(clip, fname, mode = 'wb')
        clip <- fname
      }
      if(!file.exists(clip)) stop("clip argument seems to be a file name but no file with the name ", clip, " exists!")
      file.ext <- tolower(gsub(".*\\.", "", clip))
      if(file.ext == "wav") 
        clip <- tuneR::readWave(clip) else 
      if(file.ext == "mp3") 
        clip <- readMP3(clip) else stop("File extension must be wav or mp3, but got ", file.ext)
      return(clip)
    } else 
    stop("Can\'t figure out what to do with this clip:", clip, "with class:", class(clip))
  }

}   

# Reads a single wav or mp3 file 
readClip <- function(clip) {

  if(!inherits(clip, "character") | length(clip) != 1) stop("Expected a length-one character vector for clip, but got a length ", length(clip), " ", class(clip), " object.")
  if(!file.exists(clip)) stop("clip argument seems to be a file name but no file with the name ", clip, " exists!")
 
  file.ext <- tolower(gsub(".*\\.", "", clip))
  if(file.ext == "wav") return(tuneR::readWave(filename = clip))
  if(file.ext == "mp3") return(readMP3(filename = clip)) 
  stop("File extension must be wav or mp3, but got ", file.ext)

}

