munge_nwis_data <- function(site_data_file, site_info, out_file) {
  site_data <- read_csv(site_data_file)
  nwis_data_clean <- site_data %>%
    rename(water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd) %>%
    left_join(site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va) %>%
    mutate(station_name = as.factor(station_name))
  
  if(!dir.exists(dirname(out_file))) dir.create(dirname(out_file), recursive=TRUE)
  write_csv(nwis_data_clean, out_file)
  return(out_file)
}