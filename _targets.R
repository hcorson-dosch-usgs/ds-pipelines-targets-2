library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/munge_nwis_data.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

parameter_code = '00010'
start_date = "2014-05-01"
end_date = "2015-05-01"
site_nums = c("01427207", "01432160", "01435000", "01436690", "01466500")

p1_targets_list <- list(
  tar_target(
    site_data_01427207_csv,
    {
      site_id = site_nums[1]
      out_file = file.path('1_fetch/out', paste0('nwis_', site_id, '_data.csv'))
      download_nwis_site_data(site_num = site_id,
                              out_file = out_file,
                              parameterCd = parameter_code,
                              startDate = start_date,
                              endDate = end_date)
    },
    format = 'file'
  ),
  tar_target(
    site_data_01432160_csv,
    {
      site_id = site_nums[2]
      out_file = file.path('1_fetch/out', paste0('nwis_', site_id, '_data.csv'))
      download_nwis_site_data(site_num = site_id,
                              out_file = out_file,
                              parameterCd = parameter_code,
                              startDate = start_date,
                              endDate = end_date)
    },
    format = 'file'
  ),
  tar_target(
    site_data_01435000_csv,
    {
      site_id = site_nums[3]
      out_file = file.path('1_fetch/out', paste0('nwis_', site_id, '_data.csv'))
      download_nwis_site_data(site_num = site_id,
                              out_file = out_file,
                              parameterCd = parameter_code,
                              startDate = start_date,
                              endDate = end_date)
    },
    format = 'file'
  ),
  tar_target(
    site_data_01436690_csv,
    {
      site_id = site_nums[4]
      out_file = file.path('1_fetch/out', paste0('nwis_', site_id, '_data.csv'))
      download_nwis_site_data(site_num = site_id,
                              out_file = out_file,
                              parameterCd = parameter_code,
                              startDate = start_date,
                              endDate = end_date)
    },
    format = 'file'
  ),
  tar_target(
    site_data_01466500_csv,
    {
      site_id = site_nums[5]
      out_file = file.path('1_fetch/out', paste0('nwis_', site_id, '_data.csv'))
      download_nwis_site_data(site_num = site_id,
                              out_file = out_file,
                              parameterCd = parameter_code,
                              startDate= start_date,
                              endDate= end_date)
    },
    format = 'file'
  ),
  tar_target(
    site_data,
    combine_nwis_data(site_data_01427207_csv,
                      site_data_01432160_csv,
                      site_data_01435000_csv,
                      site_data_01436690_csv,
                      site_data_01466500_csv)
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", site_data),
    format = "file"
  )
)

p2_targets_list <- list(
  tar_target(
    site_data_munged,
    munge_nwis_data(nwis_data = site_data, 
                    site_info_file = site_info_csv)
  )
)

p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_munged),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
