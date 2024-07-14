args <- commandArgs(T)
out <- args[1]
rRNA <- args[2]
min_length <- args[3]
meta <- readRDS(paste0(out,'annotation_metadata.rds'))
pos <- read.table(paste0(out,'reads_position'),stringsAsFactors = F)
# screen reads
tmp <- pos[pos$V1==meta[meta$annotation==rRNA,]$long_anno,]
tmp <- unique(tmp)
tmp <- tmp[(tmp$V3-tmp$V2)>min_length,]
tt <- tmp[sample(1:dim(tmp)[1],50),2:3]
colnames(tt) <- c('start','end')
# plot
pdf(paste0(out,rRNA,'_reads_plot.pdf'), width = 7.3, height = 5.5)
{ x = seq(0, 15000, 3e3)
  plot(x = x, y = rep(0, length(x)), type = "n", xlab = " ", ylab = " ", bty="n", axes = F)
  axis(3, at = seq(0, 15000, 3e3))
  #plot reference genome
  title('rDNA', line = 3)
  #18S CDS
  rect(xleft = 3657, xright = 5527, ybottom = 0.97, 
       ytop = 1.05, xlab = '', ylab = '',col = "red", border = 'white')
  text(x = (3657+5527)/2, y = 1.007, '18S')
  #5.8S CDS
  rect(xleft = 6623, xright = 6779, ybottom = 0.97, 
       ytop = 1.05, xlab = '', ylab = '',col = "red", border = 'white')
  text(x = (6623+6779)/2, y = 1.007, '5.8S')
  #28S CDS
  rect(xleft = 7935, xright = 12969, ybottom = 0.97, 
       ytop = 1.05, xlab = '', ylab = '',col = "red", border = 'white')
  text(x = (7935+12969)/2, y = 1.007, '28S')
  ybottom <- 0.9
  ytop <- 0.94
  for(i in 1:dim(tt)[1]){
    rect(xleft = tt$start[i], xright = tt$end[i], ybottom = ybottom, 
         ytop = ytop, xlab = '', ylab = '',col = "#f4592f", border = 'white')
    ytop <- ybottom - 0.02
    ybottom <- ytop-0.04
  }
  if(rRNA == '18S'){
    abline(v = 3657, lty = 'dashed')
    abline(v = 5527, lty = 'dashed')
  }
  if(rRNA == '5.8S'){
    abline(v = 6623, lty = 'dashed')
    abline(v = 6779, lty = 'dashed')
  }
  if(rRNA == '28S'){
    abline(v = 7935, lty = 'dashed')
    abline(v = 12969, lty = 'dashed')
  }
  text(x = 0.5, y = 0, paste0(rRNA,' reads'), srt = 90)
}
dev.off()
