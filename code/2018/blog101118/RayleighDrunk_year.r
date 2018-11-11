
# Rayleigh Flight of Drunk
# Creating Figure 2 of blog101118

# Libraries
# install.packages(ggplot2)
# install.packages(data.table)
library(ggplot2)
library(data.table)

# Parameters
n <- 100
m <- 365
sig <- rep(c(-1,1),2*n)

y.dat <- data.table(
j = numeric(),
zj = numeric())

for (j in (1:m)){
u <- sample(sig,n)
xn <- c(0, cumsum(u))
t <- seq(0, n, 1)
d.dat <- data.table(cbind(t, xn))
zj <- d.dat[t==n,]$xn
temp <- data.frame(cbind(j,zj))
y.dat <- rbind(y.dat, temp)
}

g <- ggplot()
gp <- g + 
geom_point(aes(x=j, y=zj), data=y.dat) +
xlab(expression(paste("Day, ", italic(j)))) +
ylab(expression(paste("Daily Displacement, ", italic(Z)[italic(j)]))) + 
theme_bw() +
theme(text=element_text(family="Georgia", size=18))

ggsave(filename="DailyDisp_RayleighExample.jpeg", plot=gp, width=8, height=4, dpi=200)
