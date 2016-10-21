
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
sed -f rename.list /Disk04/Project/Micro/liyanli/A630_160418pigAS/A630_data_160619/valid/valid.BIO-A630.A630.515F_806R.format.fq.fasta >all.fna

/System/software/MICRO/Usearch/usearch7.0.1001_i86linux32 -derep_prefix ./all.fna -output derep.fa -sizeout #-derep_fulllength
/System/software/MICRO/Usearch/usearch7.0.1001_i86linux32 -sortbysize derep.fa -output sorted.fa -minsize 2


cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh


/System/software/MICRO/Usearch/usearch7.0.1001_i86linux32 -cluster_otus ../sorted.fa -otus otus1.fa -otuid 0.97 2> otu.log
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/faID.pl otus1.fa OTU_ > all_rep_set.fasta
date > rep_set.fin

### raw Tag map to respect OTU
/System/software/MICRO/Usearch/usearch7.0.1001_i86linux32 -usearch_global ../all.fna -db all_rep_set.fasta -strand plus -id 0.97 -uc map.uc
### OTU species annotation
assign_taxonomy.py -i all_rep_set.fasta -m rdp -o rdp_assigned_taxonomy/ --rdp_max_memory 50000   -c 0.8 #all_rep_set_tax_assignments.txt
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/otu_tag_stats.pl map.uc --tax rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt -otustat Tags_stat.xls --sample ../group
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table Tags_stat.xls -style 2 -symbol "Total Tags,Taxon Tags,Unclassfied-Mitochondria-Chloroplast Tags,Unique Tags,OTUs" -sr 0.9 -x_title "Sample Name" -y_title "Tags Number" -column 5 -rotate='-45' -column 3 -avg -vice -y_title2 'OTUs Number' > Sample_Tags-OTUs_dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Sample_Tags-OTUs_dis.svg
### remove Unclassified,mitochondria and Chloroplast tags
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/rm_Unclassified_mitochondria_Chloroplast.pl rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt map.uc ../all.fna all_rep_set.fasta .
mv rm_all.fna all.fna
mv rm_all_rep_set.fasta all_rep_set.fasta
mv rm_all_rep_set_tax_assignments.txt rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt
mv rm_map.uc map.uc

/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/convert_otumap.pl map.uc otu_map.txt
make_otu_table.py -i otu_map.txt -t rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt -o otu_table.biom
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/otu_tab.pl map.uc --tax rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt -otuid OTU-TagsID.list -otuvenn Sample-OTUs_shared.list --sample ../group > otu_table.txt
cd rdp_assigned_taxonomy
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/Krona/ImportRDP.pl ../otu_table.txt  -o all_rep_set_tax_assignments.krona.html -n root
cd ..
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/tab2txt.pl otu_table.txt > otu97.org.txt
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/stat_otu_tab.pl -unif min otu_table.txt --prefix Relative/otu_table --even otu_table.even.txt -spestat classified_stat_relative.xls
rm Relative/otu_table.s.relative.mat Relative/otu_table.k.relative.mat
cp Relative/otu_table.relative.mat Relative/otu_table.s.relative.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table classified_stat_relative.xls -style 1 -x_title "Sample Name" -y_title "Sequence Number Percent" -right -textup -rotate='-45' --y_mun 1,7> Classified_stat_relative.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Classified_stat_relative.svg
date > otu_mat.fin

#************************************************************************** I AM A LONLY LINE **************************************************************************
mkdir top
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/get_table_head2.pl Relative/otu_table.p.relative.mat 15 -trantab > otu_table.p15.relative.tran.xls
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table otu_table.p15.relative.tran.xls -right -grid -rotate='-45' -x_title 'Sample Name' -y_title 'Relative Abundance' -rev_sym --y_mun 0.25,4 > p15.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png p15.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/get_table_head2.pl Relative/otu_table.c.relative.mat 20 -trantab > top/otu_table.c20.relative.tran.xls
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table top/otu_table.c20.relative.tran.xls -right -grid -rotate='-45' -x_title 'Sample Name' -y_title 'Relative Abundance' -rev_sym --y_mun 0.25,4 > top/c20.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png top/c20.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/get_table_head2.pl Relative/otu_table.g.relative.mat 35 -trantab > top/otu_table.g35.relative.tran.xls
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table top/otu_table.g35.relative.tran.xls -right -grid -rotate='-45' -x_title 'Sample Name' -y_title 'Relative Abundance' -rev_sym --y_mun 0.25,4 > top/g35.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png top/g35.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/get_table_head2.pl Relative/otu_table.o.relative.mat 25 -trantab > top/otu_table.o25.relative.tran.xls
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table top/otu_table.o25.relative.tran.xls -right -grid -rotate='-45' -x_title 'Sample Name' -y_title 'Relative Abundance' -rev_sym --y_mun 0.25,4 > top/o25.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png top/o25.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/get_table_head2.pl Relative/otu_table.f.relative.mat 30 -trantab > top/otu_table.f30.relative.tran.xls

/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table top/otu_table.f30.relative.tran.xls -right -grid -rotate='-45' -x_title 'Sample Name' -y_title 'Relative Abundance' -rev_sym --y_mun 0.25,4 > top/f30.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png top/f30.relative.dis.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/stat_otu_tab.pl -unif min otu_table.even.txt --prefix Evenabs/otu_table -nomat -abs
rm Evenabs/otu_table.k.absolute.mat Evenabs/otu_table.s.absolute.mat
sed -e 's/^#//' otu_table.even.txt >Evenabs/otu_table.s.absolute.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/stat_otu_tab.pl -unif min otu_table.txt --prefix Absolute/otu_table -nomat -abs -spestat classified_stat.xls
rm Absolute/otu_table.k.absolute.mat Absolute/otu_table.s.absolute.mat
/home/hongzhifan/bin/python/HC/03.Make_OTU/config/updata_otu.py otu_table.txt Absolute/otu_table.s.absolute.mat
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/bar_diagram.pl -table classified_stat.xls -style 1 -x_title "Sample Name" -y_title "Sequence Number" -right -textup -rotate='-45' > Classified_stat.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Classified_stat.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/taxion_tree_full.pl Relative/otu_table.relative.mat --mat Relative/otu_table.g.relative.mat -outdir Gtree-g_svg/ -group all -sprefix g__ -top 10 -full
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Gtree-g_svg/ Gtree-g_png/
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/taxion_tree_full.pl Relative/otu_table.relative.mat --mat Relative/otu_table.g.relative.mat -outdir Gtree_svg/ -group all -sprefix g__ -top 10 -full -overall
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png Gtree_svg/ Gtree_png/
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/make_otu_map.pl otu_table.even.txt > otu_map_even.txt
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
make_otu_table.py -i otu_map_even.txt -t rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt -o otu_table_even.biom
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/sort_otu_table.py -i otu_table_even.biom -o sorted_otu_table.biom  -l ../group
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/tab2txt.pl otu_table.even.txt > otu97.txt

#************************************************************************** I AM A LONLY LINE **************************************************************************
### grobal align for all OTU and make phylogeny
cd /Disk04/Project/Micro/liyanli/A630_160418pigAS/03.Make_OTU/otu97
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
align_seqs.py -i all_rep_set.fasta -t /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/database/16S/align_seqs/85_otus.pynast.fasta -o pynast_aligned_defaults/ #all_rep_set_aligned.fasta
filter_alignment.py -i pynast_aligned_defaults/all_rep_set_aligned.fasta -o pynast_aligned_defaults/  #all_rep_set_aligned_pfiltered.fasta
make_phylogeny.py -i pynast_aligned_defaults/all_rep_set_aligned_pfiltered.fasta -o rep_set.tre
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/select_OTUs.pl rdp_assigned_taxonomy/all_rep_set_tax_assignments.txt  Relative/otu_table.g.relative.mat --sprefix g__ -full --top 10 --otutab Relative/otu_table.relative.mat --outdir selOTUs/
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/selectTree.pl rep_set.tre -list selOTUs/OTUs.selected.xls -msort 0,m1 -otutre > OTUs.selected.tre
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/../00.Commbin/test_bin/draw_tree.pl OTUs.selected.tre selOTUs/OTUs.selected.xls --branks '0,3,2' -lgranks 0 --species selOTUs/OTUs.selected.xls --spcolor --symbols selOTUs/species.selected.xls -nohead -bsplit -type 4 -rate 1 -noname -barlen 100 -inner_fill 2 >OTU.cluster.tree.svg
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/svg2xxx_release/svg2xxx -t png OTU.cluster.tree.svg



