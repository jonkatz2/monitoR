# For cutting a wave object down to specified time limits

cutWave <-
function(
  wave,       # Wave object to be cut
  from = NULL,  # Initial time to trim to (s)
  to = NULL     # Final time to trim to (s)
) {

  if(is.null(from)) from <- 0
  if(is.null(to)) to <- length(wave@left)/wave@samp.rate

  # Check for from or to beyond original length
  dur <- length(wave@left)/wave@samp.rate
  # NTS: Should next line be a warning?
  if(from > dur | to > dur) stop('Argument `from` or `to` is greater than original duration ', signif(dur, 5), ' s. Reduce value and try again')

  i.from <- floor(from*wave@samp.rate)
  i.to <- ceiling(to*wave@samp.rate)

  wave@left <- wave@left[i.from:i.to]
  if(wave@stereo) wave@right <- wave@right[i.from:i.to]

  return(wave)
}
