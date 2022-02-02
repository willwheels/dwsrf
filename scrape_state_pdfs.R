library(rvest)

library(dplyr)

## got the following by clicking through https://www.epa.gov/dwsrf/drinking-water-state-revolving-fund-national-information-management-system-reports
# https://www.epa.gov/sites/default/files/2020-11/documents/alabamadw20_0.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/alaskadw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/arizonadw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/arkansasdw20_0.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/california_dw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/colorado_dw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/connecticut_dw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/delaware_dw20.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/florida_2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/georgia_2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/hawaii2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/idaho_2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/illinois2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/indiana2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/iowa_2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/kansas2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/kentucky.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/louisiana2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/maine2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/maryland.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/massachusetts2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/michigan2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/minnesota2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/mississippi2020.pdf
# https://www.epa.gov/sites/default/files/2020-11/documents/missouri2020.pdf

## nothing for DC, apparently

## run once

# state_names <- stringr::str_to_lower(state.name) %>%
#   stringr::str_replace_all(" ", "-")
# 
# state_links <- tibble(state_name = state.name, state_pdf_url = rep("", length(state.name)))
# PR <- tibble(state_name = "Puerto Rico", state_pdf_url = "")
# state_links <- rbind(state_links, PR)
# 
# write.csv(state_links, "state_links.csv")




download_one_state_pdf <- function(pdf_link) {

  
  if (pdf_link %in% c("/sites/default/files/2019-12/documents/oklahoma_dwsrf_2019_rpt.pdf",
                      "/sites/default/files/2019-12/documents/west_virginia_dwsrf_2019_rpt.pdf")
      ) {
    
    pdf_base_url <- "https://www.epa.gov"
    
    filename_use <- stringr::str_replace(pdf_link, "/sites/default/files/2019-12/documents/", "")
    
    download.file(url = paste0(pdf_base_url, pdf_link),
                  destfile = here::here("state_pdfs", paste0(filename_use)))
  }
  
  else {
    
    pdf_base_url <- "https://www.epa.gov"
    
    filename_use <- stringr::str_replace(pdf_link, "/sites/default/files/2020-11/documents/", "")
    
    download.file(url = paste0(pdf_base_url, pdf_link),
                  destfile = here::here("state_pdfs", paste0(filename_use)),
                  mode = "wb")
  
    

  }
}

purrr::walk(state_pdf_links$state_pdf_url,download_one_state_pdf)


## this works w/ addition of mode = "wb" to download.file
download_one_state_pdf("/sites/default/files/2020-11/documents/texas_2020.pdf")


all_state_pdfs <- list.files(here::here("state_pdfs"), full.names = TRUE)

all_state_pdfs_df <- purrr::map_dfr(all_state_pdfs, 
                                    pdftools::pdf_info,
                                    .id = "state")

summary(all_state_pdfs_df$pages)
