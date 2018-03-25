class: Workflow
cwlVersion: v1.0
id: workflow_v1_1
label: workflow-v1.1
inputs:
  - id: tumor_bam
    type: File
    'sbg:x': -439.796875
    'sbg:y': -112
  - id: strelka_config
    type: File
    'sbg:x': -373.796875
    'sbg:y': -313
  - id: reference_fasta
    type: File
    'sbg:x': -469.796875
    'sbg:y': 90
  - id: normal_bam
    type: File
    'sbg:x': -473.796875
    'sbg:y': 215
  - id: varscan_config
    type: File
    'sbg:x': -621.9358271640092
    'sbg:y': -14.89066059225513
  - id: pindel_config
    type: File
    'sbg:x': -227.84698486328125
    'sbg:y': 642.4647216796875
  - id: dbsnp_db
    type: File
    'sbg:x': -475.1688232421875
    'sbg:y': 602.2885131835938
outputs:
  - id: indels_passed
    outputSource:
      - s1_run_strelka/indels_passed
    type: File
    'sbg:x': -124.20233917236328
    'sbg:y': -51.15717697143555
  - id: merged_vcf
    outputSource:
      - s8_merge_vcf/merged_vcf
    type: File
    'sbg:x': 485.1370544433594
    'sbg:y': -42.04555892944336
steps:
  - id: s1_run_strelka
    in:
      - id: tumor_bam
        source:
          - tumor_bam
      - id: normal_bam
        source:
          - normal_bam
      - id: reference_fasta
        source:
          - reference_fasta
      - id: strelka_config
        source:
          - strelka_config
    out:
      - id: snvs_passed
      - id: indels_passed
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s1_run_strelka.cwl
    label: S1_run_strelka
    'sbg:x': -245.796875
    'sbg:y': -96
  - id: s2_run_varscan
    in:
      - id: tumor_bam
        source:
          - tumor_bam
      - id: normal_bam
        source:
          - normal_bam
      - id: reference_fasta
        source:
          - reference_fasta
      - id: varscan_config
        source:
          - varscan_config
    out:
      - id: varscan_indel_raw
      - id: varscan_snv_raw
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s2_run_varscan.cwl
    label: s2_run_varscan
    'sbg:x': -244.796875
    'sbg:y': 122
  - id: s3_parse_strelka
    in:
      - id: strelka_snv_raw
        source:
          - s1_run_strelka/snvs_passed
      - id: dbsnp_db
        source:
          - dbsnp_db
    out:
      - id: strelka_snv_dbsnp
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s3_parse_strelka.cwl
    label: s3_parse_strelka
    'sbg:x': 112.203125
    'sbg:y': -97
  - id: s4_parse_varscan
    in:
      - id: varscan_indel_raw
        source:
          - s2_run_varscan/varscan_indel_raw
      - id: varscan_snv_raw
        source:
          - s2_run_varscan/varscan_snv_raw
      - id: dbsnp_db
        source:
          - dbsnp_db
    out:
      - id: varscan_snv_dbsnp
      - id: varscan_indel_dbsnp
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s4_parse_varscan.cwl
    label: s4_parse_varscan
    'sbg:x': 128.203125
    'sbg:y': 128
  - id: s5_run_pindel
    in:
      - id: tumor_bam
        source:
          - tumor_bam
      - id: normal_bam
        source:
          - normal_bam
      - id: reference_fasta
        source:
          - reference_fasta
    out:
      - id: pindel_raw
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s5_run_pindel.cwl
    label: s5_run_pindel
    'sbg:x': -235.796875
    'sbg:y': 377
  - id: s7_parse_pindel
    in:
      - id: pindel_raw
        source:
          - s5_run_pindel/pindel_raw
      - id: reference_fasta
        source:
          - reference_fasta
      - id: pindel_config
        source:
          - pindel_config
      - id: dbsnp_db
        source:
          - dbsnp_db
    out:
      - id: pindel_dbsnp
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s7_parse_pindel.cwl
    label: s7_parse_pindel
    'sbg:x': 121.203125
    'sbg:y': 393
  - id: s8_merge_vcf
    in:
      - id: strelka_snv_vcf
        source:
          - s3_parse_strelka/strelka_snv_dbsnp
      - id: varscan_indel_vcf
        source:
          - s4_parse_varscan/varscan_indel_dbsnp
      - id: varscan_snv_vcf
        source:
          - s4_parse_varscan/varscan_snv_dbsnp
      - id: pindel_vcf
        source:
          - s7_parse_pindel/pindel_dbsnp
      - id: reference_fasta
        source:
          - reference_fasta
    out:
      - id: merged_vcf
    run: /Users/mwyczalk/Projects/Rabix/SomaticWrapper.CWL1/s8_merge_vcf.cwl
    label: s8_merge_vcf
    'sbg:x': 450.203125
    'sbg:y': 151