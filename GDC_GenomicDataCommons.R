# GDCquery: Query GDC data
# https://rdrr.io/bioc/TCGAbiolinks/man/GDCquery.html

# TCGAbiolinks: TCGAbiolinks: An R/Bioconductor package for integrative analysis with GDC data
# https://rdrr.io/bioc/TCGAbiolinks/

library(TCGAbiolinks)

query <- GDCquery(project = "TCGA-ACC",
                  data.category = "Copy Number Variation",
                  data.type = "Copy Number Segment")

query.met <- GDCquery(project = c("TCGA-GBM","TCGA-LGG"),
                      legacy = TRUE,
                      data.category = "DNA methylation",
                      platform = "Illumina Human Methylation 450")

# R/response.R
# https://rdrr.io/bioc/GenomicDataCommons/src/R/response.R

#*# The GenomicDataCommons Package #*#
# https://www.bioconductor.org/packages/devel/bioc/vignettes/GenomicDataCommons/inst/doc/overview.html

#*# Package ‘GenomicDataCommons’ #*#
# https://www.bioconductor.org/packages/devel/bioc/manuals/GenomicDataCommons/man/GenomicDataCommons.pdf

#*# github #*#
# https://github.com/Bioconductor/GenomicDataCommons/blob/master/R/gdcdata.R

library(GenomicDataCommons)

### Check connectivity and status
GenomicDataCommons::status()

#
res = files(legacy = TRUE) %>% 
      facet(c('type','data_category','data_type')) %>% 
      aggregations()
res$data_category
res$data_type

### Find data

#  ge_manifest = files() %>%
#  filter( cases.project.project_id == 'TCGA-OV') %>% 
#  filter( type == 'gene_expression' ) %>%
#  filter( analysis.workflow_type == 'HTSeq - Counts')  %>%
#  manifest()
ge_manifest = files(legacy = TRUE) %>%
#  filter( data_category == 'Raw microarray data' ) %>%
  filter( data_category == 'DNA methylation' ) %>%
  manifest()
head(ge_manifest)

### Download data
fnames = lapply(ge_manifest$id[1:20],gdcdata)
#fnames = lapply(ge_manifest$id,gdcdata)

fnames = lapply(ge_manifest$id[1:20],gdcdata(legacy = TRUE))
fnames = gdcdata(ge_manifest$id[1],legacy = TRUE)
fnames = gdcdata(ge_manifest$id[1])

# # legacy data
# exon <- files(legacy = TRUE) %>%
#   filter( ~ cases.project.project_id == "TCGA-COAD" &
#             data_category == "Gene expression" &
#             data_type == "Exon quantification") %>%
#   results(size = 1) %>% ids()
# gdcdata(exon,legacy = TRUE)

### Metadata queries
# 1
case_ids = cases() %>% results(size=20) %>% ids()
clindat = gdc_clinical(case_ids)
names(clindat)

##