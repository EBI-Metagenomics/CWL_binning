#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "mash_diff: Fast sequence distance estimator that uses MinHash"

requirements:
  DockerRequirement:
    dockerPull: "python:2.7-alpine"
  InlineJavascriptRequirement: {}

baseCommand: ['python']


inputs:
  script_file:
    type: File?
    default:
      class: File
      location: ./parse_dnadiff.py
    inputBinding:
      position: 1

  dnadiff_reports:
    type: File[]
    inputBinding:
      position: 2
  best_mash_table:
    type: File
    inputBinding:
      prefix: --mash-table
      position: 3


stdout: mash_report.txt
stderr: stderr.txt

outputs:
  mash_report:
    type: stdout

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
