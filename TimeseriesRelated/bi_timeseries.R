dir <- getwd()
args <- commandArgs()
print(args)
births <- read.table(paste(dir,"/csv_files/",args[6],".csv", sep=""), sep = ",")

dummy = as.vector(t(births))
birthstimeseries <- ts(dummy,start=c(2000, 1), end=c(2014, 12), frequency=12)
name  = paste(dir,"/Plots/",args[6],".pdf",sep="")
pdf(name)
plot(birthstimeseries)
birthstimeseries.stl = stl(birthstimeseries, s.window="periodic")
plot(birthstimeseries.stl)

plot(birthstimeseries, xaxt = "n")
tsp = attributes(birthstimeseries)$tsp
dates = seq(as.Date("2000-01-01"), by = "month", along = birthstimeseries)
axis(1, at = seq(tsp[1], tsp[2], along = birthstimeseries), labels = format(dates, "%Y-%m"))
df = data.frame(date = seq(as.POSIXct("2000-01-01"), by = "month", length.out = 24), pcp = rnorm(24))
library(ggplot2)
library(scales)
p = ggplot(data = df, aes(x = date, y = pcp)) + geom_line()
p + scale_x_datetime(labels = date_format("%Y-%m"), breaks = date_breaks("months")) + theme(axis.text.x = element_text(angle = 45))
dev.off()