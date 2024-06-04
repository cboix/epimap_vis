This repository contains the code for the [interactive browser](https://cboix.shinyapps.io/epimap_vis/) of EpiMap data resource.

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

In addition, we have manuscript analysis code on github at [https://github.com/cboix/epimap_analysis](https://github.com/cboix/epimap_analysis)

---

**Manuscript:** [Adsera _et. al_ bioRxiv (2019)](https://www.biorxiv.org/content/10.1101/810291v2) - _Integrative analysis of 10,000 epigenomic maps across 800 samples for regulatory genomics and disease dissection_
