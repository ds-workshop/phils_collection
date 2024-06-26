# what: functions for training user models

# load games
load_games = function(file = "data/raw/games") {
        
        qs::qread(file)
}

load_collection = function(file = "data/raw/collection.csv") {
        
        readr::read_csv(file)
}

# # not run
# library(bggUtils)
# collection = load_user_collection(username = 'phenrickson')

# function to create outcomes and set factors for user variables
prep_collection = function(collection, high_rating = 8) {
        
        # if less than 25 games ever owned, stop
        if (nrow(collection) < 25) {
                warning("low number of games; results from modeling likely unstable")
        } else if (nrow(collection) < 50) {
                warning("relatively few games in collection; results may not be reliable")
        }
        
        collection %>%
                mutate(ever_owned = case_when(own == 1 | prevowned == 1 ~ 'yes',
                                              TRUE ~ 'no'),
                       own = case_when(own == 1 ~ 'yes',
                                       TRUE ~ 'no'),
                       rated = case_when(!is.na(rating) ~ 'yes',
                                         TRUE ~ 'no'),
                       highly_rated = case_when(8 >= 8 ~ 'yes',
                                                TRUE ~ 'no')
                ) |>
                mutate(
                        across(
                                c("own","rated", "highly_rated"),
                                ~ factor(.x, levels = c("no", "yes"))
                        )
                )
        
}

# function to apply standardized preprocessing to games
preprocess_games = function(games,
                            ...) {
        
        games |>
                bggUtils::preprocess_bgg_games(...) |>
                dplyr::mutate(usersrated = tidyr::replace_na(usersrated, 0))
}

# join collection with bgg games
join_games_and_collection = function(games,
                                     collection) {
        
        # take games and 
        collection_and_games = 
                games |>
                left_join(
                        collection,
                        by = c("game_id", "name")
                )
        
        games_joined = 
                collection_and_games |>
                filter(!is.na(username)) |>
                nrow()
        
        # how many games in bgg
        print(
                glue::glue(nrow(games), " games from bgg")
        )
        
        # how many games joined
        print(
                glue::glue(games_joined, " games joined from collection")
        )
        
        collection_and_games |>
                mutate(username = unique(collection$username))
        
}
