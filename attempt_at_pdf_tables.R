#remotes::install_github(c("ropensci/tabulizerjars", "ropensci/tabulizer"))
                        
                        

library(tabulizer)


f <- here::here("california_dw20.pdf")

out1 <- extract_tables(f, pages = 1, output = "data.frame")

out1[[1]]

out1[[2]]

out1[[3]]


names(out1[[1]]) 
names(out1[[1]]) <- NULL
names(out1[[1]]) 

out1[[1]]


#remotes::install_github("ropensci/pdftools")


out2 <- extract_tables(f, pages = 2)

out2[[1]]

## tabulizer consistently reads first part of table badly b/c of header


library(pdftools)

test_tools <- pdftools::pdf_text(f) ##tried pdf_data and it also failed

look <- test_tools[1]


## this is a disaster