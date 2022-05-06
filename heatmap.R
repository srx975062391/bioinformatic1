#----1. 参数 Parameters#----

#----1.1 功能描述 Function description#----

# 程序功能：beta多样性聚类热图
# Functions: beta -heatmap

options(warn = -1) # Turn off warning


## 设置输入输出文件和参数

# 修改下面`default=`后面的文件和参数。
#
# 输入文件为距离文件文件文件(如unweighted_unifrac.txt)+分组信息(group.txt)
#
# 输入文件"-i", "--input"，unweighted_unifrac.txt; 计算好的距离文件，也可使用weighted_unifrac.txt
# 分组文件"-g","--group"，分组文件;group.txt
#
# 图片宽"-w", "--width"，默认5，根据图像布局可适当增大或缩小
#
# 图片高"-e", "--height"，默认5，根据图像布局可适当增大或缩小
#
# 分组列名"-o", "--output"，输出目录，默认同输入+.unweighted_unifra_heatmap.pdf；
#

#----1.2 参数 Parameters#----

# 解析参数-h显示帮助信息
library("optparse")
if (TRUE){
  option_list = list(
    make_option(c("-i", "--input"), type="character", default="unweighted_unifrac.txt",
                help="Beta diversity distance matrix [default %default]"),
    make_option(c("-n", "--index"), type="character", default="unweighted_unifrac",
                help="index name [default %default]"),
    make_option(c("-g", "--group"), type="character", default="group.txt",
                help="Group file [default %default]"),
    make_option(c("-o", "--output"), type="character", default="",
                help="Output directory; name according to input [default %default]"),
    make_option(c("-w", "--width"), type="numeric", default=5,
                help="Figure width in mm [default %default]"),
    make_option(c("-e", "--height"), type="numeric", default=5,
                help="Figure heidth in mm [default %default]")
  )
  opts = parse_args(OptionParser(option_list=option_list))
  # suppressWarnings(dir.create(opts$output))
}
# 设置输出文件缺省值，如果为空，则为输入+alpha_boxplot.pdf
#if(opts$output==""){opts$output=paste0(opts$input,"unweighted_unifra_heatmap.pdf")}
#opts$output = gsub(".txt","",opts$output)
#suppressWarnings(dir.create(dirname(opts$output), showWarnings = F))

#----1.3. 加载包 Load packages#----
library(NMF)
#----2. 读取文件 Read files#----
infile = read.table(opts$input,header=TRUE,row.names=1,sep="\t",check.names=F,quote="")
Group = read.table(opts$group,header=F,row.names=1,check.names=F,quote="",na.string="")
infile2 = infile[rownames(Group),rownames(Group)]
group_names = unique(as.vector(Group[,1]))
group_names
group_num = length(group_names)
colors = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3")
group_colors = colors[1:group_num]
sample_colors = group_colors[as.numeric(Group$V2)]

#----2.1 计算 Stat#----
annotation <- data.frame(Var1 = factor(Group[,1], levels=group_names))
annotation
Var1 = group_colors
names(Var1) = group_names
cols = list(Var1 = Var1)
cols
par(mar=c(7,6,3,3))
i<-ncol(infile2)

width=16.4
height=15.5
cexCol=1.88-i*0.006
cexRow=cexCol
cexRow
#----3.1 绘图 Plotting#----

aheatmap(infile2,
         Rowv=TRUE,
         Colv=TRUE,
         fontsize=10,
         distfun=as.dist(infile2),
         hclustfun="complete",
         annCol=annotation,
         width=width,height=height,
         cexRow=cexRow,cexCol=cexCol,
         annColors=cols,
         main="Unweighted Unifrac",
         filename = "unweighted_unifra_heatmap.pdf"
         )
dev.off()


