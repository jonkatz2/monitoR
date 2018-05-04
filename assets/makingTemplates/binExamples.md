---
layout: default
title : binTemplate examples
group: navigation
---  


## Making Binary Point Templates
These examples explore the function arguments. You can also <a href="makingBinTemplates.html" target="_blank">read the article.</a>



### Get clip, write to file

```r
data(btnw)
tuneR::writeWave(btnw, 'btnw.wav')
```

### Change amp.cutoff

```r
template <- makeBinTemplate('btnw.wav', amp.cutoff = -45)
plot(template)
```

![plot of chunk example1](figure/example1-1.png)![plot of chunk example1](figure/example1-2.png)

```r
template <- makeBinTemplate('btnw.wav', amp.cutoff = -25)
plot(template)
```

![plot of chunk example1_1](figure/example1_1-1.png)![plot of chunk example1_1](figure/example1_1-2.png)

### Automatic point selection 
Automatic is the default because it does not require interactivity and allows the package vignette and examples to build. In general use it is unlikely that users will build the most effective templates with the "auto" option.  



```r
template <- makeBinTemplate('btnw.wav', amp.cutoff=-35)
plot(template)
```

![plot of chunk example1_2](figure/example1_2-1.png)![plot of chunk example1_2](figure/example1_2-2.png)

### Change select to 'rectangle'

```r
template <- makeBinTemplate('btnw.wav', select='rectangle', amp.cutoff=-35)
```
![](img/t1_rect.png)![](img/t1_rect_plot.png)


### Change select to 'cell'

```r
template <- makeBinTemplate('btnw.wav', select='cell', amp.cutoff=-35)
```
![](img/t1_cell.png)![](img/t1_cell_plot.png)


### Change time limits

```r
template <- makeBinTemplate('btnw.wav', t.lim = c(0.75, 2.25), amp.cutoff = -35)
plot(template)
```

![plot of chunk example2](figure/example2-1.png)![plot of chunk example2](figure/example2-2.png)

### Change frequency limits

```r
template <- makeBinTemplate('btnw.wav', frq.lim = c(3, 7), amp.cutoff = -35)
plot(template)
```

![plot of chunk example3](figure/example3-1.png)![plot of chunk example3](figure/example3-2.png)

### Change buffer

```r
template <- makeBinTemplate('btnw.wav', buffer = 4, amp.cutoff = -35)
plot(template)
```

![plot of chunk example4](figure/example4-1.png)![plot of chunk example4](figure/example4-2.png)

### Change selection density

```r
template <- makeBinTemplate('btnw.wav', dens = 0.4, amp.cutoff = -35)
plot(template)
```

![plot of chunk example5](figure/example5-1.png)![plot of chunk example5](figure/example5-2.png)

### Change FFT parameters

```r
template <- makeBinTemplate('btnw.wav', wl = 1024, ovlp = 75, amp.cutoff = -35)
plot(template)
```

![plot of chunk example6](figure/example6-1.png)![plot of chunk example6](figure/example6-2.png)

### Change template name

```r
template <- makeBinTemplate('btnw.wav', name='btnw_typeB_5kHz', amp.cutoff = -35)
plot(template)
```

![plot of chunk example6_1](figure/example6_1-1.png)![plot of chunk example6_1](figure/example6_1-2.png)

### Intersection of two clips
<a href="https://github.com/jonkatz2/monitoR/blob/gh-pages/assets/makingTemplates/btnw2.wav?raw=true">(download the second clip)</a>


```r
btnw_2 <- c('btnw.wav', 'btnw2.wav')
```

```r
viewSpec(btnw_2[1]) # The clip that comes with the package
viewSpec(btnw_2[2]) # Another song, ~800Hz higher frequency
```

![plot of chunk example7](figure/example7-1.png)![plot of chunk example7](figure/example7-2.png)

```r
template <- makeBinTemplate(btnw_2, t.lim = list(c(0.75, 2.25),c(1.5, 3.5)), frq.lim = c(3, 8), amp.cutoff = -35)
```
![](img/intersectBTNW.png)
```
## Interactive clip alignment.
## Enter l, ll, ll, etc. for left shift, 
## r, rr, rrr, etc. for right shift, 
## or Enter to continue.
```
![](img/intersectBTNW2.png)
```
ll
lll
l
```
![](img/intersectBTNW3.png)




```r
plot(template)
```

![plot of chunk example8](figure/example8-1.png)

### Combine templates

```r
template1 <- makeBinTemplate('btnw.wav', name='btnw_typeB_5kHz', amp.cutoff = -35)
```

```r
template2 <- makeBinTemplate('btnw2.wav', name='btnw_typeB_5.8kHz', amp.cutoff = -35)
```

```r
templates <- combineBinTemplates(template1, template2)
plot(templates, ask=FALSE)
```

![plot of chunk example9_1](figure/example9_1-1.png)![plot of chunk example9_1](figure/example9_1-2.png)


