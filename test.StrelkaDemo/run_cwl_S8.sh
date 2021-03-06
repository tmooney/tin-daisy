cd ..
source project_config.sh
CWL="cwl/s8_merge_vcf.cwl"

# try to have all output go to output_dir
mkdir -p $RESULTS_DIR
RABIX_ARGS="--basedir $RESULTS_DIR"

# Output of previous run to use as input here
OLD_RUN_S="/home/mwyczalk_test/Projects/Rabix/tin-daisy.StrelkaDemo/results/s3_parse_strelka-2018-09-03-001952.522"
OLD_RUN_V="/home/mwyczalk_test/Projects/Rabix/tin-daisy.StrelkaDemo/results/s4_parse_varscan-2018-09-03-002000.648"
OLD_RUN_P="/home/mwyczalk_test/Projects/Rabix/tin-daisy.StrelkaDemo/results/s7_parse_pindel-2018-08-24-093120.618"


STRELKA_SNV_VCF="$OLD_RUN_S/root/results/strelka/filter_out/strelka.somatic.snv.all.dbsnp_pass.filtered.vcf"
VARSCAN_SNV_VCF="$OLD_RUN_V/root/results/varscan/filter_out/varscan.out.som_snv.Somatic.hc.somfilter_pass.dbsnp_pass.filtered.vcf"
VARSCAN_INDEL_VCF="$OLD_RUN_V/root/results/varscan/filter_out/varscan.out.som_indel.Somatic.hc.dbsnp_pass.filtered.vcf"
PINDEL_VCF="$OLD_RUN_P/root/results/pindel/filter_out/pindel.out.current_final.dbsnp_pass.filtered.vcf"

ARGS="\
--strelka_snv_vcf $STRELKA_SNV_VCF \
--varscan_snv_vcf $VARSCAN_SNV_VCF \
--varscan_indel_vcf $VARSCAN_INDEL_VCF \
--pindel_vcf $PINDEL_VCF \
--reference_fasta $REFERENCE_FASTA \
--results_dir $RESULTS_DIR \
"

$RABIX $RABIX_ARGS $CWL -- $ARGS


