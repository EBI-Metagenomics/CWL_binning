class: Workflow
cwlVersion: v1.0

requirements:
  MultipleInputFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  contigs:
    type: File
  reads:
    type: File[]

outputs:
  refined_bins:
    type: File[]
    outputSource: bin_refinement/bins

steps:
  metawrap_binning:
    in:
      contigs: contigs
      reads: reads
    out:
      - concoct_bins
      - metabat2_bins
      - maxbin2_bins
    run: ../tools/metawrap_binning.cwl

  bin_refinement:
    in:
      concoct_bin_dir: metawrap_binning/concoct_bins
      metabat_bin_dir: metawrap_binning/metabat2_bins
      maxbin_bin_dir: metawrap_binning/maxbin2_bins
    out:
      - bins
    run: ../tools/metawrap_bin_refinement.cwl

$namespaces:
 edam: http://edamontology.org/
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/