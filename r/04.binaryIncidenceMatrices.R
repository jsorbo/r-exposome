merged <- convert.vector.of.columns.to.binary(merged, column.list.paraclique)

merged <- convert.vector.of.columns.to.binary(merged, column.list.all)

arulesdataset <- convert.quintile.to.binary(merged, "Quintiles")

merged <- convert.vector.of.columns.to.binary(merged, column.list.all)

merged <- convert.vector.of.columns.to.quintiles(merged, column.list.paraclique)

merged <- convert.vector.of.columns.to.quintiles(merged, column.list.all)

