#### About:

* Main website: [http://compbio.mit.edu/epimap/](http://compbio.mit.edu/epimap/)
* Paper: https://www.nature.com/articles/s41586-020-03145-z
* Contact: cboix@mit.edu

#### Tracks and Metadata

* Sample metadata table ([xlsx](https://personal.broadinstitute.org/cboix/epimap/metadata/Imputation_Metadata.xlsx), [tsv](https://personal.broadinstitute.org/cboix/epimap/metadata/main_metadata_table.tsv)).
* Track download ([bigWig files hosted by WUSTL](https://epigenome.wustl.edu/epimap/data/)).
* Average per-group and per-mark tracks ([bigWig files hosted by the Broad](https://personal.broadinstitute.org/cboix/epimap/averagetracks_bygroup/)).
* Track hub files ([WUSTL - json; and UCSC - txt](https://personal.broadinstitute.org/cboix/epimap/trackhubs/)).
* Chromatin state calls using ChromHMM ([hg19](https://personal.broadinstitute.org/cboix/epimap/ChromHMM/observed_aux_18_hg19/CALLS/), [hg38](https://personal.broadinstitute.org/cboix/epimap/ChromHMM/observed_aux_18_hg38/CALLS/)), calculated using the [18-state Roadmap model](https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html#exp_18state). 

####  Enhancers, Modules, and Enrichments:

* Enhancer locations: [directory](https://personal.broadinstitute.org/cboix/epimap/mark_matrices), [enhancers (0-ind)](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/ENH_masterlist_indices_0indexed.tsv), [promoters (0-ind)](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/PROM_masterlist_indices_0indexed.tsv); enh. matrix [hdf5](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/Enhancer_H3K27ac_intersect_matrix.hdf5), [mtx](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/Enhancer_H3K27ac_intersect_matrix.mtx.gz); prom. matrix [hdf5](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/Promoter_H3K27ac_intersect_matrix.hdf5), [mtx](https://personal.broadinstitute.org/cboix/epimap/mark_matrices/Promoter_H3K27ac_intersect_matrix.mtx.gz)
* Enhancer modules: [assignments](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data/cls_merge2_wH3K27ac100_300_assignments.loc.bed), [centers](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data/cls_merge2_wH3K27ac100_300_centers.tsv.gz), and [metadata directory](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data)
* Enrichments: [archetype motifs](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data/motifs_bkgdhs_cls_enrich.reduced.tsv.gz), [full motifs](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data/motifs_bkgdhs_cls.enrich.full.tsv.gz), [GO terms](https://personal.broadinstitute.org/cboix/epimap/extended_data/clusters_data/modules_GO_enrichments_matrix_ordered.tsv.gz)
* Motif enrichments are on JASPAR 2018, HOCOMOCOv11, and  HT-SELEX (Jolma, 2013). 
* Motifs are split into archetypes according to [Vierstra (2020)](https://www.vierstra.org/resources/motif_clustering)

#### GWAS enrichments:
**Note:** We have updated the site to correct for two implementation mistakes in the GWAS enrichment analysis:
1. The first mistake was that we calculated the enrichment in the wrong direction: instead of calculating the enrichment of SNPs in biosample enhancers as was previously done in Roadmap, we mistakenly calculated the enrichment of enhancers in GWAS lead SNPs. This led to _double-counting SNPs and inflated enrichment statistics in the case of multiple nearby enhancers within 2.5kb of the same lead SNP_, which were all counted as independently overlapping the same SNP, when in fact the multiple overlaps came from their genomic clustering in the same locus. 
2. The second mistake was that our FDR procedure only controlled for inflation due to multiple enhancers proximal to the same SNP, but not for the multiple hypothesis testing across many tissue-trait combinations, and thus _our original reported statistics correspond to nominal P-values rather than FDR-corrected P-values._

We have updated the GWAS enrichments page to add a revised analysis that 1) tests for enrichment of SNPs in biosamples and 2) has appropriate FDR control (at 1%, 2%, and 5% FDR).

The resources for the revised analysis can be found here:

* GWAS Enrichments (revised): [tsv](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_enrichment_summaries_alone.snpcentric.tsv.gz), and [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_enrichment_summaries_alone.snpcentric.Rda)
* GWAS Figures: [tree enrichments and SNP heatmaps](https://personal.broadinstitute.org/cboix/epimap/gwas_smallfigures/snpcentric/) and [GWAS loci](https://personal.broadinstitute.org/cboix/epimap/gwas_smallfigures/gwas_locus_figures/snpcentric/).
    * All plotted links in GWAS loci are given per-folder as either tsv.gz or Rda files.
* Enhancers near lead SNPs for enriched epigenomes: [tsv](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_snpxenhancer_intersections.snpcentric.tsv.gz) or [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_snpxenhancer_intersections.snpcentric.Rda)
* Directly linked genes: [tsv](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_gwas_SNP_links.snpcentric.tsv.gz) or [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_gwas_SNP_links.snpcentric.Rda)

The resources for the original analysis can be found here:

* GWAS Enrichments (original): [tsv (1%)](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_enrichment_summaries_alone.tsv.gz), [tsv (0.1%)](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_enrichment_summaries_alone_p1fdr.tsv.gz), and [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_enrichment_summaries_alone.Rda)
* GWAS Figures: [tree enrichments and SNP heatmaps](https://personal.broadinstitute.org/cboix/epimap/gwas_smallfigures/) and [GWAS loci](https://personal.broadinstitute.org/cboix/epimap/gwas_smallfigures/gwas_locus_figures/).
    * All plotted links in GWAS loci are given per-folder as either tsv.gz or Rda files.
* Enhancers near lead SNPs for enriched epigenomes: [tsv](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_snpxenhancer_intersections.tsv.gz) or [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_snpxenhancer_intersections.Rda)
* Directly linked genes: [tsv](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_gwas_SNP_links.tsv.gz) or [Rda](https://personal.broadinstitute.org/cboix/epimap/gwas_resources/all_gwas_SNP_links.Rda)

#### Linking:
* For each sample: [gene-enhancer links](https://personal.broadinstitute.org/cboix/epimap/links/)
* Aggregated for each sample group (Adipose, Brain, etc.): [gene-enhancer links](https://personal.broadinstitute.org/cboix/epimap/links/pergroup/)


