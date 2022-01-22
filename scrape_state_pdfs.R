

filename_part_one <- "https://www.epa.gov/sites/default/files/2020-11/documents/"

filename_part_two <- "_dw20.pdf"

state_names <- stringr::str_to_lower(state.name)

download_one_state <- function(state_name) {
  
  download.file(url = paste0(filename_part_one, state_name, filename_part_two),
                destfile = here::here("state_pdfs", paste0(state_name, filename_part_two)))
  
}

purrr::walk(state_names,download_one_state)
