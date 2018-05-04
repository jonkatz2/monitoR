---
layout: default
title : corTemplate examples
group: navigation
---  

## Making Spectrogram Cross-correlation Templates
These examples explore arguments beyond `select`. To see examples with `select` <a href="makingCorTemplates.html" target="_blank">read the longer article.</a>



### Get clip, write to file

```r
data(btnw)
tuneR::writeWave(btnw, 'btnw.wav')
```

### Automatic point selection 
Automatic is the default because it does not require interactivity and allows the package vignette and examples to build. In general use it is unlikely that users will build the most effective templates with the "auto" option.  



```r
template <- makeCorTemplate('btnw.wav')
plot(template)
```

![plot of chunk example1_2](figure/example1_2-1.png)![plot of chunk example1_2](figure/example1_2-2.png)

### Change select to 'rectangle'

```r
template <- makeCorTemplate('btnw.wav', select='rectangle')
```
![](img/cor_rect.png)![](img/cor_rect_plot.png)


### Change select to 'cell'

```r
template <- makeCorTemplate('btnw.wav', select='cell')
```
![](img/cor_cell.png)![](img/cor_cell_plot.png)



### Change time limits

```r
template <- makeCorTemplate('btnw.wav', t.lim = c(0.75, 2.25))
plot(template)
```

![plot of chunk corExample2](figure/corExample2-1.png)![plot of chunk corExample2](figure/corExample2-2.png)

### Change frequency limits

```r
template <- makeCorTemplate('btnw.wav', frq.lim = c(3, 7))
plot(template)
```

![plot of chunk corExample3](figure/corExample3-1.png)![plot of chunk corExample3](figure/corExample3-2.png)

### Change selection density

```r
template <- makeCorTemplate('btnw.wav', dens = 0.4)
plot(template)
```

![plot of chunk corExample5](figure/corExample5-1.png)![plot of chunk corExample5](figure/corExample5-2.png)

### Change FFT parameters

```r
template <- makeCorTemplate('btnw.wav', wl = 1024, ovlp = 75)
plot(template)
```

![plot of chunk corExample6](figure/corExample6-1.png)![plot of chunk corExample6](figure/corExample6-2.png)

### Change template name

```r
template <- makeCorTemplate('btnw.wav', name='btnw_typeB_5kHz')
plot(template)
```

![plot of chunk corExample6_1](figure/corExample6_1-1.png)![plot of chunk corExample6_1](figure/corExample6_1-2.png)

### Combine templates

```r
template1 <- makeCorTemplate('btnw.wav', name='btnw_typeB_5kHz')
```

```r
template2 <- makeCorTemplate('btnw2.wav', name='btnw_typeB_5.8kHz')
```

```r
templates <- combineCorTemplates(template1, template2)
plot(templates, ask=FALSE)
```

![plot of chunk corExample9_1](figure/corExample9_1-1.png)![plot of chunk corExample9_1](figure/corExample9_1-2.png)


