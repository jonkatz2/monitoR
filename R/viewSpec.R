# For viewing spectrograms
# Modified: 6 Sept 2015

viewSpec <-
function(
   clip,                                         # Wave object or file path to wav or mp3 file
   interactive = FALSE,                             # TRUE to page through long files, FALSE to view short clips and then quit
   start.time = 0,                                 # Time in file to begin spectrogram (see units)
   units = 'seconds',                              # Units for start.time
   page.length = 30,                               # Seconds to view per page
   annotate = FALSE,                               # True enables annotation mode
   anno,                                         # File path to csv file containing annotations
   channel = 'left',                               # Channel to view ( != 'both' if(annotate)) 
   output.dir = getwd(),                           # Directory to save clips
   frq.lim = c(0, 12),                              # Frequency limits of spectrogram
   spec.col = gray.3(),                            # Color palette for spectrogram
   page.ovlp = 0.25,                               # Proportion of page to overlap
   player = 'play',                                # Player for listening: 'play' (Sox), 'wv_player.exe'
   wl = 512,                                       # Window length for spectro
   ovlp = 0,                                       # % overlap between windows for spectro
   wn = 'hanning',                                 # Window type for spectro
   consistent = TRUE,                              # Maintain consistent color scaling
   mp3.meta = list(kbps = 128, samp.rate = 44100, stereo = TRUE),       # c(128, 192, 256, 320) mp3 bitrate, value for sample rate
   main = NULL,                                    # Optional plot title
   ...
){

   # Single recording
   if(inherits(clip, 'character') & !inherits(clip, 'Wave')) { 
      file.ext <- tolower(gsub(".*\\.", "", clip))
      # Read header
      if(file.ext == 'wav') {
         header <- tuneR::readWave(filename = clip, header = TRUE) 
      } else if(file.ext == 'mp3') {
         bps <- mp3.meta[['kbps']]*1000/8
         size <- file.info(clip)$size
         rec.dur <- size/bps
         header <- list('sample.rate' = mp3.meta[['samp.rate']], 'samples' = rec.dur*mp3.meta[['samp.rate']], 'channels' = mp3.meta[['stereo']]+1)
      } else stop('File extension must be wav or mp3, got ', file.ext)
   } else if(inherits(clip, 'Wave')) {
      header <- list('sample.rate' = clip@samp.rate, 'samples' = length(clip@left), 'channels' = clip@stereo+1)
   } else if(!inherits(clip, 'Wave')) {
      stop(paste('Expect file path or wave object for wave argument, got ', clip))
   }
   # Convert units to seconds
   if(units == 'seconds') {
#      page.length <- page.length
      start.time <- start.time
   } else if(units == 'minutes') {
#      page.length <- page.length*60
      start.time <- start.time*60
   } else if(units == 'hours') {
#      page.length <- page.length*3600
      start.time <- start.time*3600
   } else if(units == 'samples') {
#      page.length <- page.length/header$sample.rate
      start.time <- start.time/header$sample.rate
   } else stop('units must be in c("samples", "seconds", "minutes", "hours")')
   # Determine number of channels to read
    if(annotate && channel == 'both') { 
        cat("Defaulting to channel 'left' to annotate.\n")
        channel <- 'left'
    }
    if(annotate) {
         if(missing(anno)) {
             cat('\nStarting a new annotation file.\n')
             anno.dat <- anno.mat <- data.frame("start.time" = NULL, "end.time" = NULL, "min.frq" = NULL, "max.frq" = NULL, "text" = NULL)
         } else {
             anno.dat <- read.csv(anno, header = TRUE)
             anno.mat <- data.frame("start.time" = NULL, "end.time" = NULL, "min.frq" = NULL, "max.frq" = NULL, "text" = NULL)
         }
         txt <- NA
         interactive <- TRUE 
    }
    a.mode <- FALSE # a.mode is continuous annotation until canceled: off until annotation begins

    # Define the viewer function; assumes wave is already a "Wave" object, can plot mono or stereo, and returns a list of spectrogram parameters that need to be recalled later
    specPlot <- function(wave, frq.lim, channel, consistent, page.length, quiet = FALSE, wl, ovlp, wn, main, ...){
        # Fourier transform
        fspec <- spectro(wave = wave, wl = wl, ovlp = ovlp, wn = wn, ...) # Make the left amp matrix
        # Filter amplitudes 
        t.bins <- fspec$time
        n.t.bins <- length(t.bins)
        which.t.bins <- 1:n.t.bins
        which.frq.bins <- which(fspec$freq >= frq.lim[1] & fspec$freq <= frq.lim[2])
        frq.bins <- fspec$freq[which.frq.bins]
        n.frq.bins <- length(frq.bins)
        amp <- round(fspec$amp[which.frq.bins, ],2)
        if(consistent) {
            amp[1, 1] <- 0 # set a single cell to 0 for a more consistent colorscale
#            amp[amp>0] <- 0 # Truncate values greater than 0 to 0
        }
        # Bin steps
        t.step <- t.bins[2]-t.bins[1]
        frq.step <- frq.bins[2]-frq.bins[1]
        if(channel == 'both') { # Make the right amp matrix 
            wave.R <- tuneR::channel(wave, which = 'right')
            fspec.R <- spectro(wave = wave.R, wl = wl, ovlp = ovlp, wn = wn, ...)
            frq.bins.R <- fspec.R$freq[which.frq.bins]
            amp.R <- round(fspec.R$amp[which.frq.bins, ],2)
            if(consistent) {
                amp.R[1, 1] <- 0 # set a single cell to 0 for a more consistent colorscale
#                amp.R[amp.R>0] <- 0 # Truncate values greater than 0 to 0
            }
        }
        # Open graphics device
        if(channel != 'both') par(mar = c(5, 4,4, 4))#, mai = c(0.82, 0.82, 0.82, 0.32))
        else open.plots <- layout(matrix(c(1, 1,2, 2), nrow = 2, ncol = 2, byrow = TRUE), heights = c(2, 2))
        # Create on-screen plot
        if(channel != 'both') { # Plot single spectrogram if mono
            image(x = which.t.bins, y = which.frq.bins, t(amp), col = spec.col, xlab = 'Time', ylab = 'Frequency (kHz)', las = 1, useRaster = TRUE, axes = FALSE, las = 1, main = main)
            box()
            frq.bin.ticks <- pretty(frq.bins, n = 5)
            axis(2, at = frq.bin.ticks/frq.step, labels = frq.bin.ticks, las = 1)
        } else { # Plot spectrogram 1, then spectrogram 2 if stereo
            par(mar = c(0.1, 5,4, 3))
            image(x = which.t.bins, y = which.frq.bins, t(amp), col = spec.col, xlab = "", ylab = 'Left (kHz)', las = 1, useRaster = TRUE, axes = FALSE, las = 1, main = main)
            box()
            frq.bin.ticks <- pretty(frq.bins, n = 5)
            axis(2, at = frq.bin.ticks/frq.step, labels = frq.bin.ticks, las = 1)
            par(mar = c(4, 5,0.1, 3))
            image(x = which.t.bins, y = which.frq.bins, t(amp.R), col = spec.col, xlab = 'Time', ylab = 'Right (kHz)', las = 1, useRaster = TRUE, axes = FALSE, las = 1)
            box()
            frq.bin.ticks <- pretty(frq.bins, n = 5)
            axis(2, at = frq.bin.ticks/frq.step, labels = frq.bin.ticks, las = 1)
        }
            t.bin.ticks <- pretty(t.bins, n = 6)
        t.bin.ticks <- pretty(t.bins, n = 10, min.n = 5)   
        if(page.length<5) {
            axis(1, at = t.bin.ticks/t.step, labels = format(as.POSIXct(t.bin.ticks+start.time, origin = "1960-01-01", tz = "GMT"), format = '%H:%M:%OS2'))
        } else {
            axis(1, at = t.bin.ticks/t.step, labels = format(as.POSIXct(t.bin.ticks+start.time, origin = "1960-01-01", tz = "GMT"), format = '%H:%M:%S'))
        }

        if(!quiet && channel == 'both') {return(list(t = t.step, f = frq.step, tb = n.t.bins, amp = amp, whicht = which.t.bins, whichf = which.frq.bins, ampR = amp.R))#, tw = t.wave))
        } else if(!quiet && channel != 'both') return(list(t = t.step, f = frq.step, tb = n.t.bins, amp = amp, whicht = which.t.bins, whichf = which.frq.bins))#, tw = t.wave))
    }
   # View a spectrogram only
    if(!interactive) {
       if(!inherits(clip, 'Wave')) {
            if(file.ext == 'wav') {wave <- tuneR::channel(tuneR::readWave(filename = clip, from = start.time, to = start.time+page.length, units = 'seconds'), which = channel) 
            } else if(file.ext == 'mp3') {
                temp.page.l <- page.length+2
                wave <- tuneR::channel(readMP3(filename = clip, from = round(start.time), to = round(start.time+temp.page.l)), which = channel)
                wave <- cutWave(wave = wave, from = 0, to = page.length)
#                wave <- tuneR::channel(readMP3(filename = clip, from = start.time, to = start.time+page.length), which = channel)
            } else wave <- tuneR::channel(cutWave(wave = clip, from = start.time, to = min(start.time+page.length, length(clip@left)/clip@samp.rate)), which = channel)
        } else wave <- tuneR::channel(cutWave(wave = clip, from = start.time, to = min(start.time+page.length, length(clip@left)/clip@samp.rate)), which = channel)
        t.wave <- length(wave@left)/wave@samp.rate
        if(t.wave<page.length) page.length <- t.wave
        if(is.null(main) && inherits(clip, 'Wave')) {#main <- 'Existing wave object'
            main <- as.character(sys.call(sys.parent(n = 1)))[2]
        } else if(is.null(main)) main <- strsplit(clip, '/')[[1]][length(strsplit(clip, '/')[[1]])]
        specPlot(wave = wave, frq.lim = frq.lim, channel = channel, consistent = consistent, page.length = page.length, quiet = TRUE, wl = wl, ovlp = ovlp, wn = wn, main = main, ...)
    # Loop through long clip
    } else { 
       while(start.time<header$samples/header$sample.rate) {
          cat('Reading file...\n')
          if(!inherits(clip, 'Wave')) {
             if(file.ext == 'wav') {wave <- tuneR::channel(tuneR::readWave(filename = clip, from = start.time, to = start.time+page.length, units = 'seconds'), which = channel)
             } else if(file.ext == 'mp3') {
                temp.page.l <- page.length+2
                wave <- tuneR::channel(readMP3(filename = clip, from = round(start.time), to = round(start.time+temp.page.l)), which = channel)
                wave <- cutWave(wave = wave, from = 0, to = page.length)
#                if(channel == 'left' || channel == 'both') wave@left <- wave@left[1:(length(wave@left)-0.5*header[['sample.rate']])]
#                if(channel == 'right' || channel == 'both') wave@left <- wave@right[1:(length(wave@right)-0.5*header[['sample.rate']])]
                } 
          } else {
             wave <- tuneR::channel(cutWave(wave = clip, from = start.time, to = min(start.time+page.length, length(clip@left)/clip@samp.rate)), which = channel)
          }
          t.wave <- length(wave@left)/wave@samp.rate
          if(t.wave<page.length) page.length <- t.wave
          if(is.null(main) && inherits(clip, 'Wave')) {#main <- 'Existing wave object'
            main <- as.character(sys.call(sys.parent(n = 1)))[2]
          } else if(is.null(main)) main <- strsplit(clip, '/')[[1]][length(strsplit(clip, '/')[[1]])]
          step <- specPlot(wave = wave, frq.lim = frq.lim, channel = channel, consistent = consistent, page.length = page.length, wl = wl, ovlp = ovlp, wn = wn, main = main, ...)
          # compute end time
          page.end <- start.time+page.length
          # Draw annotations
          if(annotate){
             if(nrow(anno.dat)>0){
                anno.mat <- anno.dat[anno.dat$start.time>= start.time-10 & anno.dat$end.time<= page.end+10 & anno.dat$min.frq>= frq.lim[1] & anno.dat$max.frq<= frq.lim[2], ]
                anno.mat[, 1:2] <- (anno.mat[, 1:2]-start.time)/step[['t']]
#                anno.mat[, 3:4] <- (anno.mat[, 3:4]-frq.lim[1])/step[['f']]
                anno.mat[, 3:4] <- anno.mat[, 3:4]/step[['f']]
                if(nrow(anno.mat)>0) {
                   rect(anno.mat$start.time, anno.mat$min.frq, anno.mat$end.time, anno.mat$max.frq)
                   text(x = anno.mat$start.time+(anno.mat$end.time-anno.mat$start.time)/2, y = anno.mat$max.frq, labels = anno.mat$name, pos = 3)
                }
             }
          }                  
          # Collect plot options
          if(annotate & !a.mode) {cat('Enter: \n  a to annotate, \n  d to delete annotations, \n  n(m) for next page, \n  b(v) for previous page, \n  p to play, \n  z to zoom in, \n  x to zoom out, \n  s to save page as wave file, \n  c to change spectrogram parameters, \n  q to exit\n')
          } else if(!a.mode) cat('Enter: \n  n(m) for next page, \n  b(v) for previous page, \n  p to play, \n  z to zoom in, \n  x to zoom out, \n  s to save page as wave file, \n  c to change spectrogram parameters, \n  q to exit\n')  
          if(a.mode) x <- 'a'
          else x <- tolower(readLines(n = 1))
          if(x == "" || x == 'n') { # page right; previously read x != "" && x == 'n'
             if(page.end>= header$samples/header$sample.rate) {
                start.time <- header$samples/header$sample.rate-page.length
                cat('End of file.\n')
             } else start.time <- page.end-page.ovlp*page.length
          } else if(x != "" && x == 'm') { # this is a nudge to the right
             if(start.time+page.length/2>= header$samples/header$sample.rate) {
                start.time <- header$samples/header$sample.rate-page.length/2
                cat('End of file.\n')
             } else start.time <- start.time+page.length/2-page.ovlp*page.length
          } else if(x != "" && x == 'b') { # page left
             if(start.time-page.length<0) {
                start.time <- 0 
             } else {
                start.time <- start.time-page.length+page.ovlp*page.length
                }
          } else if(x != "" && x == 'v') { # and this is a nudge to the left
             if(start.time-page.length/2<0) {
                start.time <- 0 
             } else {
                start.time <- start.time-page.length/2+page.ovlp*page.length
                }
          } else if(x != "" && x == 'p') {
             tuneR::writeWave(object = wave, filename = tempname <- tempfile(fileext = '.wav'))
             # Variation on next line may be needed if player is slow
             #Sys.sleep(2) 
             if(tolower(Sys.info()['sysname']) == 'windows') shell(cmd = paste(player, tempname), wait = FALSE)
             else system(command = paste(player, tempname), wait = FALSE)
             if(page.length<5) {
                bins <- 1
                len.out <- 40
             } else if(wl>512 && ovlp<= 50) {
                bins <- 2
                len.out <- 60
             } else if(ovlp>50) {
                bins <- 6
                len.out <- 0
             } else {
                bins <- 3            
                len.out <- 80
             }
             iter <- round(seq(1, step[['tb']]-bins, length.out = len.out))
             if(channel != 'both') {
                for(j in iter) {
                   t1 <- Sys.time()
                   old.col <- step[['amp']][, j:(j+bins-1)]
                   step[['amp']][, j:(j+bins-1)] <- max(step[['amp']])
                   image(x = step[['whicht']], y = step[['whichf']], t(step[['amp']]), col = spec.col, useRaster = TRUE, add = TRUE)
                   delta.t <- Sys.time()-t1
                   Sys.sleep(max(0, t.wave/(len.out+2) - as.numeric(delta.t)))
                   step[['amp']][, j:(j+bins-1)] <- old.col                  
                }
             } else { # Scroll bar in right channel spectrogram only
                for(j in iter) {
                   t1 <- Sys.time()
                   old.col <- step[['ampR']][, j:(j+bins-1)]
                   step[['ampR']][, j:(j+bins-1)] <- max(step[['ampR']])
                   image(x = step[['whicht']], y = step[['whichf']], t(step[['ampR']]), col = spec.col, useRaster = TRUE, add = TRUE)
                   delta.t <- Sys.time()-t1
                   Sys.sleep(max(0, t.wave/(len.out+2) - as.numeric(delta.t)))
                   step[['ampR']][, j:(j+bins-1)] <- old.col
                }
             }   
             # Remove wav file
             file.remove('temp.wav')
          } else if(x != "" && x == 'z') {
             page.length <- page.length/2
          } else if(x != "" && x == 'x') {
             page.length <- page.length*2
          } else if(x != "" && x == 's') {
             if(inherits(clip, 'Wave')) {
                save.dir <- paste(output.dir, '/Exerpt', sep = "")
             } else {
                f.name <- strsplit(clip, '/')[[1]][length(strsplit(clip, '/')[[1]])]
                f.name <- strsplit(f.name, '\\.')[[1]][1]
#                if(output.dir == getwd()) {
                   save.dir <- paste(output.dir, '/', f.name, sep = "")
#                } else {
#                   save.dir <- f.name
#                }
             }
             tuneR::writeWave(object = wave, filename = paste(save.dir, '_', start.time, '-', page.end, '.wav', sep = ""))
             cat('\nFile saved to:', paste('"', save.dir, '_', start.time, '-', page.end, '.wav"\n\n', sep = ""))
          } else if(x != "" && x == 'c') {# change spectro parameters 
             cat("Enter new spectrogram parameter.\nCurrent parameters:\n  start.time = ", start.time, "\n  units = ", units, "\n  frq.lim = c(", frq.lim[1], ",", frq.lim[2], ")\n  wl = ", wl, "\n  ovlp = ", ovlp, "\n  output.dir = ", output.dir, "\n  page.ovlp = ", page.ovlp, "\n  player = ", player, "\nor press 'c' to cancel\n", sep = "")
             param <- readLines(n = 1)
             eval(parse(text = param))
          } else if(x != "" && x == 'i') {# identify amplitude
             cat('Left click at upper left corner of selection, right click twice to exit\n')
             tl <- locator(1, type = "p", pch = 3)         
             cat('Left click at lower right corner of selection, right click once to exit\n')
             lr <- locator(1)
             if(length(tl) != 0 && length(lr)>0) {
                 rect(tl$x, lr$y, lr$x, tl$y)
                 dim.amp <- dim(step[['amp']])
                 sel.rows <- which(1:dim.amp[1]>= lr$y & 1:dim.amp[1]<= tl$y)
                 sel.cols <- which(1:dim.amp[2]>= tl$x & 1:dim.amp[2]<= lr$x)
                 sel <- step[['amp']][sel.rows, sel.cols]
                 cat('RMS amp =', mean(sel), '\n')
             }
          } else if(x != "" && x == 'a') {# annotation: experimental!
          	 a.mode <- TRUE
             cat('Left click at upper left corner of selection, right click twice to exit\n')
             tl <- locator(1, type = "p", pch = 3)         
             cat('Left click at lower right corner of selection, right click once to exit\n')
             lr <- locator(1)
             if(length(tl) != 0 && length(lr)>0) {
                 rect(tl$x, lr$y, lr$x, tl$y)
                 cat('Add name:\n')
                 newtxt <- readLines(n = 1)
                 if(newtxt == "" && is.na(txt)) {cat("First annotation should be named; name recorded as NA.\n")
                 } else if(newtxt != "") txt <- newtxt
                 text(x = tl$x+(lr$x-tl$x)/2, y = tl$y, labels = txt, pos = 3)
                 anno.one <- data.frame("start.time" = tl$x, "end.time" = lr$x, "min.frq" = lr$y, "max.frq" = tl$y, "name" = txt)
                 anno.mat <- rbind(anno.mat, anno.one)
#                 anno.spec <- data.frame("start.time" = round(tl$x*step[['t']]+start.time, 3), "end.time" = round(lr$x*step[['t']]+start.time, 3), "min.frq" = round(lr$y*step[['f']]+frq.lim[1], 4), "max.frq" = round(tl$y*step[['f']]+frq.lim[1], 4), "name" = txt)
                 anno.spec <- data.frame("start.time" = round(tl$x*step[['t']]+start.time, 3), "end.time" = round(lr$x*step[['t']]+start.time, 3), "min.frq" = round(lr$y*step[['f']], 4), "max.frq" = round(tl$y*step[['f']], 4), "name" = txt)
                 anno.dat <- rbind(anno.dat, anno.spec)
             } else a.mode <- FALSE 
          } else if(x != "" && x == 'd') {# delete annotations
             cat('Left click at upper left corner of selection to delete (right click twice to cancel)\n')
             tl <- locator(1, type = "p", pch = 3)         
             cat('Left click at lower right corner of selection to delete (right click once to cancel)\n')
             lr <- locator(1)
             if(length(tl) != 0 && length(lr)>0) {
                 rect(tl$x, lr$y, lr$x, tl$y)
                 cat('Delete all annotations in the box? (Y/n)\n')
                 del.anno <- readLines(n = 1)
                 if(del.anno == "" || del.anno == 'y') {
#                    anno.mat[anno.mat["start.time"]>= tl$x & anno.mat["end.time"]<= lr$x & anno.mat["min.frq"]>= lr$y & anno.mat["max.frq"]<= tl$y, ] <- NA
#                    anno.mat <- anno.mat[!is.na(anno.mat['start.time']), ]
#                    anno.spec[anno.spec["start.time"]>= round(tl$x*step[['t']]+start.time, 3) & anno.spec["end.time"]<= round(lr$x*step[['t']]+start.time, 3) & anno.spec["min.frq"]>= round(lr$y*step[['f']], 4) & anno.spec["max.frq"]<= round(tl$y*step[['f']], 4), ] <- NA
#                    anno.spec <- anno.spec[!is.na(anno.spec['start.time']), ]
                    anno.dat[anno.dat["start.time"]>= round(tl$x*step[['t']]+start.time, 3) & anno.dat["end.time"]<= round(lr$x*step[['t']]+start.time, 3) & anno.dat["min.frq"]>= round(lr$y*step[['f']], 4) & anno.dat["max.frq"]<= round(tl$y*step[['f']], 4), ] <- NA
                    anno.dat <- anno.dat[!is.na(anno.dat['start.time']), ]
                }
             } else cat("Deletion canceled.")             
          } else if(x != "" && x == 'q') {# quit, and offer to save the annotation file
             if(annotate && nrow(anno.dat)>0) {
                if(!missing(anno)) {
                    cat("Save annotations with same file name (possibly different output.dir)? (Y/n)\n")
                    saveq <- tolower(readLines(n = 1))
                    if(saveq == "" || saveq == "y") {
                        anno.dat <- anno.dat[order(anno.dat[, 'start.time']), ]
                	    write.csv(anno.dat, paste0(output.dir, "/", anno), row.names = FALSE)
                	    cat("Saved.\n")
                	} else {
                	    cat("File name for annotations (include '.csv'):\n")
                        file.name <- readLines(n = 1)
                        if(file.name != "") {
                            anno.dat <- anno.dat[order(anno.dat[, 'start.time']), ]
                	        write.csv(anno.dat, paste0(output.dir, "/", file.name), row.names = FALSE)
                	        cat("Saved.\n")
                	        file.remove('TMPannotations.csv')
                        } else cat("Annotations not saved.  BUT they are in 'TMPannotations.csv' until written over.\n")
                    }
                } else {
                	    cat("File name for annotations (include '.csv'):\n")
                        file.name <- readLines(n = 1)
                        if(file.name != "") {
                            anno.dat <- anno.dat[order(anno.dat[, 'start.time']), ]
                	        write.csv(anno.dat, paste0(output.dir, "/", file.name), row.names = FALSE)
                	        cat("Saved.\n")
                	        file.remove('TMPannotations.csv')
                        } else cat("Annotations not saved.  BUT they are in 'TMPannotations.csv' until written over.\n")
                    }
             if(exists('anno.dat')) return(invisible(anno.dat))
             }
             start.time <- header$samples/header$sample.rate
             cat('Quitting...\n')
    #         dev.off()
          } # else if(x == "") cat('\nNo selection made.\n\n')
          if(annotate && exists('anno.spec') && nrow(anno.dat)>0) write.csv(anno.dat, 'TMPannotations.csv', row.names = FALSE)
       }
     }
#   par(mai = oldmai)
}

      
  
  
  
