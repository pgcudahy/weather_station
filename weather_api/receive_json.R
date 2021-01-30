# plumber.R
library(tidyverse)
library(lubridate)

#' @post /station
#' @serializer json
#' @param wind_direction_raw
#' @param rain_amount_raw
#' @param timestamp
#' @param elapsed_time
#' @param wind_speed_raw
#' @param message_id
function(req, wind_direction_raw, rain_amount_raw, timestamp,
    elapsed_time, wind_speed_raw, message_id){

    new_data <- tibble("wind_direction_raw" = wind_direction_raw, 
        "rain_amount_raw" = rain_amount_raw,
        "wind_speed_raw" = wind_speed_raw,
        "timestamp" = ymd_hms(paste(timestamp[1:6], collapse="="), tz = "UTC"), 
        "elapsed_time" = elapsed_time, 
        "message_id" = message_id)

    write_path <- paste0("/home/pi/weather_station/data/weather_data_", 
            Sys.Date(), ".csv")

    readr::write_csv(new_data, write_path, append=TRUE)

    # if(assertthat::is.writeable(write_path)) {
    #     write_csv(new_data, write_path, append=TRUE)
    # } else if (!file.exists(write_path)) {
    #     print("creating data file")
    #     write_csv(new_data, write_path, append=TRUE)
    # } else {
    #     print("Weather data file at ", write_path, " is not writeable")
    # }
}
#' @post /error
#' @serializer json
#' @param reset_time_date
#' @param reset_cause
function(req, reset_time_date, reset_cause){
    print("launched")
    timeout_data <- tibble("Watchdog_timeout" = 
        ymd_hms(paste(reset_time_date[1:6], collapse="="), tz = "UTC"), 
        "Watchdog_reason" = reset_cause)

    write_path <- paste0("/home/pi/weather_station/data/timeouts_", Sys.Date(), ".csv")
    print("wrote error log")
    
    readr::write_csv(timeout_data, write_path, append=TRUE)
    
    # if(assertthat::is.writeable(write_path)) {
    #     print("error is writeable")
    #     write_csv(timeout_data, write_path, append=TRUE)
    # } else if (!file.exists(write_path)) {
    #     print("creating error file")
    #     write_csv(new_data, write_path, append=TRUE)
    # } else {
    #     print("Error data file at ", write_path, " is not writeable")
    # }
    # print("done")
}

#' @post /power
#' @serializer json
#' @param status_index
#' @param solar_watts
#' @param battery_voltage
#' @param battery_amperage
#' @param external_temperature
#' @param power_time_date
function(req, status_index, solar_watts, battery_voltage,
    battery_amperage, external_temperature, power_time_date){

    power_data <- tibble("status_index" = status_index, 
        "solar_watts" = solar_watts, 
        "battery_voltage" = battery_voltage,
        "battery_amperage" = battery_amperage, 
        "external_temperature" = external_temperature, 
        "power_time_date" = ymd_hms(paste(power_time_date[1:6], 
            collapse="="), tz = "UTC"))

    write_path <- paste0("/home/pi/weather_station/data/power_data_", 
        Sys.Date(), ".csv")

    readr::write_csv(power_data, write_path, append=TRUE)

    # if(assertthat::is.writeable(write_path)) {
    #     write_csv(power_data, write_path, append=TRUE)
    # } else if (!file.exists(write_path)) {
    #     print("creating power file")
    #     write_csv(power_data, write_path, append=TRUE)
    # } else {
    #     print("Power data file at ", write_path, " is not writeable")
    # }
}

# #' Log some information about the incoming request
# #' @filter logger
# function(req){
#   cat(as.character(Sys.time()), "-",
#     req$REQUEST_METHOD, req$PATH_INFO, "-",
#     req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n",
#     req$body, "\n",
#     req$QUERY_STRING, "\n")
#   plumber::forward()
# }

