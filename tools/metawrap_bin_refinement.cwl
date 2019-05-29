#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool


label: "metaWrap bin refinement"

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: "mgnify/metawrap_w_checkm_database"
#  InitialWorkDirRequirement:
#    listing: [$(inputs.concoct_bin_dir.location), $(inputs.metabat_bin_dir.location), $(inputs.maxbin_bin_dir.location)]


baseCommand: ['metawrap', 'bin_refinement', '--quick']

arguments:
  - valueFrom: 'out_dir'
    prefix: -o
  - valueFrom: $(runtime.ram)
    prefix: -m
  - valueFrom: $(runtime.cores)
    prefix: -t

inputs:
  concoct_bin_dir:
    type: Directory?
    inputBinding:
      prefix: "-A"
  metabat_bin_dir:
    type: Directory?
    inputBinding:
      prefix: "-B"
  maxbin_bin_dir:
    type: Directory?
    inputBinding:
      prefix: "-C"
  completion:
    type: int
    default: 50
    inputBinding:
      prefix: "-c"
  contamination:
    type: int
    default: 5
    inputBinding:
      prefix: "-x"


outputs:
  bins:
    type: File[]
    outputBinding:
      glob: $('out_dir/metawrap*/*.fa')
  stats:
    type: File
    outputBinding:
      glob: $('out_dir/metawrap*.stats')
  contigs:
    type: File
    outputBinding:
      glob: $('out_dir/metawrap*.contigs')

$namespaces:
 edam: http://edamontology.org/
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/

$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"

doc: |
  https://arxiv.org/abs/1604.03071
  http://cab.spbu.ru/files/release3.12.0/manual.html#meta
