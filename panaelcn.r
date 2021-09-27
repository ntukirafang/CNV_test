library(panelcn.mops)
data(panelcn.mops)
setwd("/mnt/CNV_test/CNV_test/")
directory <- "/mnt/CNV_test/CNV_test/"
out_dir <- "/mnt/CNV_test/CNV_test/"
bed <- grep("test.bed",list.files(directory),value=TRUE)
countWindows <- getWindows(bed)
control.bam <- grep("control.bam",list.files(directory),value=TRUE)
control <- countBamListInGRanges(countWindows = countWindows, bam.files = control.bam, read.width = 150)
sample.bam <- grep("test.bam",list.files(directory),value=TRUE)
test <- countBamListInGRanges(countWindows = countWindows, bam.files = sample.bam, read.width = 150)
gene <- readLines('gene_name')
selectedGenes <- c(gene)
XandCB <- test
elementMetadata(XandCB) <- cbind(elementMetadata(XandCB),
                                 elementMetadata(control))
resultlist <- runPanelcnMops(XandCB,
                             testiv = 1:ncol(elementMetadata(test)),
                             countWindows = countWindows,
                             selectedGenes = selectedGenes)
sampleNames <- colnames(elementMetadata(test))
resulttable <- createResultTable(resultlist = resultlist, XandCB = XandCB,
                                 countWindows = countWindows,
                                 selectedGenes = selectedGenes,
                                 sampleNames = sampleNames)
write.csv(as.data.frame(resulttable), file=paste(out_dir,"resulttable.csv"))
last_appear_line <- readLines('last_line')
compare_A1BG <- integerCopyNumber(resultlist[[1]])[1:last_appear_line]
write.csv(as.data.frame(compare_A1BG), file=paste(out_dir,"compare.csv"))
