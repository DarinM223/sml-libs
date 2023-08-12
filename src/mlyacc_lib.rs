//! The [MLYACC lib][1].
//!
//! [1]: http://www.mlton.org/MLYacc

use crate::files;

/// The files.
pub const FILES: &[(&str, &str)] = files![
    "mlyacc_lib/base.sml",
    "mlyacc_lib/join.sml",
    "mlyacc_lib/lrtable.sml",
    "mlyacc_lib/stream.sml",
    "mlyacc_lib/parser2.sml",
];