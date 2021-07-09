plot_nwis_timeseries <- function(fileout, site_data_munged, width = 12, height = 7, units = 'in'){
  
  ggplot(data = site_data_munged, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(fileout, width = width, height = height, units = units)
  
  return(fileout)
}