args <- commandArgs(T)
out <- args[1]
df <- read.table(paste0(out,'annotation_count'))
colnames(df) <- c('read_count','long_anno')
meta <- readRDS(paste0(out,'annotation_metadata.rds'))
df <- merge(df,meta,by = 'long_anno')
df <- df[order(df$read_count,decreasing = T),]
write.table(df,paste0(out,'rRNA_count.tsv'),
            row.names = F,quote = F,sep = '\t')
