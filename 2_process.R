source("2_process/src/munge_nwis_data.R")

p2_targets_list <- list(
  tar_target(
    p2_site_data_munged_csv,
    munge_nwis_data(site_data_file = p1_site_data_csv, 
                    site_info = p1_site_info,
                    out_file = '2_process/out/site_data_munged.csv'),
    format = "file"
  )
)