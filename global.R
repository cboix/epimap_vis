#!/usr/bin/R
# UI side for imputation visualization:
library(shiny)
library(shinyjs)
library(shinyTree)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(shinyWidgets)
library(visNetwork)
library(markdown)
library(DT)
library(heatmaply)

options(scipen=45)

# Server:
source('auxiliary_plot_gwas.R')
source('auxiliary_trackhubs_functions.R')


# ----------------
# For sample tree:
# ----------------
# Make types list:
load('data/metadata_app.Rda')
meta$infostr = paste0(meta$id, ': ', meta$info)
meta$ctstr = paste0(meta$id, ': ', meta$ct)
gcols = colvals$group
groups.full = names(gcols)
groups = gsub("[& -.]","", tolower(groups.full))
names(gcols) = groups
typeslist = c("{", sapply(groups, function(x){ paste0("'",x,"': {'a_attr' : { 'style' : 'color:", gcols[x],"' }}, ") }), "}")
typeslist = paste(typeslist, collapse="")

# Reduce to kept 859 samples:
co859 = scan('data/859_samples.txt',quiet=TRUE, 'c', sep="\n")
cellorder = scan('data/833_samples.txt',quiet=TRUE, 'c', sep="\n")
meta = meta[meta$id %in% co859,]

# Server-specific changes:
meta$ct = gsub("_"," ",meta$ct) # For tables
# For plots:
metamat = cbind('lifestage'=meta$lifestage, 'sex'=meta$sex,
                'type'=meta$type, 'project'=meta$Project,
                'group'=as.character(meta$GROUP))
meta$type[is.na(meta$type)] = 'ENCODE'
rownames(metamat) = meta$id


# For picking marks:
all.assays = scan('data/all_assays.txt', quiet=TRUE, 'c', sep="\n")


# -------------------------
# For the preset trackhubs:
# -------------------------
resdir = "http://personal.broadinstitute.org/cboix/epimap/"
UCSCprefix = 'http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=http://personal.broadinstitute.org/cboix/epimap/trackhubs/'
UCSC38prefix = 'http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=http://personal.broadinstitute.org/cboix/epimap/trackhubs/'
WUSTLprefix = 'http://epigenomegateway.wustl.edu/legacy/?genome=hg19&datahub=http://personal.broadinstitute.org/cboix/epimap/trackhubs/'
WUSTLnewprefix = 'http://epigenomegateway.wustl.edu/browser/?genome=hg19&hub=http://personal.broadinstitute.org/cboix/epimap/trackhubs/'


# -------------------------
# For the GWAS enrichments:
# -------------------------
# Read in autocomplete list of GWAS:
tree.files = list(
    'original_1%'='data/tree_gwas_list.txt',
    'original_0.1%'='data/tree_gwas1p_list.txt',
    'revised_1%'='data/tree_gwas_snpcentric_list_1pct.txt',
    'revised_2%'='data/tree_gwas_snpcentric_list_2pct.txt',
    'revised_5%'='data/tree_gwas_snpcentric_list_5pct.txt')

treeGWASlist = list()
for (key in names(tree.files)){
    treeGWASlist[[key]] = scan(tree.files[[key]], quiet=TRUE, 'c', sep="\n")
}


# For tail of images:
pcutmap = c('0.1%' = '_pt1pct', '1%' = '_1pct', 
    '2%' = '_2pct', '5%' = '_5pct')

# For checkbox input in grid-style
tweaks <- list(tags$head(tags$style(HTML("
                                         .multicol { 
                                             height: 350px;
                                             -webkit-column-count: 3; /* Chrome, Safari, Opera */ 
                                                 -moz-column-count: 3;    /* Firefox */ 
                                                 column-count: 3; 
                                             -moz-column-fill: auto;
                                             -column-fill: auto;
                                         } 
                                         ")) 
                                         ))
group.checkboxes <- tags$div(align = 'left', class = 'multicol', 
                             checkboxGroupInput(inputId  = 'selGroups', 
                                                label    = "Restrict to sample groups:", 
                                                choices  = groups.full,
                                                selected = NULL,
                                                inline   = FALSE))


# Server load:
# ------------
load('data/gwascatalog_may03_2019_noquotes_summary.Rda') # GWAS summaries

# Make tierdf:
mainmarks = c('DNase-seq', 'H3K27ac','H3K27me3','H3K36me3','H3K4me1','H3K4me3','H3K9me3')
tier2marks = c("ATAC-seq", "H2AFZ", "H3K4me2", "H3K79me2", "H3K9ac", "H4K20me1")
tier3marks = c("POLR2A", "CTCF", "EP300", "RAD21", "SMC3")
tierdf = data.frame(mark = all.assays, tier = 't4')
tierdf$tier[tierdf$mark %in% mainmarks] = 't1'
tierdf$tier[tierdf$mark %in% tier2marks] = 't2'
tierdf$tier[tierdf$mark %in% tier3marks] = 't3'

# Colors for metadata tables:
mcols = c('GROUP','infoline','ct','lifestage','age','sex','type','Project','Donor')
rename.mcols = c('Group','Short name','Full name','Lifestage','Age','Sex','Type','Project','Donor')
# For colors/ordering:
odf = read.delim('data/group_ordering.tsv', header=T, stringsAsFactors=F)
clvs = c('Tissue', 'Primary Cell', 'Immune', 'Neural', 'Stem-like', 'Other')
odf$category = factor(odf$category, levels=clvs)
rdcol = unique(meta[,c('GROUP','COLOR')])
rdcol = rdcol[order(rdcol$GROUP),]
colset = as.character(rdcol$COLOR)
odf$alt = sub(" \\& ","/", odf$GROUP)

# Mapping from colors <-> groups
col2group = odf$GROUP
col2alt = odf$alt
group2col = odf$COLOR
names(col2group) = odf$COLOR
names(col2alt) = odf$COLOR
names(group2col) = odf$GROUP

# URLs:
epidir = 'https://personal.broadinstitute.org/cboix/epimap/'

# For loading RDa with no duplicates:
rda2list <- function(file) {
    e <- new.env()
    load(file, envir = e)
    as.list(e)
}

# Reactive values for keeping track of images:
imgTrack <- reactiveValues(newLocusImg=0)


