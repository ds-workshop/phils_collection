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

# tar_source("other_functions.R") # Source other scripts as needed.

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
        )
)