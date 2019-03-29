class: Workflow
cwlVersion: v1.0

requirements:
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  bins:
    type: File[]
    inputBinding:
  ani_threshold:
    type: float?
    default: 0.9
  ani_threshold_secondary:
    type: float?
    default: 0.95
  min_cov_threshold:
    type: float?
    default: 0.6
  coverage_method:
    type: string?
    default: 'larger'
  completeness:
    type: int?
    default: 50
  contamination:
    type: int?
    default: 5

outputs:
  output_folder:
    type: Directory
    outputSource: gtdb/output_folder


steps:
  drep:
    in:
      bins: bins
      ani_threshold: ani_threshold
      ani_threshold_secondary: ani_threshold_secondary
      min_cov_threshold: min_cov_threshold
      coverage_method: coverage_method
      completeness: completeness
      contamination: contamination
    out:
      - genomes
    run: ../tools/drep.cwl

  gtdb:
    in:
      genomes: drep/genomes
    out:
      - output_folder
    run: ../tools/gtdbtk.cwl

$namespaces:
 edam: http://edamontology.org/
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/