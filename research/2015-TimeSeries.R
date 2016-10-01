############################################################
############HOW to Do Time Series Analyse###################
############################################################

library(TSA)

#read the data
data <- read.table("hwa2.dat")
y <- data$Y5

#y <- data$Y2[1:400]
#data1 <- read.table("exchange-rates.dat")

######################Identification######################
par(mfrow = c(1,3))
plot(y,type = "o", main = "Time Series")
acf(y,main = "ACF",ci.type = "ma")
pacf(y,main = "PACF")
eacf(y)

BoxCox.ar(y-min(y)+1) #y must be positive
#qqnorm(log(y))

########################Estimation########################
#for different model, different order!!!!!!!!!!!!
result <- arima(y,order = c(1,0,1),method = "ML")
#another function to estimate the AR model 
#result <- ar(y,order.max = 2,method = "yw")
result

#####################Model diagnostics#########################

result$resid
par(mfrow = c(1,1))

#Time series plot of residuals 
plot(result$resid,type = "o")

#Correlogram of residuals:
par(mfrow = c(1,2))
acf(result$resid[-1][-1], main = "ACF of Residuals")$acf
pacf(result$resid[-1][-1], main = "ACF of Residuals")

acf(result$resid[-1][-1],plot = F)$acf
signif(acf(result$resid,plot = F)$acf[1:6],2)

#Ljung-box test
tsdiag(result,gof.lag = 15,omit.initial = F)

#QQ_Plot to test the residuals if they follow the Normal Distribution
qqnorm(result$resid, main = "QQ_Plot of Residuals")
qqline(result$resid, col="red")

########################Forecasting############################
#plot(result)
plot(result)$pred
plot(result)$upi
plot(result)$lpi
plot(result,n1=396,n.ahead=4,ylab = "Observation")
points(x=c(401:404),y=data$Y2[401:404],pch=2,type = "o",col="red")

#evaluat the model by calculating MSE RMSE MAPE
MSE <- sum((result$residuals)^2)/length(y)

RMSE <- sqrt(sum((result$residuals)^2)/length(y))

MAPE <- (1/length(y))*sum(abs(result$residuals/y))*100

cbind(MSE,RMSE,MAPE)

