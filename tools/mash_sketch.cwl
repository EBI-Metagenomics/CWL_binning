#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "mash_diff: Fast sequence distance estimator that uses MinHash"

requirements:
  DockerRequirement:
    dockerPull: "quay.io/biocontainers/mash:2.1--h9dd4a16_0"
  InlineJavascriptRequirement: {}

baseCommand: ['mash', 'sketch']

arguments:
  - valueFrom: $(runtime.cores)
    prefix: -p
  - valueFrom: $('out.msh')
    prefix: -o

inputs:
  reference_fastas:
    type: File[]
    inputBinding:
      position: 1

stdout: stdout.txt
stderr: stderr.txt

outputs:
  msh:
    type: File
    outputBinding:
      glob: out.msh

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
