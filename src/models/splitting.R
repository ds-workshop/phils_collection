# function to split collection based on yearpublished
split_by_year <- function(data,
                          end_train_year,
                          min_ratings = 100) {
  train <-
    data |>
    filter(yearpublished <= end_train_year) |>
    filter(usersrated >= min_ratings)

  test <-
    data |>
    filter(yearpublished > end_train_year)

  make_splits(
    list(
      analysis =
        seq(nrow(train)),
      assessment =
        nrow(train) + seq(nrow(test))
    ),
    bind_rows(train, test)
  )
}

make_rset = function(rsplit) {
    
    indices = list(
        list(analysis = rsplit$in_id,
             assessment = rsplit$out_id
        )
    )
    
    splits = lapply(indices, make_splits, data = rsplit$data)
    
    manual_rset(splits, c("validation"))
    
}
