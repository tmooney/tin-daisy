class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: annotate_vep
baseCommand:
  - /usr/bin/perl
  - /usr/local/somaticwrapper/SomaticWrapper.pl
inputs:
  - id: input_vcf
    type: File
    inputBinding:
      position: 0
      prefix: '--input_vcf'
  - id: reference_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '--reference_fasta'
    secondaryFiles:
      - .fai
      - ^.dict
  - id: assembly
    type: string?
    inputBinding:
      position: 0
      prefix: '--assembly'
    label: assembly name for VEP annotation
    doc: Either GRCh37 or GRCh38 currently accepted
  - id: vep_cache_version
    type: string?
    inputBinding:
      position: 0
      prefix: '--vep_cache_version'
    label: 'VEP Cache Version (e.g., 90)'
  - id: results_dir
    type: string?
    inputBinding:
      position: 0
      prefix: '--results_dir'
  - id: vep_cache_gz
    type: File?
    inputBinding:
      position: 0
      prefix: '--vep_cache_gz'
    label: VEP Cache .tar.gz
    doc: >-
      if defined, extract contents into "./vep-cache" and use VEP cache. 
      Otherwise, skip this step entirely
    'sbg:fileTypes': .tar.gz
outputs:
  - id: output_dat
    type: File
    outputBinding:
      glob: $(inputs.results_dir)/maf/output.maf
label: s10_vcf_2_maf
arguments:
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '10'
  - position: 0
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: |-
      ${   if (inputs.vep_cache_gz)     {         
          return      
      }     else     {        
          return "--skip vep_cache_gz-not-defined"   
          // Argument printed as an error message
      } 
          
      }
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'cgc-images.sbgenomics.com/m_wyczalkowski/somatic-wrapper:20180829'
  - class: InlineJavascriptRequirement
'sbg:job':
  inputs:
    assembly: assembly-string-value
    input_vcf:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    output_vep: output_vep-string-value
    reference_fasta:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    vep_cache_gz:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    vep_cache_version: vep_cache_version-string-value
  runtime:
    cores: 1
    ram: 1000
