# bioinformatic1
venn 图
```
Rscript  venn.R -i data_venn.txt
```
pcoa 图
```
Rscript   pcoa_circle.R -i  unweighted_unifrac.txt  -g  group.txt  -o  pcoa_circle.pdf
```
Alpha 多样性图形
```
Rscript   alpha_box.R -i PD_whole_tree.txt   -o  PD_whole_tree.pdf
```
Beta 多样性聚类热图
```
Rscript   heatmap.R -i  unweighted_unifrac.txt -g  group.txt -o  unweighted_unifrac_heatmap.pdf
```
差异柱状图
```
Rscript diff_box.R -i  diff_profile.txt  -g group.txt -o diff_boxplot.pdf
```
Beta多样性Anosim分析
```
Rscript anosim.R -i  unweighted_unifrac.txt -g  group.txt -o  unweighted_unifrac_anosim.pdf
```
