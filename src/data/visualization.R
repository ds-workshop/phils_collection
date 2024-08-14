plot_separation = function(data,
                           event_color = 'dodgerblue'
) {
    
    tmp = 
        data |>
        mutate(rank = rank(desc(.pred_yes)))
    
    p = 
        tmp |>
        ggplot(aes(x=rank,
                   y=.pred_yes))+
        theme(panel.grid.major = element_blank())
    
    p +
        geom_vline(
            data = tmp |>
                filter(own == 'yes'),
            aes(xintercept = rank),
            color = event_color,
            alpha = 0.5
        )+
        geom_point(size =0.25, alpha = 0.5)
    
    
}