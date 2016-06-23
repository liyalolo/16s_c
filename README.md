# 16s_c


第二步骤 Frags_QC
fq_to_fa
Usearch/usearch7.0.1001_i86linux32 -uchime_ref seqs.fna -db /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/database/16S/gold.fa
fa_to_fq
ng_qc: q20, q30, GC 结果为空

第三步，makeOTU
1. OTU代表序列，聚类，比对
Usearch/usearch7.0.1001_i86linux32 -derep_prefix
Usearch/usearch7.0.1001_i86linux32 -sortbysize
Usearch/usearch7.0.1001_i86linux32 -cluster_otus
Usearch/usearch7.0.1001_i86linux32 -usearch_global


2.Qiime物种注释
assign_taxonomy.py -i all_rep_set.fasta -m rdp   
#green genes, gg_otus_4feb2011.tgz, 141M
rm_Unclassified_mitochondria_Chloroplast.pl 
make_otu_table.py -o otu_table.biom
otu_tab.pl map.uc > otu_table.txt
sort_otu_table.py -i otu_table_even.biom -o sorted_otu_table.biom


3.系统发育树
align_seqs.py
filter_alignment.py
make_phylogeny.py


4.beta diversity
jackknifed_beta_diversity.py  sorted_otu_table.biom  rep_set.tre
make_bootstrapped_tree.py -m UPGMA/weighted_unifrac/sorted_otu_table_upgma.tre
树状图，bray距离，unifrac距离
draw_tree.pl  UPGMA/unweighted_unifrac/sorted_otu_table_upgma.tre pick.otu_table.g30.relative.mat >UPGMA.UnW.tree.g.svg
tree_heatmap.pl ./pick.otu_table.relative.mat

5.alpha diversity
multiple_rarefactions.py sorted_otu_table.biom
alpha_index.py 
SAC.plot.pl
PCoA.py pick.bray_curtis_sorted_otu_table.txt
NMDS.py
DCA.py
Heatmap.py
Venn.py
Correlation.py 

分组计算alpha diversity/pca/pcoa
sample_pick3.py

6.MetaStat/LEfSe
plot_lefse.pl
metastat/MetaStat1.3.R 
ANOSIM/MRPP

7. PICRUST分析，python scripts provided
pick_closed_reference_otus.py -i all_rep_sest.fa -r gg_13_5_otus -o OTUs
#green genes 比对
./otu_comb.py -i otu_table.even.txt -o otu_table.even.ref.txt
（1）normalize_by_copy_number.py -i otu_table.even.ref.biom
（2）predict_metagenomes.py  -f -t ko -i otu_table.even.ref.norm.biom  -o otu_table.even.metagenome_predictions.ko.tab

（2.1）categorize_by_function.py
convert_percent.py -i otu_table.even.metagenome_predictions.ko.tab
categorize_by_function.py 
(2.2) metagenome_contributions.py otu_table.even.ref.norm.biom -o Carbon_metabolism.ko_metagenome_contributions.tab
(2.3) 统计分析
qiime: alpha, beta diversity
STAM: PCA, barplot, per sample/by group
HUManN: LEfSe, GraPhlAn

画柱形图：
/System/Pipline/DNA/DNA_Micro/MetaGenome_pipeline/MetaGenome_pipeline_V2.2/lib/00.Commbin/cluster/cluster.pl


选取分组样品sample_pick.py







