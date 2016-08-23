if (!require(readr)) {
    stop("Requires readr package")
}
if (!require(dplyr)) {
    stop("Requires dplyr package")
}
if (!require(lubridate)) {
    stop("Requires lubridate package")
}

if (!exists("tbl.hpc.subset")) {
    tbl.hpc <- read_delim("../household_power_consumption.txt",
                          delim = ";",
                          na = "?",
                          col_types = cols(
                              Date = col_date(format = "%d/%m/%Y"),
                              Time = col_time(format = ""),
                              Global_active_power   = col_double(),
                              Global_reactive_power = col_double(),
                              Voltage               = col_double(),
                              Global_intensity      = col_double(),
                              Sub_metering_1        = col_double(),
                              Sub_metering_2        = col_double(),
                              Sub_metering_3        = col_double()
                          )
    )
    tbl.hpc.subset <- filter(tbl.hpc, Date %in% ymd("2007-02-01"):ymd("2007-02-02"))
}
png("rplot3.png", units = "px", width = 480, height = 480)
with(tbl.hpc.subset,
     plot(as.POSIXct(Date) + Time,
          Sub_metering_1,
          type = "n",
          xlab = "",
          ylab = "Energy sub metering"
     )
)
with(tbl.hpc.subset, 
     lines(as.POSIXct(Date) + Time,
           tbl.hpc.subset$Sub_metering_1,
           col = "black"
     )
)
with(tbl.hpc.subset, 
     lines(as.POSIXct(Date) + Time,
           tbl.hpc.subset$Sub_metering_2,
           col = "red"
     )
)
with(tbl.hpc.subset, 
     lines(as.POSIXct(Date) + Time,
           tbl.hpc.subset$Sub_metering_3,
           col = "blue"
     )
)
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1
       )
dev.off()