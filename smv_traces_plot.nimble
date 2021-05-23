# Package

version       = "0.1.0"
author        = "Luca Parolini"
description   = "Utility for plotting traces generated from nuSMV"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["smv_traces_plot"]


# Dependencies

requires "nim >= 0.19.4"
requires "norm"
