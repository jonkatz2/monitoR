---
layout: default
title : Annotating Spectrograms
group: navigation
---  


## Making Binary Point Templates
### Get clip, write to file

```r
data(btnw)
tuneR::writeWave(btnw, 'btnw.wav')
```

### Change amp.cutoff

```r
template <- makeBinTemplate('btnw.wav', amp.cutoff = -45)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-2.png)

```r
template <- makeBinTemplate('btnw.wav', amp.cutoff = -25)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-3.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-4.png)

### Change time limits

```r
template <- makeBinTemplate('btnw.wav', t.lim = c(0.75, 2.25), amp.cutoff = -35)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-2.png)

### Change frq limits

```r
template <- makeBinTemplate('btnw.wav', frq.lim = c(3, 7), amp.cutoff = -35)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-2.png)

### Change buffer

```r
template <- makeBinTemplate('btnw.wav', buffer=4, amp.cutoff = -35)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-2.png)

### Change density

```r
template <- makeBinTemplate('btnw.wav', dens=0.4, amp.cutoff = -35)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-2.png)

### Change FFT params

```r
template <- makeBinTemplate('btnw.wav', wl = 1024, ovlp = 75, amp.cutoff = -35)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

```
## 
## Automatic point selection.
## 
## Done.
```

```r
plot(template)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-2.png)

### Intersection of two clips
<a href="assets/makingBinTemplates/btnw2.wav">(download the second clip)</a>

```r
btnw_2 <- c('btnw.wav', 'btnw2.wav')
```

```r
viewSpec(btnw_2[1])
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png)

```r
viewSpec(btnw_2[2])
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-2.png)

```r
template <- makeBinTemplate(btnw_2, t.lim = list(c(0.75, 2.25),c(1.5, 3.5)), frq.lim = c(3, 8), amp.cutoff = -35)
```
```
## Interactive clip alignment.
## Enter l, ll, ll, etc. for left shift, 
## r, rr, rrr, etc. for right shift, 
## or Enter to continue.
```
![](img/intersectBTNW.png)
```
ll
lll
l
```
![](img/intersectBTNW2.png)


![](img/intersectBTNW3.png)


```r
template <- readBinTemplates('intersect.bt')
```

```r
plot(template)
```

```
## Warning in min(x): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x): no non-missing arguments to max; returning -Inf
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png)
