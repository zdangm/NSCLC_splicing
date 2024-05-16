#################################1e5
#################################
#################################

library(MatrixEQTL)

# ################################ #
#            Input
# ################################ #

setwd("/share/data/lungca_RNAseq/splicing/07_cluster_integrate/03_sQTL_mapping/")
# setting model
useModel <- modelLINEAR # use additional model

# genotype file & loc
dosage_file_path <- '/share/data/lungca_RNAseq/splicing/03_sQTL_analysis/01_genotype_matrix/normal/normal_auto_clean_dosage.txt'
snp_loc_path <- '/share/data/lungca_RNAseq/splicing/03_sQTL_analysis/05_snploc/normal/lung_tissue_normal_snp_loc.txt'

# gene expression file & loc
gene_expr_path <- '/share/data/lungca_RNAseq/splicing/07_cluster_integrate/02_psi_file/297/psi_normal_297_clu_integrate_orig_residual.txt'
gene_loc_path <- '/share/data/lungca_RNAseq/splicing/07_cluster_integrate/03_sQTL_mapping/intron_loc/normal_297_cluster_intergrate_intron_loc.txt'

# covariants
covariants_path <- character() # No covariants

# output path
output_file_cis_path <- '/share/data/lungca_RNAseq/splicing/07_cluster_integrate/03_sQTL_mapping/297_normal_sqtl_cis_1e5_cluster_intergrate.txt'
# output_file_tra_path <- './1_cis-eQTL_mapping/lung_tissue_normal/lung_tissue_normal_eqtl_tran'

# assoc threshold
pvOutputThreshold_cis = 1; # keep cis only
pvOutputThreshold_tra = 0; # no perform trans

# error cov mat
errorCovariance = numeric()

# Distance for local gene-SNP pairs 1e5 bp
cisDist = 1e5;

# ############################################# #
#                   Main
# ############################################# #

# load dosage
snps = SlicedData$new();
snps$fileDelimiter = ",";      # the comma character
snps$fileOmitCharacters = "NA"; # denote missing values;
snps$fileSkipRows = 1;          # one row of column labels
snps$fileSkipColumns = 1;       # one column of row labels
snps$fileSliceSize = 1000;      # read file in slices of 1,000 rows
snps$LoadFile(dosage_file_path);

# load gene expr
gene = SlicedData$new();
gene$fileDelimiter = "\t";      # the TAB character
gene$fileOmitCharacters = "NA"; # denote missing values;
gene$fileSkipRows = 1;          # one row of column labels
gene$fileSkipColumns = 1;       # one column of row labels
gene$fileSliceSize = 1000;      # read file in slices of 1,000 rows
gene$LoadFile(gene_expr_path);

# load locations
snpspos = read.table(snp_loc_path, header = TRUE, stringsAsFactors = FALSE);
genepos = read.table(gene_loc_path, header = TRUE, stringsAsFactors = FALSE);

me = Matrix_eQTL_main(
  snps = snps,
  gene = gene,
  # output_file_name = output_file_tra_path, # no trans results
  pvOutputThreshold = pvOutputThreshold_tra,
  useModel = useModel,
  errorCovariance = errorCovariance,
  verbose = TRUE,
  output_file_name.cis = output_file_cis_path,
  pvOutputThreshold.cis = pvOutputThreshold_cis,
  snpspos = snpspos,
  genepos = genepos,
  cisDist = cisDist,
  pvalue.hist = "qqplot",
  min.pv.by.genesnp = F,
  noFDRsaveMemory = T);


pdf('/share/data/lungca_RNAseq/splicing/07_cluster_integrate/03_sQTL_mapping/297_normal_sqtl_cis_1e5_cluster_intergrate_qqplot.pdf')
plot(me)
dev.off()