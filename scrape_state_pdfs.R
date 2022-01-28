library(rvest)
library(dplyr)

## got the following by clicking through https://www.epa.gov/dwsrf/drinking-water-state-revolving-fund-national-information-management-system-reports

## nothing for DC, apparently

filename_part_one <- "https://www.epa.gov/dwsrf/drinking-water-state-revolving-fund-program-information-state-"

state_names <- stringr::str_to_lower(state.name) %>%
  stringr::str_replace_all(" ", "-")

download_one_state <- function(state_name) {
  
  print(state_name)
  
  state_dwsrf_url <- paste0(filename_part_one, state_name)
  
  state_dwsrf_page <- read_html(state_dwsrf_url)
  
  state_dwsrf_page_urls <- state_dwsrf_page %>%
    html_elements("a") %>%
    html_attr("href")
  
  state_dwsrf_page_return <- tibble(state = state_name, state_url = state_dwsrf_url,
                                       state_pdf_url = state_dwsrf_page_urls)
  
  state_dwsrf_page_return <- state_dwsrf_page_return %>%
    filter(stringr::str_detect(state_pdf_url, "pdf"))
  
  return(state_dwsrf_page_return)
  
}

state_pdf_links <- purrr::map_dfr(state_names, download_one_state)


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
                  destfile = here::here("state_pdfs", paste0(filename_use)))
  
    

  }
}

purrr::walk(state_pdf_links$state_pdf_url,download_one_state_pdf)


all_state_pdfs <- list.files(here::here("state_pdfs"), full.names = TRUE)

all_state_pdfs_df <- purrr::map_dfr(all_state_pdfs, 
                                    pdftools::pdf_info,
                                    .id = "state")

summary(all_state_pdfs_df$pages)
