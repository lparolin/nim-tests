# README

This repo contains some experiments with the language [Nim](https://nim-lang.org/).
The experiments focus on parsing traces generated from [nuSMV](https://nusmv.fbk.eu/index.html) and to create plots for showing their content in a graphical way.

Currently this tool has very limited capabilities. The tool parsers a trace
file generated in nuSMV and produces a csv and a sqlite data base file where
the trace data are stored. 
The input file where traces are generated must be named `input.tr` and must be
in the same folder where the nim executable is located. The trace must be
generated in verbose mode, i.e. at every step all of the variables must be
listed.

The application generates two files: `output.csv` and `output.db`


# Next planned features

  - [] Allow use of non-verbose trace input files
  - [] Allow users to select file name for the input file trace 
  - [] Allow users to specific output file location and format, i.e. sqlite, or
    csv, or sqlite and csv 
  - [] Allow generation of plots from the library

