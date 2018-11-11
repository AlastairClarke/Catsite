
# Rayleigh Flight of Drunk

#"https://github.com/AlastairClarke/Catsite/blob/master/code/RayleighDrunk_day.r"

# Libraries
# install.packages("ggplot2)
# install.packages("data.table")
library(ggplot2)
library(data.table)

set.seed(3)
sig <- rep(c(-1,1),200)
u <- sample(sig,100)
xn <- c(0, cumsum(u))
t <- seq(0, 100, 1)

d.dat <- data.table(cbind(t, xn))

e.dat <- data.table(c(0,100,100), c(0,0,40), c("Pub", "Home", "Lake"))
colnames(e.dat) <- c("Lon", "Lat", "Place")

g <- ggplot()
gp <- g + 
geom_line(aes(x=t, y=xn), data=d.dat) +
geom_text(aes(x=Lon, y=Lat, label=Place), data=e.dat, size=6, col="blue") +
xlab(expression(paste("Time, ", italic(i)))) +
ylab(expression(paste("Displacement, ", italic(X)[italic(i)]))) +
ylim(c(-10, 45)) + 
theme_bw() +
theme(text=element_text(family="Georgia", size=18))

ggsave(filename="DrunkDisp_RayleighExample.jpeg", plot=gp, width=8, height=4, dpi=200)
