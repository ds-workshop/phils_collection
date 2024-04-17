# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
        # global packages used in pipleine
        packages = c("tibble",
                     "dplyr",
                     "rsample",
                     "tidymodels",
                     "quarto",
                     "visNetwork",
                     "bggUtils"),
        # default format for storing targets
        format = "qs",
        seed = 1999
)

# functions used in project
tar_source("src/data/load_data.R")
tar_source("src/models/splitting.R")

# tar_source("other_functions.R") # Source other scripts as needed.

# global objects defining the functions
end_train_year = 2021
valid_years = 2
min_ratings = 25

# Replace the target list below with your own:
list(
        tar_target(
                name = games,
                command = 
                        load_games(
                                file = 'data/raw/games'
                        )
        ),
        tar_target(
                name = games_processed,
                command = 
                        games |>
                        preprocess_games()
        ),
        tar_target(
                name = collection,
                command = 
                        load_collection()
        ),
        tar_target(
                name = collection_and_games,
                command = 
                        join_games_and_collection(
                                games_processed,
                                collection
                        ) |>
                        prep_collection()
        ),
        tar_target(
                name = split,
                command = 
                        collection_and_games |>
                        split_by_year(
                                end_train_year = end_train_year
                        )
        ),
        tar_target(
                name = train_data,
                command = 
                        split |>
                        analysis() |>
                        filter(usersrated >=min_ratings)
        ),
        tar_target(
                name = test_data,
                command = 
                        split |>
                        assessment()
        ),
        tar_target(
                name = valid_split,
                command = 
                        train_data |>
                        split_by_year(
                                end_train_year = end_train_year-valid_years
                        )
        )
)