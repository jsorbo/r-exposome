append_ntile_column <- function(df, column, n) {
  df <- within(df, new_quintile <- as.integer(cut(df[,column], quantile(df[,column], probs=0:n/n), include.lowest=TRUE)))
  new_col_name <- paste0(n, "tile.", column)
  names(df)[ncol(df)] <- new_col_name
  return(df)
}

append_quintile_column <- function(df, column) {
  return(append_ntile_column(df, column, 5))
}

convert_ntile_to_binary <- function(df, column, n) {
  for (i in 1:n) {
    df <- within(df, new_col <- as.integer(ifelse(df[column] == i, 1, 0)))
    new_col_name <- paste0(column, ".", i)
    names(df)[ncol(df)] <- new_col_name
  }
  return(df)
}

convert_quintile_to_binary <- function(df, column) {
  return(convert_ntile_to_binary(df, column, 5))
}

convert_vector_of_columns_to_binary <- function(df, columns) {
  for (column in columns) {
    df <- append_quintile_column(df, column)
    colname <- paste0("5tile.", column)
    df <- convert_quintile_to_binary(df, colname)
  }
  return(df)
}

