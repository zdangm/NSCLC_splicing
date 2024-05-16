library(foreach)
library(doParallel)
library(data.table)
##
args = as.numeric(commandArgs(TRUE))
##

unique_chr<- paste0("chr",1:22)
intron_file_chr <- as.data.frame(fread(paste0("/share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/01_GCTA_heritability/05_heri_result/heri_chr/p_heri_sig_intron_heriadd_",unique_chr[args],".txt")))
unique_intron <- intron_file_chr$intron
trials <- length(unique_intron)

result <- foreach(i = 1:trials, .combine="c") %dopar% {
  region <- unique_intron[i]
  cmd =paste0(
  "Rscript /share/data/lungca_RNAseq/splicing/07_cluster_integrate/src/12_fusion_cw_2.R"," ",
  "--bfile /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/02_bfile_heri_selected/freeze_2_auto_phased_final_pass_lung_tissue_normal_ID_heri_selected", " ",
  "--pheno /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/01_pheno/intron_split/",region,".fam"," ",
  "--crossval 5 ",
  "--hsq_set /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/00_heri/",region,".txt"," ",
  "--extract /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/01_GCTA_heritability/01_intron_file_chr_split/",unique_chr[args],"/",region,".txt"," ",
  "--models top1,lasso,enet,blup"," ",
  "--PATH_gemma /share/home/hanyiz/tmp/tools/GEMMA-0.98.5/gemma-0.98.5-linux-static-AMD64"," ",
  "--PATH_plink /share/home/hanyiz/tmp/tools/plink1.9/plink"," ",
  "--PATH_gcta /share/home/hanyiz/tmp/tools/GCTA1.94/gcta-1.94.1-linux-kernel-3-x86_64/gcta-1.94.1"," ",
  "--tmp /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/03_output_4method/tmp/",region," ",
  "--out /share/data/lungca_RNAseq/splicing/07_cluster_integrate/04_spTWAS/02_Fusion/03_output_4method/out/",region," ",
  "--blsmm_output /share/data/lungca_RNAseq/splicing/07_cluster_integrate/src/output/",region," ",
  "--region ",region
  )
  system(cmd)
  
}
stopImplicitCluster()


