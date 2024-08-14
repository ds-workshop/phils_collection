get_file_history = function(file = file) {
    
    # get current branch
    current_branch = 
        system("git branch --show-current", intern = T)
    
    # find commits assocaited with file
    commits = 
        git2r::commits(path = file)
    
    out =
        map_df(
            1:length(commits),
            ~ 
                {
                    commit =
                        commits |>
                        pluck(.x)
                    
                    author = 
                        commit
                    
                    # get sha of commit
                    shas = 
                        commit |>
                        pluck("sha")
                    
                    # get message with commit
                    summary = 
                        commit |>
                        pluck("summary")
                    
                    # get author and details
                    author = 
                        commit |>
                        pluck("author")
                    
                    # get email
                    email = 
                        author |>
                        pluck("email") |>
                        as.vector()
                    
                    # get when
                    when = 
                        author |>
                        pluck("when") |>
                        as.vector() |>
                        as.character() |>
                        as.POSIXlt()
                    
                    # get short sha
                    short = 
                        shas |>
                        substr(start = 1, stop = 8)
                    
                    # checkout repo at commit
                    commit |>
                        git2r::checkout()

                    # read in file
                    tab =
                        read.csv(file) |>
                        select(-X)
                    
                    tab |>
                        tibble::add_column(
                            sha = short,
                            when = when,
                            author = email,
                            message = summary
                        ) |>
                        dplyr::select(
                            sha,
                            when,
                            author,
                            message,
                            tidyr::everything()
                        )
                }
        )
    
    # revert to original branch
    system(paste("git checkout", current_branch))
    
    # check status
    system("git status")
    
    out
    
}