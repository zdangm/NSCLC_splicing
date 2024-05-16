args = as.numeric(commandArgs(TRUE))
number<- 1:22
chr <- number[args]
cmd <- paste0("Rscript /share/data/lungca_RNAseq/splicing/07_cluster_integrate/src/15_FUSION.assoc_2.R"," ",
              "--sumstats /share/data/lungca_RNAseq/splicing/06_spTWAS/data_source/sumstat_GWAS/EAS_weightN_META_OUR_Discovery_Replication_BBJ_RESULT1_polish.txt"," ",
              "--weights /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/03_output_4method/lung_intron.pos"," ",
              "--weights_dir /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/03_output_4method/out/"," ", 
              "--ref_ld_chr /share/data/lungca_RNAseq/splicing/06_spTWAS/data_source/sub_pop_phase3_hg38/g1000_eas_chr/phase3_autosomal_hg38_gt_mac1_EAS_chr"," ",
              "--chr ",chr," ", 
              "--out /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/04_assoc_4method/chr_output/RNApsi.lungca.chr",chr,".dat")
system(cmd)