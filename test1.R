library(bfastSpatial)
?tura
data(tura)
class(tura)
plot(tura)
tura@layers
tura@extent
tura@z
tura@rotated


a = countObs(tura)
plot(a)
summary(a)


plot(summaryBrick(tura,mean, na.rm = T))
plot(annualSummary(tura, fun=median, na.rm=TRUE))

targcell <- 3492

Rprof(NULL)
Rprof(filename="tura_prof_pixel_1.out",interval=0.02,line.profiling = F)
bfm <- bfmPixel(tura, cell=targcell, start=c(2009, 1))
Rprof(NULL)
res = summaryRprof("tura_prof_pixel_1.out")
res$by.total
res$by.self

# inspect and plot the $bfm output
bfm$bfm
plot(bfm$bfm)


Rprof(NULL)
Rprof(filename="tura_prof_stack_1.out",interval=0.5,line.profiling = F)
bfmSpatial(tura, start=c(2009, 1), order=1) # takes up to some hours
Rprof(NULL)
res = summaryRprof("tura_prof_stack_1.out")
res$by.total
res$by.self


p = profvis({
  x = bfmSpatial(tura, start=c(2009, 1), order=1) # takes up to some hours
}, interval = 0.2)





