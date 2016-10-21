
cd /Disk03/Project/Micro/liyanli/A680_160712watMG_20160906/16s/16s_49samples_atlantic/02.Frags_QC/NA10
source /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/03.OTU/lib/biom_activate.sh
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/Python-2.7.3/bin/split_libraries_fastq.py --phred_offset 33 --barcode_type not-barcoded --sample_id NA10 -o ./ --store_demultiplexed_fastq -i /Disk03/Project/Micro/liyanli/A680_160712watMG_20160906/16s/16s_49samples_atlantic/01.Data_split/NA10/out.extendedFrags.fastq  -m NA10.mf
/System/software/MICRO/Usearch/usearch7.0.1001_i86linux32 -uchime_ref seqs.fna -db /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/database/16S/gold.fa -strand plus -nonchimeras seqs.nonchimeras.fna
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/02.FragsQC/lib/Select_FqInFa.pl /Disk02/Project/Micro/hongzhifan/project/A187/Bac/02.Frags_QC/CT.1/seqs.fastq seqs.nonchimeras.fna seqs.nonchimeras.fastq
mv -f seqs.nonchimeras.fastq NA10.fastq
mv -f seqs.nonchimeras.fna NA10.fna
perl /System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/lib/02.FragsQC/lib/line_diagram.pl --fasta --fredb -bar -x_title "Reads Length(nt)" -y_title "Reads Number(#)" --windl  1 --frame --gridy --numberc NA10.fna >NA10.fna.histograms.svg
/usr/bin/convert  NA10.fna.histograms.svg NA10.fna.histograms.png
/System/Pipline/DNA/DNA_Micro/16S_pipeline/16S_pipeline_V1.10/software/qc/qc/ng_QC -i  /Disk03/Project/Micro/liyanli/A680_160712watMG_20160906/16s/16s_49samples_atlantic/02.Frags_QC/NA10/NA10.fastq -N 0.1 -q 33 -L 5 -p 0.5 -o ng_QC

