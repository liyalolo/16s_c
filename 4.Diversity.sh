#Les't begining
#OTU_tree
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/jackknifed_beta_diversity.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//sorted_otu_table.biom -m /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/all.mf -t /Disk02/Project/Micro/hongzhifan/project/A334/03.Make_OTU/otu97/rep_set.tre -p /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/beta_params.txt -o ALLUPGMA -e 30158 >& ALLUPGMA.log
date > UPGMA.fin
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//otu_table.even.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.even.txt
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/make_otu_map.pl pick.otu_table.even.txt > otu_map_even.txt
make_otu_table.py -i otu_map_even.txt -t /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt -o otu_table_even.biom
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/sort_otu_table.py -i otu_table_even.biom -o sorted_otu_table.biom  -l ./group
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/jackknifed_beta_diversity.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree/sorted_otu_table.biom -m /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree/all.mf -t /Disk02/Project/Micro/hongzhifan/project/A334/03.Make_OTU/otu97/rep_set.tre -p /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/beta_params.txt -o UPGMA -e 30158 >& UPGMA.log
date > UPGMA.fin
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/get_table_head2.pl /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.p.relative.mat 15 > otu_table.p15.relative.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/get_table_head2.pl /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.g.relative.mat 30 > otu_table.g30.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i otu_table.p15.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.p15.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i otu_table.g30.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.g30.relative.mat
make_bootstrapped_tree.py -m UPGMA/unweighted_unifrac/sorted_otu_table_upgma.tre -s UPGMA/unweighted_unifrac/upgma_cmp/jackknife_support.txt -o UPGMA/unweighted_unifrac/unweighted_unifrac.pdf
/usr/bin/convert UPGMA/unweighted_unifrac/unweighted_unifrac.pdf UPGMA/unweighted_unifrac/unweighted_unifrac.png

perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/table_data_svg.pl --colors cyan-orange  UPGMA/unweighted_unifrac_sorted_otu_table.txt --symbol 'Beta Diversity' > beta_diversity.heatmap.UnW.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png beta_diversity.heatmap.UnW.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/unweighted_unifrac/sorted_otu_table_upgma.tre pick.otu_table.p15.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Phylum Level' --scal_title 'unweighted_unifrac Distance' -width 200 -type 3 > UPGMA.UnW.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/unweighted_unifrac/sorted_otu_table_upgma.tre pick.otu_table.g30.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Genus Level' --scal_title 'unweighted_unifrac Distance' -width 200 --height 400 -type 3 > UPGMA.UnW.tree.g.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.UnW.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.UnW.tree.g.svg
make_bootstrapped_tree.py -m UPGMA/weighted_unifrac/sorted_otu_table_upgma.tre -s UPGMA/weighted_unifrac/upgma_cmp/jackknife_support.txt -o UPGMA/weighted_unifrac/weighted_unifrac.pdf
/usr/bin/convert UPGMA/weighted_unifrac/weighted_unifrac.pdf UPGMA/weighted_unifrac/weighted_unifrac.png
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/table_data_svg.pl --colors cyan-orange  UPGMA/weighted_unifrac_sorted_otu_table.txt --symbol 'Beta Diversity' > beta_diversity.heatmap.W.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png beta_diversity.heatmap.W.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/weighted_unifrac/sorted_otu_table_upgma.tre pick.otu_table.p15.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Phylum Level' --scal_title 'weighted_unifrac Distance' -width 200 -type 3 > UPGMA.W.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/weighted_unifrac/sorted_otu_table_upgma.tre pick.otu_table.g30.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Genus Level' --scal_title 'weighted_unifrac Distance' -width 200 --height 400 -type 3 > UPGMA.W.tree.g.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.W.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.W.tree.g.svg
make_bootstrapped_tree.py -m UPGMA/bray_curtis/sorted_otu_table_upgma.tre -s UPGMA/bray_curtis/upgma_cmp/jackknife_support.txt -o UPGMA/bray_curtis/bray_curtis.pdf
/usr/bin/convert UPGMA/bray_curtis/bray_curtis.pdf UPGMA/bray_curtis/bray_curtis.png
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/table_data_svg.pl --colors cyan-orange  UPGMA/bray_curtis_sorted_otu_table.txt --symbol 'Beta Diversity' > beta_diversity.heatmap.BC.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png beta_diversity.heatmap.BC.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/bray_curtis/sorted_otu_table_upgma.tre pick.otu_table.p15.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Phylum Level' --scal_title 'bray_curtis Distance' -width 200 -type 3 > UPGMA.BC.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/draw_tree.pl --group ./group UPGMA/bray_curtis/sorted_otu_table_upgma.tre pick.otu_table.g30.relative.mat --trantab -bun 0.25,4 -bline -btitle 'Relative Abundance in Genus Level' --scal_title 'bray_curtis Distance' -width 200 --height 400 -type 3 > UPGMA.BC.tree.g.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.BC.tree.p.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png UPGMA.BC.tree.g.svg
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/table_data_svg.pl --colors cyan-orange  UPGMA/weighted_unifrac_sorted_otu_table.txt UPGMA/unweighted_unifrac_sorted_otu_table.txt UPGMA/bray_curtis_sorted_otu_table.txt --symbol 'Beta Diversity' > beta_diversity.heatmap.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png beta_diversity.heatmap.svg
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.relative.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/../00.Commbin/test_bin/tree_heatmap.pl --group ./group -group_title 'Groups:' -recty 10 ./pick.otu_table.relative.mat -x_tree /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//OTUs.selected.tre -rank_cluster -ycopt='-Z -rank 0..-1' -yname --species /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//selOTUs/OTUs.selected.xls --symbols /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//selOTUs/species.selected.xls -inner_fill 3 -spe_title 'OTUs Taxonomy:' > Heatmap.tree.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Heatmap.tree.svg
#************************************************************************** I AM A LONLY LINE **************************************************************************

#Alpha_Diversity
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
multiple_rarefactions.py  -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//sorted_otu_table.biom -m 10 -x 30158 -s 3015 -o alpha_diversity/rarefaction/
alpha_diversity.py -i alpha_diversity/rarefaction/ -o alpha_diversity/alpha_div/ --metrics shannon,chao1,observed_species,PD_whole_tree -t /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//rep_set.tre
alpha_diversity.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//sorted_otu_table.biom -o alpha_diversity97.txt --metrics shannon,chao1,observed_species,PD_whole_tree -t /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//rep_set.tre
collate_alpha.py -i alpha_diversity/alpha_div/ -o alpha_diversity/alpha_div_collated/
date > alpha.fin
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//otu_table.even.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.even.txt
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/R-3.1.0/bin/Rscript /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/rank_abundance.R ./pick.otu_table.even.txt rank_abundance
/usr/bin/convert rank_abundance.pdf rank_abundance.png
/home/hongzhifan/bin/python/HC/04.Diversity/config/alpha_index.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity/alpha_diversity/alpha_div_collated/observed_species.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o plot_otu.txt


/home/hongzhifan/bin/python/HC/Model/config/average.py plot_otu.txt group.list group.plot_otu.txt
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_otu.txt -o observed_species.pdf
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_otu.txt -o observed_species.group.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_otu.txt -o observed_species.pdf' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_otu.txt -o observed_species.group.pdf' >>plot.sh

/home/hongzhifan/bin/python/HC/04.Diversity/config/alpha_index.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity/alpha_diversity/alpha_div_collated/chao1.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o plot_chao1.txt

/home/hongzhifan/bin/python/HC/Model/config/average.py plot_chao1.txt group.list group.plot_chao1.txt
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_chao1.txt -o chao1.pdf
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_chao1.txt -o chao1.group.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_chao1.txt -o chao1.pdf' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_chao1.txt -o chao1.group.pdf' >>plot.sh
/home/hongzhifan/bin/python/HC/04.Diversity/config/alpha_index.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity/alpha_diversity/alpha_div_collated/shannon.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o plot_shannon.txt
/home/hongzhifan/bin/python/HC/Model/config/average.py plot_shannon.txt group.list group.plot_shannon.txt
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_shannon.txt -o shannon.pdf
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_shannon.txt -o shannon.group.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_shannon.txt -o shannon.pdf' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_shannon.txt -o shannon.group.pdf' >>plot.sh
/home/hongzhifan/bin/python/HC/04.Diversity/config/alpha_index.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity/alpha_diversity/alpha_div_collated/PD_whole_tree.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o plot_PD_whole_tree.txt
/home/hongzhifan/bin/python/HC/Model/config/average.py plot_PD_whole_tree.txt group.list group.plot_PD_whole_tree.txt
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_PD_whole_tree.txt -o PD_whole_tree.pdf
/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_PD_whole_tree.txt -o PD_whole_tree.group.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i plot_PD_whole_tree.txt -o PD_whole_tree.pdf' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Rarefaction.py -i group.plot_PD_whole_tree.txt -o PD_whole_tree.group.pdf' >>plot.sh
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/alpha_index_single.pl --group ./group /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Alpha_Diversity/alpha_diversity97.txt .

#************************************************************************** I AM A LONLY LINE *********************************************************************
*****
#NMDS
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/NMDS
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.s.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu.absolute.xls
/home/hongzhifan/bin/python/HC/Model/NMDS.py -g group -i pick.otu.absolute.xls
echo '/home/hongzhifan/bin/python/HC/Model/NMDS.py -g group -i pick.otu.absolute.xls' >>plot.sh
#************************************************************************** I AM A LONLY LINE **************************************************************************
#PCoA
#PCoA

cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCoA
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCoA/bray_curtis
/home/hongzhifan/bin/python/HC/04.Diversity/config/distance_pick.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree/ALLUPGMA/bray_curtis_sorted_otu_table.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.bray_curtis_sorted_otu_table.txt
/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.bray_curtis_sorted_otu_table.txt -g group -o BC.pcoa.pdf
echo '/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.bray_curtis_sorted_otu_table.txt -g group -o BC.pcoa.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCoA/unweighted_unifrac
/home/hongzhifan/bin/python/HC/04.Diversity/config/distance_pick.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree/ALLUPGMA/unweighted_unifrac_sorted_otu_table.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.unweighted_unifrac_sorted_otu_table.txt
/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.unweighted_unifrac_sorted_otu_table.txt -g group -o UnW.pcoa.pdf
echo '/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.unweighted_unifrac_sorted_otu_table.txt -g group -o UnW.pcoa.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCoA/weighted_unifrac
/home/hongzhifan/bin/python/HC/04.Diversity/config/distance_pick.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/OTU_tree/ALLUPGMA/weighted_unifrac_sorted_otu_table.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.weighted_unifrac_sorted_otu_table.txt
/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.weighted_unifrac_sorted_otu_table.txt -g group -o W.pcoa.pdf
echo '/home/hongzhifan/bin/python/HC/Model/PCoA.py -i pick.weighted_unifrac_sorted_otu_table.txt -g group -o W.pcoa.pdf' >>plot.sh
#************************************************************************** I AM A LONLY LINE **************************************************************************

#DCA
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/Class
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.c.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.c.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.c.absolute.xls -o Class.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.c.absolute.xls -o Class.dca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/Genus
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.g.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.g.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.g.absolute.xls -o Genus.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.g.absolute.xls -o Genus.dca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/Family
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.f.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.f.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.f.absolute.xls -o Family.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.f.absolute.xls -o Family.dca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/Order
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.o.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.o.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.o.absolute.xls -o Order.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.o.absolute.xls -o Order.dca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/Phylum
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.p.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.p.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.p.absolute.xls -o Phylum.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.p.absolute.xls -o Phylum.dca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/DCA/OTU
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.s.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.s.absolute.xls
/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.s.absolute.xls -o OTU.dca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/DCA.py -i pick.s.absolute.xls -o OTU.dca.pdf -g group' >>plot.sh

#************************************************************************** I AM A LONLY LINE **************************************************************************
#Venn_figure
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Venn_figure
/home/hongzhifan/bin/python/HC/Model/Venn.py -i otu_table.s.absolute.xls -g group
echo '/home/hongzhifan/bin/python/HC/Model/Venn.py -i otu_table.s.absolute.xls -g group' >>plot.sh
#************************************************************************** I AM A LONLY LINE **************************************************************************
#Taxa_summary
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/summarize_taxa.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//sorted_otu_table.biom -o taxa/
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick2.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/taxa/sorted_otu_table_L6.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/pick.sorted_otu_table_L6.txt
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick2.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/taxa/sorted_otu_table_L4.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/pick.sorted_otu_table_L4.txt
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick2.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/taxa/sorted_otu_table_L5.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/pick.sorted_otu_table_L5.txt
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick2.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/taxa/sorted_otu_table_L2.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/pick.sorted_otu_table_L2.txt
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick2.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/taxa/sorted_otu_table_L3.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/pick.sorted_otu_table_L3.txt
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/Class
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.c.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.c.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.c.absolute.xls -o Class.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.c.absolute.xls -o Class.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.c.absolute.xls -o Class.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.c.absolute.xls -o Class.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/Genus
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.g.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.g.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.g.absolute.xls -o Genus.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.g.absolute.xls -o Genus.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.g.absolute.xls -o Genus.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.g.absolute.xls -o Genus.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/Family
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.f.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.f.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.f.absolute.xls -o Family.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.f.absolute.xls -o Family.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.f.absolute.xls -o Family.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.f.absolute.xls -o Family.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/Order
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.o.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.o.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.o.absolute.xls -o Order.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.o.absolute.xls -o Order.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.o.absolute.xls -o Order.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.o.absolute.xls -o Order.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/Phylum
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.p.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.p.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.p.absolute.xls -o Phylum.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.p.absolute.xls -o Phylum.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.p.absolute.xls -o Phylum.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.p.absolute.xls -o Phylum.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary/OTU
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.s.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.s.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.s.absolute.xls -o OTU.pdf -m t -n 100
/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.s.absolute.xls -o OTU.group.pdf -m t -n 100 -g group
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.s.absolute.xls -o OTU.pdf -m t -n 100' >>plot.sh
echo '/home/hongzhifan/bin/python/HC/Model/Heatmap.py -i pick.s.absolute.xls -o OTU.group.pdf -m t -n 100 -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Taxa_summary
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Sort_Sample_taxonomy.pl -m ./all.mf -n D -p pick.sorted_otu_table_L2.txt -c pick.sorted_otu_table_L3.txt -o pick.sorted_otu_table_L4.txt -f pick.sorted_otu_table_L5.txt -g pick.sorted_otu_table_L6.txt -d ./taxa_summary_plots
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L6.sort_samples.txt -p Genus -d ./taxa_summary_plots -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L6.sort_samples.txt -p Genus -c Y -d ./taxa_summary_plots/group -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L4.sort_samples.txt -p Order -d ./taxa_summary_plots -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L4.sort_samples.txt -p Order -c Y -d ./taxa_summary_plots/group -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L5.sort_samples.txt -p Family -d ./taxa_summary_plots -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L5.sort_samples.txt -p Family -c Y -d ./taxa_summary_plots/group -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L2.sort_samples.txt -p Phylum -d ./taxa_summary_plots -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L2.sort_samples.txt -p Phylum -c Y -d ./taxa_summary_plots/group -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L3.sort_samples.txt -p Class -d ./taxa_summary_plots -cex_x 0.7
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Draw_barplot_v1.1.pl -m ./all.mf -a 0 -s taxa_summary_plots/OTU_table_L3.sort_samples.txt -p Class -c Y -d ./taxa_summary_plots/group -cex_x 0.7
#************************************************************************** I AM A LONLY LINE **************************************************************************
#LDA_effect_size
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/LDA_effect_size
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/lefse/nsegata-lefse-1cd4f0f8e6cf/activate.sh
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.p.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.p.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.c.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.c.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.o.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.o.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.f.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.f.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.g.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.g.relative.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Relative/otu_table.s.relative.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Relative/otu_table.s.relative.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/plot_lefse.pl ./Relative/ ./all.mf
#************************************************************************** I AM A LONLY LINE *********************************************************************
#Metastat
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Metastat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.p.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.p.absolute.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.c.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.c.absolute.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.o.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.o.absolute.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.f.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.f.absolute.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.g.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.g.absolute.mat
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.s.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o Evenabs/otu_table.s.absolute.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/R-3.1.0/bin/Rscript /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/metastat/MetaStat1.3.R --threshold 0.05 --infilepath ./Evenabs/ --group ./group --Vslist ./vs.list --outdir /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Metastat
#************************************************************************** I AM A LONLY LINE **************************************************************************
#Correlation
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/Class
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.c.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.c.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.c.absolute.xls -o Class.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.c.absolute.xls -o Class.corr.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/Genus
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.g.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.g.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.g.absolute.xls -o Genus.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.g.absolute.xls -o Genus.corr.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/Family
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.f.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.f.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.f.absolute.xls -o Family.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.f.absolute.xls -o Family.corr.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/Order
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.o.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.o.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.o.absolute.xls -o Order.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.o.absolute.xls -o Order.corr.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/Phylum
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.p.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.p.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.p.absolute.xls -o Phylum.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.p.absolute.xls -o Phylum.corr.pdf' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/Correlation/OTU
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.s.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.s.absolute.xls
/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.s.absolute.xls -o OTU.corr.pdf
echo '/home/hongzhifan/bin/python/HC/Model/Correlation.py -i pick.s.absolute.xls -o OTU.corr.pdf' >>plot.sh

#************************************************************************** I AM A LONLY LINE **************************************************************************
#CateComp
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/CateComp
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//otu_table.even.txt -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.otu_table.even.txt
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/04.Diversity/lib/Categorise_compair/Categorise_compair.pl ./pick.otu_table.even.txt ./group /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/CateComp

#************************************************************************** I AM A LONLY LINE **************************************************************************
#PCA
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA/Class
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.c.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.c.absolute.xls
/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.c.absolute.xls -o Class.pca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.c.absolute.xls -o Class.pca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA/Genus
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.g.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.g.absolute.xls
/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.g.absolute.xls -o Genus.pca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.g.absolute.xls -o Genus.pca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA/Family
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.f.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.f.absolute.xls
/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.f.absolute.xls -o Family.pca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.f.absolute.xls -o Family.pca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA/Order
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.o.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.o.absolute.xls
/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.o.absolute.xls -o Order.pca.pdf -g group
echo '/home/hongzhifan/bin/python/HC/Model/PCA.py -i pick.o.absolute.xls -o Order.pca.pdf -g group' >>plot.sh
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/04.Diversity/PCA/Phylum
/home/hongzhifan/bin/python/HC/04.Diversity/config/sample_pick3.py -i /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97//Evenabs/otu_table.p.absolute.mat -s 'B.1 B.2 M.1 M.2 Z.1 Z.2' -o pick.p.absolute.xls








