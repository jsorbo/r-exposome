?quantile

# https://stackoverflow.com/questions/7508229/how-to-create-a-column-with-a-quartile-rank
quints <- within(merged, quintile <- as.integer(cut(educationHighSchoolOrAboveRate, quantile(educationHighSchoolOrAboveRate, probs=0:5/5), include.lowest=TRUE)))

quints

append_quintile_column <- function(df, column) {
  df <- within(df, new_quintile <- as.integer(cut(df[,column], quantile(df[,column], probs=0:5/5), include.lowest=TRUE)))
  new_col_name <- paste0(column, "_quintile")
  names(df)[ncol(df)] <- new_col_name
  return(df)
}

append_ntile_column <- function(df, column, n) {
  df <- within(df, new_quintile <- as.integer(cut(df[,column], quantile(df[,column], probs=0:n/n), include.lowest=TRUE)))
  new_col_name <- paste0(column, "_", n, "tile")
  names(df)[ncol(df)] <- new_col_name
  return(df)
}

append_quintile_column <- function(df, column) {
  return(append_ntile_column(df, column, 5))
}

convert_quintile_to_binary <- function(df, column) {
  for (i in 1:5) {
    df <- within(df, new_col <- as.integer(ifelse(df[column] == i, 1, 0)))
    new_col_name <- paste0(column, "_", i)
    names(df)[ncol(df)] <- new_col_name
  }
  return(df)
}

merged <- append_quintile_column(merged, "educationHighSchoolOrAboveRate")
merged <- convert_quintile_to_binary(merged, "educationHighSchoolOrAboveRate_5tile")
merged
