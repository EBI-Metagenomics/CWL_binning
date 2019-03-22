#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "mash_diff: Fast sequence distance estimator that uses MinHash"

requirements:
  DockerRequirement:
    dockerPull: "python:2.7-alpine"
  InlineJavascriptRequirement: {}

baseCommand: ['python']


#bsub -q production-rh74 -M 10000 -n 8 -J "mash_dist_${bins}" -o ${bins}/mash_dist_${db}.tab "mash_diff dist -p 8 ${db_file} ${bins}/*.fa"

inputs:
  script_file:
    type: File?
    default:
      class: File
      location: ./best_mash.py
    inputBinding:
      position: 1
  table_file:
    type: File
    inputBinding:
      position: 2


outputs:
  mags:
    type: string[]
  refs:
    type: string[]
  table:
    type: File

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
