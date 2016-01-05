library(bfastSpatial)

data(tura)


targcell <- 3492

Rprof(NULL)
Rprof(filename="tura_prof_pixel_1.out",interval=0.02,line.profiling = F)
bfm <- bfmPixel(tura, cell=targcell, start=c(2009, 1))
Rprof(NULL)
res = summaryRprof("tura_prof_pixel_1.out")
res$by.total
res$by.self

library(profvis)
p = profvis({
  bfm <- bfmPixel(tura, cell=targcell, start=c(2009, 1))
}, interval = 0.005)


p = profvis({
  bfm <- bfmPixel(tura, cell=targcell, start=c(1995, 1))
}, interval = 0.01)
p



Rprof(NULL)
Rprof(filename="tura_prof_stack_1.out",interval=0.5,line.profiling = F)
bfmSpatial(tura, start=c(2009, 1), order=1) # takes up to some hours
Rprof(NULL)
res = summaryRprof("tura_prof_stack_1.out")
res$by.total
res$by.self


tura.subset = crop(tura, extent(tura, 1, 20, 1, 20))
# Count non NAs
plot(summaryBrick(tura.subset, fun=function(x) {sum(!is.na(x))}))


library(profvis)
p = profvis({
  x = bfmSpatial(tura.subset, start=c(2009, 1), order=1) 
}, interval = 0.01)


Rprof(NULL)
Rprof(filename="tura.subset_prof_stack_1.out",interval=0.01,line.profiling = F)
bfmSpatial(tura.subset, start=c(2009, 1), order=1) 
Rprof(NULL)
res = summaryRprof("tura.subset_prof_stack_1.out")
res$by.total

res = summaryRprof("tura_prof_stack_1.out")
res$by.self

res$by.total["\"mefp\"",]$total.time

write.table(res$by.total[res$by.total$total.pct >= 1,], file = "res1.csv",sep = ";",quote=F)





Rprof(NULL)
Rprof(filename="tura.subset_reccusum_prof_stack_1.out",interval=0.01,line.profiling = F)
bfmSpatial(tura.subset, start=c(2009, 1), order=1, type="Rec-CUSUM") 
Rprof(NULL)
res = summaryRprof("tura.subset_reccusum_prof_stack_1.out")
res$by.total




library(lineprof)
library(shiny)
p = lineprof({
  x = bfmSpatial(tura.subset, start=c(2009, 1), order=1) 
}, interval = 0.01)
shine(p)


bfmSpatial()
bfastmonitor()
bfastts()
monitor()
efp()
bfast::hist
447.5/448 
9.76/15.58


38.5 / 771
39.5 / 771



library(igraph)
library(dataview)

v = vertices(c("bfmSpatial","bfastts","bfastmonitor","as.ts","bfastpp","history_roc", "mefp", "monitor", "predict"))


g = make_graph(c("bfmSpatial", "bfastts", 
                 "bfmSpatial", "bfastmonitor", 
                 "bfastts", "as.ts",
                 "bfastmonitor", "bfastpp",
                 "bfastmonitor", "history_roc",
                 "bfastmonitor", "mefp", 
                 "bfastmonitor", "monitor",
                 "bfastmonitor", "predict"))
plot.igraph(g, layout=layout_as_tree, vertex.color="white", vertex.label.color="black", edge.color="black", vertex.shape="crectangle", vertex.size = 100, vertex.size2=15)
