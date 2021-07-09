source("1_fetch/src/get_nwis_data.R")

parameter_code = '00010'
start_date = "2014-05-01"
end_date = "2015-05-01"
site_nums = c("01427207", "01432160", "01435000", "01436690", "01466500")

p1_targets_list <- list(
  tar_target(
    p1_site_data_01427207_csv,
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
    p1_site_data_01432160_csv,
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
    p1_site_data_01435000_csv,
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
    p1_site_data_01436690_csv,
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
    p1_site_data_01466500_csv,
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
    p1_site_data_csv,
    combine_nwis_data(out_file = '1_fetch/out/site_data.csv',
                      p1_site_data_01427207_csv,
                      p1_site_data_01432160_csv,
                      p1_site_data_01435000_csv,
                      p1_site_data_01436690_csv,
                      p1_site_data_01466500_csv),
    format = "file"
  ),
  tar_target(
    p1_site_info,
    nwis_site_info(site_data_file = p1_site_data_csv)
  )
)