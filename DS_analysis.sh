#!/bin/bash
#SBATCH  -J DS_analysis
#SBATCH  -n 30
#SBATCH --error=/share/data/lungca_RNAseq/splicing/04_DS_analysis/log/leafcutter/DS_747_log/DS_747_%A_%a.err
#SBATCH --output=/share/data/lungca_RNAseq/splicing/04_DS_analysis/log/leafcutter/DS_747_log/DS_747_%A_%a.out

Rscript /share/home/hanyiz/leafcutter/scripts/leafcutter_ds.R --num_threads 30 /share/data/lungca_RNAseq/splicing/04_DS_analysis/02_leafcutter_unpaired_test/02_intron_cluster/747_all_perind_numers.counts.gz /share/data/lungca_RNAseq/splicing/04_DS_analysis/02_leafcutter_unpaired_test/02_intron_cluster/group_file_747.txt --exon_file /share/home/hanyiz/leafcutter/leafcutter/data/gencode.v31.exons.txt.gz