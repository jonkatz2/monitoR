---
layout: default
title : Annotating Spectrograms
group: navigation
---  





# Making Templates
Most of the template creation process is covered in the vignette (Quick Start Guide), but we can cover it once more here. Making templates is possibly the single most subjective aspect of automated detection, so users attempting to start a monitoring program will probably spend many hours making and testing templates.  

The first step is to select a sound clip that we will use. A sound clip can be exported from `viewSpec()`, downloaded from a website, or recorded specifically for use as a template. When selecting a template and developing performance expectations it will be useful to understand how the template is used by the scoring functions.  

Templates are evaluated at all time bins in the survey (left-to-right), but they are not evaluated at all frequency bins (up and down). Therefore if the target sound is always emitted within the same frequency band it may be possible to detect it reliably with a single template. On the other hand, if it is a stereotyped sound emitted with the same pattern but within different frequency bands, a template may need to be created for each frequency band.  

A sound clip that will be used for a template must be recorded at the same sampling rate as the surveys.  

For this example we will use the recordings that come with the package. The package contains two template matching functions, but they do not use the same template structure. To some extent they employ the same arguments, so we will pay careful attention to how the binary point matching method differs from the spectrogram cross-correlation method.  

<div class="row">
<div class="col-md-6">
<h3>Binary point matching (this page):</h3>
<ol>  
  <li> Three methods of selecting points in a template </li>  
  <li> Template consists of "on" and "off" point locations </li>  
  <li> Scoring is difference between on and off points (signal to noise difference) in the survey </li>  
</ol>
</div>
<div class="col-md-6">
<h3><a href="assets/makingTemplates/makingCorTemplates.html" target="_blank">Spectrogram cross-correlation:</a></h3>
<ol>  
  <li> Three methods of selecting points in a template </li>  
  <li> Template consists of only "points" and their locations </li>  
  <li> Scoring is based on correlation of amplitude values between the template and the survey </li>
</ol>  
</div>
</div>

First load the black-throated green warbler song included with the package.  

```r
library(monitoR)
data(btnw)
viewSpec(btnw)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

## Binary point matching templates
The three methods of selecting points in the template creation process are:  

  *  Automatic (default, "auto")  
  *  Rectangular area selection ("rectangle")  
  *  Individual point selection ("cell")  

### Automatic template creation 
Automatic is the default because it does not require interactivity and allows the package vignette and examples to build. In general use it is unlikely that users will build the most effective templates with the "auto" option.  




```r
t1_auto <- makeBinTemplate(btnw, frq.lim=c(2, 8.4), amp.cutoff=-34, name='t1_auto', write.wav=TRUE)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```
Printing the template yields a description of the contents of the template. The printed stats can be helpful when attempting to balance the number of "on" and "off" points. For example, too many "off" points relative to the number of "on" points may allow the template to accept (with higher-than-expected scores) signals that are not isolated within the designated "on" regions. This could yield excessive false positive detections.  


```r
t1_auto
```

```
## 
## Object of class "binTemplateList"
## 
## 	containing  1  templates
##         original.recording sample.rate lower.frequency upper.frequency
## t1_auto           btnw.wav       24000        2.015625        8.390625
##         duration on.points off.points score.cutoff
## t1_auto     2.97       708      18472           12
```

Plot the template to see how it fits on the original sound clip. To keep templates lightweight the original clip is not stored within the template but as a file path. When the clip is a wave object rather than a file path, the clip is saved to the working directory as long as the argument `write.wav=TRUE` (if `write.wav=FALSE`, the function will yield an error).  


```r
plot(t1_auto)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)

### Manual template creation 
The steps you will use in this process are:  

  1.  Amplitude cutoff selection (can be specified in the function call).  
  2.  "On" point selection.  
  3.  "Off" point selection.  

#### Amplitude cutoff selection
The "binary" part of binary point matching refers to step one of template creation, which sets an amplitude threshold for the song clip spectrogram. All values with an amplitude equal or greater than the threshold get a value of 1, and all values below the threshold get a value of 0. In the automatic template above we specified the amplitude threshold (`amp.cutoff=-34`) in the function call, but if you use the default value (`amp.cutoff="i"`) the first step of template creation will be to set the amplitude threshold interactively.   

Use between 1 and 5 "h" characters (pressing enter between entries --- `h` is a little, `hhhhh` is a lot) to raise the threshold, and between 1 and 5 "l" characters (again pressing enter between entries) to lower the threshold. This process will loop continuously allowing you to raise and lower the threshold as much as necessary. When you are satisfied press enter again to end the loop.  

The name that will be displayed in all detection output and some spectrogram parameters are specified in the function call as well.  


```r
t1_rect <- makeBinTemplate(btnw, frq.lim=c(2, 8.4), select='rect', name='t1_rect', write.wav=TRUE)
```
```
## Interactive amplitude cutoff selection.
## Enter l, ll, ll, etc. for lower cutoff, 
## h, hh, hhh, etc. for higher cutoff, 
## or hit Enter to continue

## Current cutoff: -49
```

![](img/t1_rect_start.png)


```
## Current cutoff: -49
hhh

## Current cutoff: -43
hh

## Current cutoff: -40
hh

## Current cutoff: -37
hh

## Current cutoff: -34
```
![](img/t1_rect_setAmp.png)


#### "On" point selection

The interactive options require the user to select cells from an image plot of a spectrogram. The "cell" option adds a single point per click and is probably suited for templates with few points. The "rectangle" option collects all points between two clicks, which define the upper-left and lower-right corners or a rectangle.  

In this call we've used `select="rect"`, which is equivalent to `select="rectangle"`.  

Just as the amplitude selection was a continuous loop until broken by pressing enter without an entry, point selection is a continous loop until broken with a right click in the graphics device. Since we have a very clean recording of our call we can simply select all points with one large rectangle (start with the upper left corner, then select the lower right corner) and then right click to move on.  

This is possible because on point selection only selects cells with a value of 1.  

```
## Select upper left corner of "on" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "on" rectangle with a left click.

## Select upper left corner of "on" rectangle with a left click.
## Right click to continue.
```

![](img/t1_rect_onSel.png)


#### "Off" point selection

Off point selection is a bit more complicated because we will not use one big rectangle but multiple selections, starting with the upper left corner and then selecting the lower right corner for each selection.  

Off point selection only selects cells with a value of 0. If we want to select cells adjacent to the on points we can do that, or we could have opted for a buffer in the function call (default is `buffer=0`).   

```
## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.
```

![](img/t1_rect_off1.png)


```

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.

## Select lower right corner of "off" rectangle with a left click.

## Select upper left corner of "off" rectangle with a left click.
## Right click to continue.
```
![](img/t1_rect_off2.png)

The signal component of this clip is only about 1 second long, but I've artificially extended the template duration to about 3 seconds by selecting some tiny off points at the edges. I did this because the peak detecting algorithm (in `findPeaks()`) will yield a value for each template duration in the survey. If you are planning to sort through the peaks (e.g. to identify false negatives at a score threshold), this may yield more manageable results since a 1 second long template will yield roughly 600 peaks in a survey, while a 3 second long template will yield about 200 peaks. The scoring algorithm (in function `binMatch()`) returns only the center time of each score, so I've taken some care to maintain the center of the template in the center of the signal component.  



```r
t1_rect
```

```
## 
## Object of class "binTemplateList"
## 
## 	containing  1  templates
##         original.recording sample.rate lower.frequency upper.frequency
## t1_rect           btnw.wav       24000        2.296875        8.109375
##         duration on.points off.points score.cutoff
## t1_rect      2.9       708       1525           12
```

```r
plot(t1_rect)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png)

After a template has been made, you may wish to:  

  *  Rename the template: use the assignment function `templateNames()<-`  
  *  Change the score cutoff: use the assignment function `templateCutoff()<-`  
  *  Add a comment (e.g. clip source, performance results, etc.): use the assignment function `templateComment()<-`  
  *  Move the clip location: use the assignment function `templatePath()<-`  
  *  Save the template to disk: use the function `writeBinTemplates()`  
  *  Combine it with others for use at the same time: use `combineBinTemplates()`  

























