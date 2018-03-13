library(tibble)
library(dplyr)
library(tidyr)
library(ggplot2)

Pubmed <- list()
Pubmed$winnonlin <- readLines("http://dan.corlan.net/cgi-bin/medline-trend?Q=winnonlin")
Pubmed$nonmem <- readLines("http://dan.corlan.net/cgi-bin/medline-trend?Q=nonmem")

PubmedPrep <- function(x) data.frame(raw = Pubmed[[x]]) %>%
    filter(!grepl("Medline|Number|PRE", raw)) %>%
    mutate(raw = trimws(raw)) %>%
    separate(col = "raw", into = c("number", "year", "freq"), sep = "[^[:alnum:]|^.]+") %>%
    mutate_all(as.numeric) %>%
    mutate(term = x)

Dataset <- bind_rows(lapply(names(Pubmed), PubmedPrep))

save(Dataset, file = "~/shanmdphd/pubmed/Dataset.Rdata")

##
load("~/shanmdphd/pubmed/Dataset.Rdata")

ggplot(Dataset, aes(x=year, y=number, colour=term, group=term)) +
    geom_line()

ggplot(Dataset, aes(x=year, y=freq, colour=term, group=term)) +
    geom_line()
