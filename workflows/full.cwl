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
  contigs:
    type: File
  reads:
    type: File[]
#  reference_fastas:
#    type: File[]

outputs:
  concoct_bins:
    type: Directory
    outputSource: metawrap_binning/concoct_bins
  metabat2_bins:
    type: Directory
    outputSource: metawrap_binning/metabat2_bins
  maxbin2_bins:
    type: Directory
    outputSource: metawrap_binning/maxbin2_bins

  refined_bins:
    type: File[]
    outputSource: bin_refinement/bins


#  reference_msh:
#    type: File
#    outputSource: mash_sketch/msh
#
#  dna_mash_table:
#    type: File
#    outputSource: mash_dist/table
#
#  best_mash_table:
#    type: File
#    outputSource: best_mash_match/table
#
#  dnadiffs:
#    type: File[]
#    outputSource: dnadiff/report
#
#  mash_report:
#    type: File
#    outputSource: parse_dnadiff/mash_report

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

#  mash_sketch:
#    in:
#      reference_fastas: reference_fastas
#    out:
#      - msh
#    run: ../tools/mash_sketch.cwl
#
#  mash_dist:
#    in:
#      reference: mash_sketch/msh
#      bin_files:
#        source: [bin_refinement/bins_a, bin_refinement/bins_b, bin_refinement/bins_c]
#        linkMerge: merge_flattened
#    out:
#      - table
#    run: ../tools/mash_dist.cwl
#
#  best_mash_match:
#    in:
#      table_file: mash_dist/table
#    out:
#      - mags
#      - refs
#      - table
#    run: ../tools/best_mash.cwl
#
#  file_finder:
#    in:
#      mag_names: best_mash_match/mags
#      ref_names: best_mash_match/refs
#      mag_files:
#        source: [bin_refinement/bins_a, bin_refinement/bins_b]
#        linkMerge: merge_flattened
#      reference_files: reference_fastas
#    out:
#      - mags
#      - refs
#    run: ../tools/file_finder.cwl
#
#  dnadiff:
#    scatter:
#      - reference
#      - query
#    scatterMethod: dotproduct
#    in:
#      reference: file_finder/refs
#      query: file_finder/mags
#    out:
#      - report
#    run: ../tools/dnadiff.cwl
#
#  parse_dnadiff:
#    in:
#      dnadiff_reports: dnadiff/report
#      best_mash_table: best_mash_match/table
#    out:
#      - mash_report
#    run: ../tools/parse_dnadiff.cwl

$namespaces:
 edam: http://edamontology.org/
 iana: https://www.iana.org/assignments/media-types/
 s: http://schema.org/