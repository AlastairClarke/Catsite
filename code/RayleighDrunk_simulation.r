
# Rayleigh Flight of Drunk
# Creating Fig 3 and 4 of blog101118

# Libraries
library(ggplot2)
library(data.table)

# Parameters
n <- 100
m <- 365
l <- 1000

sig <- rep(c(-1,1),2*n)

s.dat <- data.table(
k = numeric(),
mk = numeric())

for (k in (1:l)){

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

mk <- max(y.dat$zj)
temp <- data.frame(cbind(k, mk))
s.dat <- rbind(s.dat, temp)
}

s.dat <- s.dat[order(-mk)]
s.oep <- s.dat[,.N, by=mk]
s.oep$ep <- cumsum(s.oep$N)/l

write.csv(s.dat, "Rayleigh_AnnualMaxDisp_l1000.csv", row.names=FALSE)
write.csv(s.oep, "Rayleigh_OEP_l1000.csv", row.names=FALSE)

g <- ggplot()
gp <- g + 
geom_point(aes(x=k, y=mk), data=s.dat) +
xlab(expression(paste("Simulation year, ", italic(k)))) +
ylab(expression(paste("Annual Maximum Displacement, ", italic(M[k])))) +
theme_bw() +
theme(text=element_text(family="Georgia", size=22))

ggsave(filename="AnnualDisp_Rayleigh_l1000.jpeg", plot=gp, width=8, height=6, dpi=200)

g <- ggplot()
gp <- g + 
geom_point(aes(x=mk, y=ep), data=s.oep, size=2) +
geom_hline(yintercept=0.01, col="red") +
geom_vline(xintercept=36.5, col="red") +
xlab(expression(paste("Annual Maximum Displacement, ", italic(M[k])))) +
ylab(expression(paste("Exceedance Probability, Pr {", italic(M[k])<=italic(y), "}"))) + 
scale_y_log10() +
theme_bw() +
theme(text=element_text(family="Georgia", size=22),
panel.grid.minor=element_blank())

ggsave(filename="EP_Rayleigh_l1000.jpeg", plot=gp, width=8, height=6, dpi=200)
