# Base image https://hub.docker.com/u/oliverstatworx/
FROM rocker/tidyverse

## create directories
RUN mkdir -p /milenio
RUN mkdir -p /milenio/output

## copy files
COPY milenioRNogales01.R milenio/milenioRNogales01.R
COPY PSO20220223.xls milenio/PSO20220223.xls
COPY installPackages.R milenio/installPackages.R

## run the script
RUN Rscript milenio/installPackages.R
CMD Rscript milenio/milenioRNogales01.R
