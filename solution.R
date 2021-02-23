
  
# Solution to replicate this chart: 
#(https://www.nbcnews.com/news/us-news/police-searches-drop-dramatically-states-legalized-marijuana-n776146)
#in ggplot
  
stops %>% filter(state == "WA") %>% 
  ggplot(aes(quarter, search_rate_100, 
             color = driver_race, 
             group =interaction(legalization_status, driver_race))) +
  geom_point() +
  geom_line() +
  geom_smooth(method = lm, se = FALSE) +
  theme_minimal(base_size = 12) +
  geom_line(size = 1, alpha = 0.7) + 
  geom_vline(xintercept = as.Date("2013-01-01"), linetype = 4) +
  scale_color_manual(values = c("#E8A063", "#177B42", "#D952CF")) +
  labs(title = "Washington\nAfter marijuana legalization, discretionary searches more than halved", 
       subtitle = "searches per 100 stops",
       caption = "Stanford Open Policing Project", x = "", y ="") +
   theme(plot.title = element_text(size = 14),
        plot.subtitle = element_text(size = 6),
        plot.caption = element_text(size = 6),
        legend.title = element_blank()) + 
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") + 
  annotate("text", x = as.Date("2014-04-01"), y = .38, 
           label = "searches plummet\nafter legalization", size = 2.5) +
  geom_curve(color = "gray", x = 16000, y = .43, 
             xend = 15750, yend = .42, angle = 90, 
             arrow = arrow(length = unit(0.02, "npc"))) 


#Create pre + post legalization dataframes

wa_stops_pre <- stops %>% filter(state == "WA" & quarter <= "2013-01-01")
wa_stops_post <- stops %>% filter(state == "WA" & quarter >= "2013-01-01")

plot_pre <- ggplot(wa_stops_pre, aes(quarter, search_rate_100, color = driver_race)) +
  geom_point() +
  geom_line() +
  geom_smooth(method = lm, se = FALSE)

# Build the rest of the chart by layering your first ggplot object with additional geom layers containing
# the other data-frame
plot_pre +
  geom_line(data = wa_stops_post) +
  geom_point(data = wa_stops_post) +
  geom_smooth(data = wa_stops_post, method = lm, se = FALSE) 

