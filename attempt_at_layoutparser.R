
## following directions from https://support.rstudio.com/hc/en-us/articles/1500007929061-Using-Python-with-the-RStudio-IDE

if (!require("reticulate")) {
  install.packages("reticulate")
}

## install some python
reticulate::install_miniconda()

reticulate::py_install("layoutparser")
## this didn't work, apparently need pip not conda..