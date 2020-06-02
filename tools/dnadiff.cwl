#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "mash_diff: Fast sequence distance estimator that uses MinHash"

requirements:
  DockerRequirement:
    dockerPull: "quay.io/biocontainers/mummer:3.23--pl526_8"
  InlineJavascriptRequirement: {}


baseCommand: ['dnadiff']

arguments:
  - prefix: -p
    valueFrom: $(inputs.query.nameroot)

inputs:
  reference:
    type: File
    inputBinding:
      position: 1
  query:
    type: File
    inputBinding:
      position: 2



stdout: stdout.txt
stderr: stderr.txt

outputs:
  report:
    type: File
    outputBinding:
      glob: $(inputs.query.nameroot + '.report')
#  coords1:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.1coords')
#  delta1:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.1delta')
#  delta:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.delta')
#  mcoords:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.mcoords')
#  mdelta:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.mdelta')
#  qdiff:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.qdiff')
#  rdiff:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.rdiff')
#  snps:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.snps')
#  unqry:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.unqry')
#  unref:
#    type: File
#    outputBinding:
#      glob: $(inputs.query.nameroot + '.unref')

$namespaces:
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/
$schemas:
 - https://schema.org/version/latest/schema.rdf

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"

doc: |
  https://arxiv.org/abs/1604.03071
  http://cab.spbu.ru/files/release3.12.0/manual.html#meta
