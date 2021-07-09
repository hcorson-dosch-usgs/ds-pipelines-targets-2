
combine_nwis_data <- function(...) {
  downloaded_files = list(...)

  data_out <- purrr::map_df(downloaded_files, function(downloaded_file) {
    read_csv(downloaded_file, col_types = 'ccTdcc')
  })

  return(data_out)
}

nwis_site_info <- function(fileout, site_data){
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  write_csv(site_info, fileout)
  return(fileout)
}

download_nwis_site_data <- function(site_num, out_file, parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01"){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = parameterCd, startDate = startDate, endDate = endDate)

  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  
  write_csv(data_out, file = out_file)
  return(out_file)
}

