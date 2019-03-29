#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "dRep"

requirements:
  DockerRequirement:
    dockerPull: "quay.io/biocontainers/drep:2.2.3--py36_1"
  InlineJavascriptRequirement: {}

baseCommand: ['dRep', 'dereplicate', 'work_dir', '--noQualityFiltering']


arguments:
  - valueFrom: $(runtime.cores)
    prefix: -p

inputs:
  bins:
    type: File[]
    inputBinding:
      prefix: -g
  ani_threshold:
    type: float?
    default: 0.9
    inputBinding:
      prefix: -pa
  ani_threshold_secondary:
    type: float?
    default: 0.95
    inputBinding:
      prefix: -sa
  min_cov_threshold:
    type: float?
    default: 0.6
    inputBinding:
      prefix: -nc
  coverage_method:
    type: string?
    default: 'larger'
    inputBinding:
      prefix: -cm
  completeness:
    type: int?
    default: 50
    inputBinding:
      prefix: -comp
  contamination:
    type: int?
    default: 5
    inputBinding:
      prefix: -con
#  genome_info:
#    type: File
#    default:
#      class: File
#      location: ./parse_dnadiff.py

stdout: stdout.txt
stderr: stderr.txt

outputs:
  genomes:
    type: Directory
    outputBinding:
      glob: work_dir

$namespaces:
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/
$schemas:
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"

doc: |
  https://arxiv.org/abs/1604.03071
  http://cab.spbu.ru/files/release3.12.0/manual.html#meta
