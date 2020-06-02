#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "mash_diff: Fast sequence distance estimator that uses MinHash"

requirements:
  DockerRequirement:
    dockerPull: "aaronmussig/gtdbtk gtdbtk"
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - ../gtdbtk_db/

baseCommand: ['gtdbtk','classify_wf']


arguments:
  - valueFrom: $(runtime.cores)
    prefix: --cpus

inputs:
  genomes:
    type: Directory
    inputBinding:
      prefix: --genome_dir
  out_dir:
    type: string?
    default: out_folder
    inputBinding:
  prefix:
    type: string?
    inputBinding:
      prefix: --prefix

stdout: stdout.txt
stderr: stderr.txt

outputs:
  output_folder:
    type: Directory
    outputBinding:
      glob: $(inputs.out_dir)

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
