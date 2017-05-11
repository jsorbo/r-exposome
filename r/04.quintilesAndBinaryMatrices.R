################################################################################
# Convert numerics to quintiles to prepare for clustering and decision trees

merged <- convert.vector.of.columns.to.quintiles(merged, column.list.paraclique)

merged <- convert.vector.of.columns.to.quintiles(merged, column.list.all)

################################################################################
# Create binary incidence matrices to prepare for arules (work in progress)

merged <- convert.vector.of.columns.to.binary(merged, column.list.paraclique)

merged <- convert.vector.of.columns.to.binary(merged, column.list.all)

arulesdataset <- convert.quintile.to.binary(merged, "Quintiles")
