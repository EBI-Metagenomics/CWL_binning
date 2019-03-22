class: ExpressionTool
cwlVersion: v1.0
requirements:
  InlineJavascriptRequirement: {}


# Tool to map pairs of mags/reference filenames back to the file references

inputs:
  mag_names:
    type: string[]
  ref_names:
    type: string[]
  mag_files:
    type: File[]
  reference_files:
    type: File[]

outputs:
  mags: File[]
  refs: File[]

expression: |
  ${
    basename = function basename(path){
      return path.split('/').pop()
    }
    var mag_files = {};
    for (var i = 0; i < inputs.mag_files.length; i++) {
        var mag = inputs.mag_files[i];
        mag_files[mag['basename']] = mag;
    }
    var ref_files = {};
    for (var i = 0; i < inputs.reference_files.length; i++) {
        var ref = inputs.reference_files[i];
        ref_files[ref['basename']] = ref;
    }
    function basename(str, sep) {
      return str.substr(str.lastIndexOf(sep) + 1);
    }
    var mags = []
    var refs = []
    for (var i=0; i<inputs.mag_names.length; i++){
        mags.push(mag_files[basename(inputs.mag_names[i])])
        refs.push(ref_files[basename(inputs.ref_names[i])])
    }
    return {'mags': mags, 'refs': refs}
  }