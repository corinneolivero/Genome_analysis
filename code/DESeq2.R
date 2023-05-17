
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("apeglm")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("Rsubread")
library(Rsubread)

BiocManager::install("IHW")
BiocManager::install("vsn")
BiocManager::install("pheatmap")

# Load libraries
library(data.table)
library(DESeq2)
library(ggplot2)
library(reshape2)
library(dplyr)


directory <- "C:/Users/corin/OneDrive - Uppsala universitet/Dokument/Åk 4/Genomanalys/data"
culture <- "C:/Users/corin/OneDrive - Uppsala universitet/Dokument/Åk 4/Genomanalys/culture.csv"

sampleFiles <- grep("ERR",list.files(directory),value=TRUE)
sampleCondition <- read.csv(culture, sep=",")$type
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)
ddsHTSeq

dds <- DESeq(ddsHTSeq)
res <- results(dds)
res

res <- results(dds, name = "condition_Mineral_vs_Continuous")
res <- results(dds, contrast = c("condition", "Continuous", "Mineral"))
resLFC <- lfcShrink(dds, coef="condition_Mineral_vs_Continuous", type="apeglm")


resOrdered <- res[order(res$pvalue),]
summary(res)
sum(res$padj < 0.1, na.rm=TRUE)

res05 <- results(dds, alpha=0.05)
summary(res05)
sum(res05$padj < 0.05, na.rm=TRUE)

keep <- rowSums(counts(dds)) >= 100
resultsNames(dds)
reslfc = lfcShrink(dds, coef = "condition_Mineral_vs_Continuous", type = "apeglm")
summaryy <- summary(reslfc)
write.csv(summaryy, "resulfc_summary.csv" , row.names=TRUE)

resOrdered_l2fc <- res[order(abs(res$log2FoldChange), decreasing = TRUE),]

vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)
ntd <- normTransform(dds)

meanSdPlot(assay(rld))
meanSdPlot(assay(ntd))
meanSdPlot(assay(vsd))

pcaData <- plotPCA(vsd, intgroup=c("condition", "sizeFactor"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=condition, shape=type)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed()
plotPCA(vsd, intgroup=c("condition", "sizeFactor"))

plotMA(res, ylim=c(-2,2))


sampleDists <- dist(t(assay(vsd)))
library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condition, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)


significant <- rownames(resOrdered_l2fc[1:20, ])

colData(dds)
dds2 <- vst(dds)


colData(dds2)$sizeFactor <- c("29", "30", "31", "32", "33")
colnames(colData(dds2)) <- c("condition", "sample name")
df <- as.data.frame(colData(dds2)[,c("condition", "sample name")])
pheatmap(assay(dds2)[rownames(dds2) %in% significant, ], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df)

