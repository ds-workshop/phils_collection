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
                 "glmnet",
                 "bonsai",
                 "lightgbm",
                 "quarto",
                 "visNetwork",
                 "bggUtils"),
    # default format for storing targets
    format = "qs",
    # set memory to transient
    memory = "transient",
    seed = 1999
)

# functions used in project
tar_source("src/")

# global objects referenced in pipeline
end_train_year = 2021
valid_years = 2
min_ratings = 100

# function to create model board
model_board = function(path = "models",
                       versioned = T) {
    
    pins::board_folder(path = path,
                       versioned = T)
    
}

# tar_source("other_functions.R") # Source other scripts as needed.
# Replace the target list below with your own:
list(
    # data
    tar_target(
        games_file,
        command = 'data/raw/games',
        format = 'file'
    ),
    tar_target(
        collection_file,
        command = 'data/raw/collection.csv',
        format = 'file'
    ),
    # load in datasets
    tar_plan(
        games = 
            load_games(games_file),
        collection = 
            load_collection(collection_file),
        games_prepared = 
            games |> 
            preprocess_games(),
        collection_and_games = 
            join_games_and_collection(games_prepared,
                                      collection = collection) |>
            prep_collection()
    ),
    # create a training/test set for the user based on years
    tar_target(
        split,
        collection_and_games |>
            split_by_year(end_train_year,
                          min_ratings)
    ),
    # extract test data; set aside to predict at the end
    tar_target(
        test_data,
        split |>
            testing()
    ),
    # extract train data
    tar_target(
        train_data,
        split |>
            training()
    ),
    # use this to create an additional validation split
    tar_target(
        valid_split,
        train_data |>
            split_by_year(end_train_year - valid_years,
                          min_ratings)
    ),
    # create recipe
    tar_target(
        recipe,
        valid_split |>
            training() |>
            build_recipe(outcome = own)
    ),
    # create recipe for linear models
    tar_target(
        linear_recipe,
        recipe |>
            add_bgg_preprocessing() |>
            add_linear_preprocessing()
    ),
    # create recipe for trees
    tar_target(
        trees_recipe,
        recipe |>
            add_bgg_preprocessing()
    ),
    # create model specs
    # logistic regression
    tar_target(
        glmnet_mod,
        logistic_reg(penalty = tune::tune(),
                     mixture = tune::tune()) |>
            set_engine("glmnet")
    ),
    # lightgbm
    tar_target(
        lightgbm_mod,
        boost_tree(mode = "classification",
                   trees = tune::tune(),
                   min_n = tune::tune(),
                   tree_depth = tune::tune()) |>
            set_engine("lightgbm", 
                       objective = "binary")
    ),
    # workflows
    tar_target(
        glmnet_wflow,
        command = 
            workflow() |>
            add_model(glmnet_mod) |>
            add_recipe(linear_recipe)
    ),
    tar_target(
        lightgbm_wflow,
        command = 
            workflow() |>
            add_model(lightgbm_mod) |>
            add_recipe(trees_recipe)
    ),
    # control tuning
    tar_target(
        tune_control,
        command = 
            control_grid(verbose = T,
                         save_pred = T,
                         save_workflow = T,
                         event_level = 'second')
    ),
    # set metrics for evaluation
    tar_target(
        my_metrics,
        command = 
            yardstick::metric_set(yardstick::roc_auc,
                                  yardstick::pr_auc,
                                  yardstick::mn_log_loss)
    ),
    # tune models on validation set
    # glmnet
    tar_target(
        glmnet_tuned,
        command = 
            glmnet_wflow |>
            tune_grid(
                resamples = valid_split |> make_rset(),
                grid = glmnet_grid(),
                metrics = my_metrics,
                control = tune_control
            )
    ),
    # lightgbm 
    tar_target(
        lightgbm_tuned,
        command = 
            lightgbm_wflow |>
            tune_grid(
                resamples = valid_split |> make_rset(),
                grid = 10,
                metrics = my_metrics,
                control = tune_control
            )
    ),
    # convert to workflow set
    tar_target(
        wflows,
        command = 
            as_workflow_set(
                "glmnet_full_features" = glmnet_tuned,
                "lightgbm_full_features" = lightgbm_tuned
            )
    ),
    # tuning plot
    tar_target(
        wflows_plot,
        command = 
            wflows |>
            autoplot(type = 'wflow_id')
    ),
    # collect results from worfklow sets
    tar_target(
        valid_metrics,
        wflows |>
            rank_results(rank_metric = 'mn_log_loss')
    ),
    # fit best model based on log loss;
    # this will dynamically select the best model from those in the workflow set
    tar_target(
        best_wflow,
        command = 
            wflows |>
            select_best_wflow(metric = 'mn_log_loss')
    ),
    tar_target(
        best_model,
        command = 
            wflows |>
            filter(wflow_id == best_wflow) |>
            fit_best(metric = 'mn_log_loss')
    ),
    # convert to vetiver
    tar_target(
        vetiver_model,
        command = 
            best_model |> 
            vetiver::vetiver_model(
                model_name = best_wflow,
                metadata = list(split = split,
                                end_train_year = end_train_year,
                                metrics = valid_metrics
                )
            )
    ),
    # pin model
    tar_target(
        model_meta,
        command = 
            vetiver_model |>
            pin_model(board = model_board())
    ),
    # render quarto report
    tar_quarto(
        model_report,
        "model_report.qmd"
    )
    # # predict test data
    # tar_target(
    #     test_preds,
    #     vetiver_model |>
    #         augment(test_data)
    # ),
    # # evaluate test results
    # tar_target(
    #     test_metrics,
    #     test_preds |>
    #         my_metrics(truth = own,
    #                    .pred_yes,
    #                    event_level = 'second')
    # )
)