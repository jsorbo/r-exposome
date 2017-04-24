merged <- convert.vector.of.columns.to.binary(merged, column.list.paraclique)

merged <- convert.vector.of.columns.to.binary(merged, column.list.pca)

merged <- convert.vector.of.columns.to.binary(merged, column.list.pca.subset.1)

merged <- convert.vector.of.columns.to.binary(merged, column.list.pca.subset.2)

arulesdataset <- convert.quintile.to.binary(merged, "Quintiles")

merged <- convert.vector.of.columns.to.binary(merged, column.list.pca)
