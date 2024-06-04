This repository contains the code for the [interactive browser](compbio2.mit.edu/epimap) of EpiMap data resource.

The project's main site can be found at [compbio.mit.edu/epimap](compbio.mit.edu/epimap).

You can run the browser directly on your computer using the code in this repository and the [`shiny`](https://shiny.rstudio.com/) library in R as follows:

```R
# Install shiny and other required packages:
pkgs = c('cba', 'DT', 'heatmaply', 'igraph', 'markdown', 'RColorBrewer', 
        'shiny', 'shinycssloaders', 'shinydashboard', 'shinyjs', 'shinythemes', 'shinyTree', 'shinyWidgets',
        'stringr', 'tidyr', 'visNetwork')

# Check for missing packages:
new.pkgs <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]

# Install the missing packages:
if (length(new.pkgs)) install.packages(new.pkgs, dependencies=TRUE)

# Download and run the app from github:
library(shiny)
runGitHub("epimap_vis", "cboix")
```

In addition, we have paper's analysis code on github at [https://github.com/cboix/epimap_analysis](https://github.com/cboix/epimap_analysis)

**Paper:** [Boix _et. al_ (2021)](https://www.nature.com/articles/s41586-020-03145-z/) - _Regulatory genomic circuitry of human disease loci by integrative epigenomics_

