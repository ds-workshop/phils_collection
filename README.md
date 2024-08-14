# README


# phils_collection

can you predict which board games phil wants to add to his collection?

this project illustrates using `targets` to create a predictive modeling
pipeline with `tidymodels`. this pipeline produces a `vetiver` model and
a model report card.

``` mermaid
graph LR
  style Legend fill:#FFFFFF00,stroke:#000000;
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Legend
    direction LR
    xf1522833a4d242c5([""Up to date""]):::uptodate --- xd03d7c7dd2ddda2b([""Stem""]):::none
  end
  subgraph Graph
    direction LR
    xeffe44ed84879274(["model_meta"]):::uptodate --> xba368001e67990cc(["model_report"]):::uptodate
    x1bddabfef734c169(["my_metrics"]):::uptodate --> xba368001e67990cc(["model_report"]):::uptodate
    xbb782543df7528d1(["test_data"]):::uptodate --> xba368001e67990cc(["model_report"]):::uptodate
    xe0bb173f910bd7f0(["valid_metrics"]):::uptodate --> xba368001e67990cc(["model_report"]):::uptodate
    x3983243dd18164e7(["wflows_plot"]):::uptodate --> xba368001e67990cc(["model_report"]):::uptodate
    x004377234d3bacac(["recipe"]):::uptodate --> xc88728c0e923dd78(["linear_recipe"]):::uptodate
    x574e5c623f867900(["games"]):::uptodate --> x1e01b6b8e5aa4e61(["games_prepared"]):::uptodate
    x7c91a03970e15376(["valid_split"]):::uptodate --> x004377234d3bacac(["recipe"]):::uptodate
    xf7b68bfa4f5b3a26(["glmnet_tuned"]):::uptodate --> xfcd66df9fb8c7e8a(["wflows"]):::uptodate
    x3045fd98bf132297(["lightgbm_tuned"]):::uptodate --> xfcd66df9fb8c7e8a(["wflows"]):::uptodate
    xf06d6eef7829004f(["glmnet_wflow"]):::uptodate --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::uptodate
    x1bddabfef734c169(["my_metrics"]):::uptodate --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::uptodate
    xbd276234e7c5b0df(["tune_control"]):::uptodate --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::uptodate
    x7c91a03970e15376(["valid_split"]):::uptodate --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::uptodate
    xeffe44ed84879274(["model_meta"]):::uptodate --> x0f09e4c17eb3276c(["test_metrics"]):::uptodate
    x1bddabfef734c169(["my_metrics"]):::uptodate --> x0f09e4c17eb3276c(["test_metrics"]):::uptodate
    xbb782543df7528d1(["test_data"]):::uptodate --> x0f09e4c17eb3276c(["test_metrics"]):::uptodate
    xad2d2a7a16304874(["lightgbm_wflow"]):::uptodate --> x3045fd98bf132297(["lightgbm_tuned"]):::uptodate
    x1bddabfef734c169(["my_metrics"]):::uptodate --> x3045fd98bf132297(["lightgbm_tuned"]):::uptodate
    xbd276234e7c5b0df(["tune_control"]):::uptodate --> x3045fd98bf132297(["lightgbm_tuned"]):::uptodate
    x7c91a03970e15376(["valid_split"]):::uptodate --> x3045fd98bf132297(["lightgbm_tuned"]):::uptodate
    xfcd66df9fb8c7e8a(["wflows"]):::uptodate --> x3983243dd18164e7(["wflows_plot"]):::uptodate
    xe28457b7180d9865(["split"]):::uptodate --> x50558fc6e6286095(["train_data"]):::uptodate
    xe28457b7180d9865(["split"]):::uptodate --> xbb782543df7528d1(["test_data"]):::uptodate
    x838f1e2fc49912df(["collection_file"]):::uptodate --> xcd8149c2b07551bf(["collection"]):::uptodate
    xfcd66df9fb8c7e8a(["wflows"]):::uptodate --> xe0bb173f910bd7f0(["valid_metrics"]):::uptodate
    x18c439c1d0279e5c(["vetiver_model"]):::uptodate --> xeffe44ed84879274(["model_meta"]):::uptodate
    xbf5ec9eec0b06faa(["games_file"]):::uptodate --> x574e5c623f867900(["games"]):::uptodate
    x004377234d3bacac(["recipe"]):::uptodate --> x55e8bf7e53595ba9(["trees_recipe"]):::uptodate
    x9b0c9170b8902027(["best_model"]):::uptodate --> x18c439c1d0279e5c(["vetiver_model"]):::uptodate
    x7e5555b2e63a26f0(["best_wflow"]):::uptodate --> x18c439c1d0279e5c(["vetiver_model"]):::uptodate
    xe0bb173f910bd7f0(["valid_metrics"]):::uptodate --> x18c439c1d0279e5c(["vetiver_model"]):::uptodate
    x7c91a03970e15376(["valid_split"]):::uptodate --> x18c439c1d0279e5c(["vetiver_model"]):::uptodate
    xfcd66df9fb8c7e8a(["wflows"]):::uptodate --> x7e5555b2e63a26f0(["best_wflow"]):::uptodate
    x7e5555b2e63a26f0(["best_wflow"]):::uptodate --> x9b0c9170b8902027(["best_model"]):::uptodate
    xfcd66df9fb8c7e8a(["wflows"]):::uptodate --> x9b0c9170b8902027(["best_model"]):::uptodate
    x50558fc6e6286095(["train_data"]):::uptodate --> x7c91a03970e15376(["valid_split"]):::uptodate
    x0f09e4c17eb3276c(["test_metrics"]):::uptodate --> xbc2f8d07f8113aa5(["write_metrics"]):::uptodate
    xe0bb173f910bd7f0(["valid_metrics"]):::uptodate --> xbc2f8d07f8113aa5(["write_metrics"]):::uptodate
    xe7c688145125e4e7(["glmnet_mod"]):::uptodate --> xf06d6eef7829004f(["glmnet_wflow"]):::uptodate
    xc88728c0e923dd78(["linear_recipe"]):::uptodate --> xf06d6eef7829004f(["glmnet_wflow"]):::uptodate
    xec3a6239d23d9fb4(["lightgbm_mod"]):::uptodate --> xad2d2a7a16304874(["lightgbm_wflow"]):::uptodate
    x55e8bf7e53595ba9(["trees_recipe"]):::uptodate --> xad2d2a7a16304874(["lightgbm_wflow"]):::uptodate
    xcd8149c2b07551bf(["collection"]):::uptodate --> x88354a4a9990c907(["collection_and_games"]):::uptodate
    x1e01b6b8e5aa4e61(["games_prepared"]):::uptodate --> x88354a4a9990c907(["collection_and_games"]):::uptodate
    x88354a4a9990c907(["collection_and_games"]):::uptodate --> xe28457b7180d9865(["split"]):::uptodate
  end
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
```

to run the pipeline:

1.  run `renv::restore()` to restore project dependencies
2.  run `targets::tar_make()` to execute the pipeline

## data

**games** - a snapshot of all games from boardgamegeek

**collection** - a snapshot of phil’s board game collection

## src

functions used in the pipeline

# results

tracking results from pipeline runs:

## validation set

``` r
valid = 
    get_file_history("targets-runs/valid_metrics.csv")

valid |>
    dplyr::select(-message) |>
    gt::gt() |>
    gt::as_raw_html()
```

<div>

<div id="bpzeovbhsz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

|      sha |        when         | author                     | wflow_id               | .config               | .metric     |       mean | std_err |   n | preprocessor | model        | rank |
|---------:|:-------------------:|:---------------------------|:-----------------------|:----------------------|:------------|-----------:|:-------:|----:|:-------------|:-------------|-----:|
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features   | Preprocessor1_Model08 | mn_log_loss | 0.07257506 |   NA    |   1 | recipe       | logistic_reg |    1 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features   | Preprocessor1_Model08 | pr_auc      | 0.27754573 |   NA    |   1 | recipe       | logistic_reg |    1 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features   | Preprocessor1_Model08 | roc_auc     | 0.93380918 |   NA    |   1 | recipe       | logistic_reg |    1 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | lightgbm_full_features | Preprocessor1_Model04 | mn_log_loss | 0.07886975 |   NA    |   1 | recipe       | boost_tree   |    2 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | lightgbm_full_features | Preprocessor1_Model04 | pr_auc      | 0.23035233 |   NA    |   1 | recipe       | boost_tree   |    2 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | lightgbm_full_features | Preprocessor1_Model04 | roc_auc     | 0.92543421 |   NA    |   1 | recipe       | boost_tree   |    2 |

</div>

</div>

## test set

``` r
test = 
    get_file_history("targets-runs/test_metrics.csv")

test |>
    dplyr::select(-message) |>
    gt::gt() |>
    gt::as_raw_html()
```

<div>

<div id="wlfgratzlk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| sha      |                when | author                     | wflow_id             | version                | .metric     | .estimator |  .estimate |
|:---------|--------------------:|:---------------------------|:---------------------|:-----------------------|:------------|:-----------|-----------:|
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features | 20240814T171719Z-6e357 | roc_auc     | binary     | 0.96718364 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features | 20240814T171719Z-6e357 | pr_auc      | binary     | 0.07228537 |
| 61076076 | 2024-08-14 17:23:42 | phil.henrickson@github.com | glmnet_full_features | 20240814T171719Z-6e357 | mn_log_loss | binary     | 0.01145525 |
| 25edf253 | 2024-08-14 16:52:51 | phil.henrickson@github.com | glmnet_full_features | 20240814T164134Z-6e357 | roc_auc     | binary     | 0.96718364 |
| 25edf253 | 2024-08-14 16:52:51 | phil.henrickson@github.com | glmnet_full_features | 20240814T164134Z-6e357 | pr_auc      | binary     | 0.07228537 |
| 25edf253 | 2024-08-14 16:52:51 | phil.henrickson@github.com | glmnet_full_features | 20240814T164134Z-6e357 | mn_log_loss | binary     | 0.01145525 |

</div>

</div>
