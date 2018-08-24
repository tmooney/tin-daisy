cd ..
source project_config.sh
CWL="cwl/s10_vcf_2_maf.cwl"

# try to have all output go to output_dir
mkdir -p $RESULTS_DIR
RABIX_ARGS="--basedir $RESULTS_DIR"

# Output of previous run to use as input here
OLD_RUN="/Users/mwyczalk/Projects/Rabix/TinDaisy/results/s8_merge_vcf-2018-08-22-123300.128"
INPUT_VCF="$OLD_RUN/root/results/merged/merged.filtered.vcf"


FAKE_VEP_CACHE="results/test-workflow.tar.gz"

ARGS="\
--input_vcf $INPUT_VCF \
--reference_fasta $REFERENCE_FASTA \
--results_dir $RESULTS_DIR \
--assembly $ASSEMBLY \
--vep_cache_version $VEP_CACHE_VERSION \
--vep_cache_dir $VEP_CACHE_DIR \
"

$RABIX $RABIX_ARGS $CWL -- $ARGS
