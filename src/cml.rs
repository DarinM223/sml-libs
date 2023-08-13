//! The [CML lib][1].
//!
//! [1]: http://cml.cs.uchicago.edu/

use crate::files;

/// The files.
pub const FILES: &[(&str, &str)] = files![
    "cml/core_cml/core-cml.sml",
    "cml/cml_lib/cml-lib.sml",
];