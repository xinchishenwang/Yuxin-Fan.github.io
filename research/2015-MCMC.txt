n <- 30000  
target<-function(x) 0.3*dnorm(x,1,0.5)+0.7*dnorm(x,3,0.1)

v<-NULL          
z<-NULL
u<- NULL

z[0]<-rnorm(1,0,1)
for(i in 1:n)
{
  u<-runif(1,0,1)
  v[i]<-rnorm(1,0,1)   
  T0<-min(1,(target(v[i])/dnorm(v[i]))*(dnorm(z[i-1])/target(z[i-1])))
  if(u<= T0) z[i]=v[i]
  if(u> T0) z[i]=z[i-1]
}
par(mfrow=c(1,2))
hist(z,main="histogram",breaks=80,freq=F)
curve(target,add=F,xlim=c(-3,7),main="target",col="red",lwd=1.5)
