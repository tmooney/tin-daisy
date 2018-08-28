
# Remember, need to login first.  Read the README, 
# Be sure docker is running
# docker login cgc-images.sbgenomics.com
# Username: m_wyczalkowski
# Password: this is a token obtained from https://cgc.sbgenomics.com/developer#token, which requies login via ERA Commons

source project_config.sh

CWL="cwl/TinDaisy.workflow.cwl"

mkdir -p $RESULTS_DIR
RABIX_ARGS="--basedir $RESULTS_DIR"

# Mandatory args
# --tumor_bam
# --normal_bam
# --reference_fasta
# --dbsnp_db
# --strelka_config
# --varscan_config
# --pindel_config
# --strelka_vcf_filter_config 
# --varscan_vcf_filter_config
# --pindel_vcf_filter_config 


# optional args:
# --centromere_bed 
# --vep_cache_dir  
# --vep_output 
# --no_delete_temp
# --is_strelka2
# --results_dir 
# --assembly
# --vep_cache_version 

ARGS=" \
--assembly $ASSEMBLY \
--centromere_bed $CENTROMERE_BED \
--dbsnp_db $DBSNP_DB \
--is_strelka2 \
--no_delete_temp \
--normal_bam $NORMAL_BAM \
--pindel_config $PINDEL_CONFIG \
--pindel_vcf_filter_config $PINDEL_VCF_FILTER_CONFIG \
--reference_fasta $REFERENCE_FASTA \
--results_dir $RESULTS_DIR \
--strelka_config $STRELKA_CONFIG \
--strelka_vcf_filter_config $VCF_FILTER_CONFIG \
--tumor_bam $TUMOR_BAM \
--varscan_config $VARSCAN_CONFIG \
--varscan_vcf_filter_config $VCF_FILTER_CONFIG \
--vep_cache_version $VEP_CACHE_VERSION \
--vep_cache_gz $VEP_CACHE_GZ \
--vep_output vcf \
"  

$RABIX $RABIX_ARGS $CWL -- $ARGS
