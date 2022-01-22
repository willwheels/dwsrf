


reticulate::py_install("tabula-py")

import tabula

file1 = "california_dw20.pdf"
table = tabula.read_pdf(file1,pages=1)

table[0]

table[1]

## still get a thing where the table on the first page of a set doesn't have enough columns
