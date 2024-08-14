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
    x2db1ec7a48f65a9b([""Outdated""]):::outdated --- xf1522833a4d242c5([""Up to date""]):::uptodate
    xf1522833a4d242c5([""Up to date""]):::uptodate --- xd03d7c7dd2ddda2b([""Stem""]):::none
  end
  subgraph Graph
    direction LR
    xfcd66df9fb8c7e8a(["wflows"]):::outdated --> xe0bb173f910bd7f0(["valid_metrics"]):::outdated
    xe7c688145125e4e7(["glmnet_mod"]):::outdated --> xfd05af60d2c5a8ee(["glmnet_pca_wflow"]):::outdated
    x52a5839037ffcfae(["pca_recipe"]):::outdated --> xfd05af60d2c5a8ee(["glmnet_pca_wflow"]):::outdated
    xcd8149c2b07551bf(["collection"]):::outdated --> x88354a4a9990c907(["collection_and_games"]):::outdated
    x1e01b6b8e5aa4e61(["games_prepared"]):::outdated --> x88354a4a9990c907(["collection_and_games"]):::outdated
    x574e5c623f867900(["games"]):::outdated --> x1e01b6b8e5aa4e61(["games_prepared"]):::outdated
    xfcd66df9fb8c7e8a(["wflows"]):::outdated --> x3983243dd18164e7(["wflows_plot"]):::outdated
    x9b0c9170b8902027(["best_model"]):::outdated --> x18c439c1d0279e5c(["vetiver_model"]):::outdated
    x7e5555b2e63a26f0(["best_wflow"]):::outdated --> x18c439c1d0279e5c(["vetiver_model"]):::outdated
    xe0bb173f910bd7f0(["valid_metrics"]):::outdated --> x18c439c1d0279e5c(["vetiver_model"]):::outdated
    x7c91a03970e15376(["valid_split"]):::outdated --> x18c439c1d0279e5c(["vetiver_model"]):::outdated
    xeffe44ed84879274(["model_meta"]):::outdated --> xba368001e67990cc(["model_report"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> xba368001e67990cc(["model_report"]):::outdated
    xbb782543df7528d1(["test_data"]):::outdated --> xba368001e67990cc(["model_report"]):::outdated
    xe0bb173f910bd7f0(["valid_metrics"]):::outdated --> xba368001e67990cc(["model_report"]):::outdated
    x3983243dd18164e7(["wflows_plot"]):::outdated --> xba368001e67990cc(["model_report"]):::outdated
    x7c91a03970e15376(["valid_split"]):::outdated --> x004377234d3bacac(["recipe"]):::outdated
    x004377234d3bacac(["recipe"]):::outdated --> xc88728c0e923dd78(["linear_recipe"]):::outdated
    x50558fc6e6286095(["train_data"]):::outdated --> x7c91a03970e15376(["valid_split"]):::outdated
    xec3a6239d23d9fb4(["lightgbm_mod"]):::outdated --> xad2d2a7a16304874(["lightgbm_wflow"]):::outdated
    x55e8bf7e53595ba9(["trees_recipe"]):::outdated --> xad2d2a7a16304874(["lightgbm_wflow"]):::outdated
    x0f09e4c17eb3276c(["test_metrics"]):::outdated --> xbc2f8d07f8113aa5(["write_metrics"]):::outdated
    xe0bb173f910bd7f0(["valid_metrics"]):::outdated --> xbc2f8d07f8113aa5(["write_metrics"]):::outdated
    x004377234d3bacac(["recipe"]):::outdated --> x55e8bf7e53595ba9(["trees_recipe"]):::outdated
    x838f1e2fc49912df(["collection_file"]):::uptodate --> xcd8149c2b07551bf(["collection"]):::outdated
    x23b44b68d822d267(["glmnet_pca_tuned"]):::outdated --> xfcd66df9fb8c7e8a(["wflows"]):::outdated
    xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated --> xfcd66df9fb8c7e8a(["wflows"]):::outdated
    x3045fd98bf132297(["lightgbm_tuned"]):::outdated --> xfcd66df9fb8c7e8a(["wflows"]):::outdated
    xeffe44ed84879274(["model_meta"]):::outdated --> x0f09e4c17eb3276c(["test_metrics"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x0f09e4c17eb3276c(["test_metrics"]):::outdated
    xbb782543df7528d1(["test_data"]):::outdated --> x0f09e4c17eb3276c(["test_metrics"]):::outdated
    xfd05af60d2c5a8ee(["glmnet_pca_wflow"]):::outdated --> x23b44b68d822d267(["glmnet_pca_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x23b44b68d822d267(["glmnet_pca_tuned"]):::outdated
    xbd276234e7c5b0df(["tune_control"]):::outdated --> x23b44b68d822d267(["glmnet_pca_tuned"]):::outdated
    x7c91a03970e15376(["valid_split"]):::outdated --> x23b44b68d822d267(["glmnet_pca_tuned"]):::outdated
    xbf5ec9eec0b06faa(["games_file"]):::uptodate --> x574e5c623f867900(["games"]):::outdated
    x7e5555b2e63a26f0(["best_wflow"]):::outdated --> x9b0c9170b8902027(["best_model"]):::outdated
    xfcd66df9fb8c7e8a(["wflows"]):::outdated --> x9b0c9170b8902027(["best_model"]):::outdated
    x18c439c1d0279e5c(["vetiver_model"]):::outdated --> xeffe44ed84879274(["model_meta"]):::outdated
    xf06d6eef7829004f(["glmnet_wflow"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xbd276234e7c5b0df(["tune_control"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    x7c91a03970e15376(["valid_split"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xe7c688145125e4e7(["glmnet_mod"]):::outdated --> xf06d6eef7829004f(["glmnet_wflow"]):::outdated
    xc88728c0e923dd78(["linear_recipe"]):::outdated --> xf06d6eef7829004f(["glmnet_wflow"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> x50558fc6e6286095(["train_data"]):::outdated
    x88354a4a9990c907(["collection_and_games"]):::outdated --> xe28457b7180d9865(["split"]):::outdated
    xad2d2a7a16304874(["lightgbm_wflow"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    xbd276234e7c5b0df(["tune_control"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    x7c91a03970e15376(["valid_split"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    xfcd66df9fb8c7e8a(["wflows"]):::outdated --> x7e5555b2e63a26f0(["best_wflow"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> xbb782543df7528d1(["test_data"]):::outdated
    x004377234d3bacac(["recipe"]):::outdated --> x52a5839037ffcfae(["pca_recipe"]):::outdated
  end
  classDef outdated stroke:#000000,color:#000000,fill:#78B7C5;
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
  linkStyle 1 stroke-width:0px;
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
    group_by(wflow_id )|>
    slice_max(when, n =1) |>
    ungroup() |>
    select(sha, when, wflow_id, .config, .metric, mean, model, rank) |>
    pivot_wider(
        names_from = .metric,
        values_from = mean
    ) |>
    arrange(mn_log_loss) |>
    gt::gt() |>
    gt::as_raw_html()
```

<div id="bymzglrctl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| sha | when | wflow_id | .config | model | rank | mn_log_loss | pr_auc | roc_auc |
|:---|:--:|:---|:---|:---|---:|---:|---:|---:|
| 8143a62d | 2024-08-14 21:30:00 | glmnet_full_features | Preprocessor1_Model08 | logistic_reg | 1 | 0.07257506 | 0.2775457 | 0.9338092 |
| 8143a62d | 2024-08-14 21:30:00 | glmnet_pca | Preprocessor1_Model05 | logistic_reg | 2 | 0.07560460 | 0.2605727 | 0.9012134 |
| 8143a62d | 2024-08-14 21:30:00 | lightgbm_full_features | Preprocessor1_Model04 | boost_tree | 3 | 0.07886975 | 0.2303523 | 0.9254342 |

</div>

## test set

``` r
test = 
    get_file_history("targets-runs/test_metrics.csv")

test |>
    group_by(wflow_id) |>
    slice_max(when, n =1) |>
    ungroup() |>
    select(sha, when, version, wflow_id, .metric, .estimate) |>
    pivot_wider(
        names_from = .metric,
        values_from = .estimate
    ) |>
    arrange(mn_log_loss) |>
    gt::gt() |>
    gt::as_raw_html()
```

<div id="xpaxvqhbse" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| sha | when | version | wflow_id | roc_auc | pr_auc | mn_log_loss |
|:---|:--:|:---|:---|---:|---:|---:|
| 8143a62d | 2024-08-14 21:30:00 | 20240814T203541Z-60514 | glmnet_full_features | 0.9671836 | 0.07228537 | 0.01145525 |

</div>
