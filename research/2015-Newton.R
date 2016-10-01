##################生成模拟数据#########################
sigma <- 1                                
n <- 100
p <- 5                                    #设置p个变量
q <- p+1
x <- matrix(1, n,q)

beta <- seq(1, p+1)                       #设置系数为123456
for(i in 1:p+1) x[,i] <- rnorm(n, 3, sigma)          
y <- matrix(NA, n, 1)                     #数据生成完毕

set.seed(6)                            
e <- rnorm(n, mean = 0, sd = sigma)  
y = x %*% beta + e                        #就这样产生了y

#########################以上产生了步骤产生了数据########################
###################使用牛顿迭代进行估计############################

GH <- function(beta,sigma)
{
  mu = x %*% beta                           #y服从正态分布，均值为mu
  
  sumlogf = -sum((y-mu)^2/2*sigma^2)-n*log(2*pi)/2-n*log(sigma)
  
  grad <- rep(NA, q)                        #一阶导数放入梯度矩里
  hesse <- matrix(NA,q, q)                  #二阶导数放入黑塞矩里
  
  for(i in 1:q)
  { 
    grad[i] = sum(x[,i]*(y-mu) / sigma^2)   #一阶导数组成一维矩
    hesse[i,i] = -sum(x[,i]^2 / sigma^2)    #二阶导数组成二维矩
    for(j in 1:q) hesse[i,j] = -sum(x[,i]*x[,j]/sigma^2)
  }
  return(list(grad,hesse))
}

Sf <- function (beta,sigma)
{
  mu = x %*% beta 	
  df = -n*sigma^(-1)+sum((y-mu)^2*sigma^(-3))
  ddf = n*sigma^(-2) - sum(3*(y-mu)^2*sigma^(-4))
  return(list(df,ddf))
}  

Newton <- function (x,y,tol = 1e-9,m.total=15)    
{                                            #给定xy以及精度和迭代次数（其中精度与迭代次数有默认值）
  m <- 1                                     #m用来计数，初始化为1
  beta <-  matrix(NA,q,m.total)
  beta[,1] <- matrix(rep(100, q),q,1)           
  sigma <- matrix(NA,m.total,1)
  sigma[1,] <- 0.5                   
  GH <- GH(beta[,m],sigma[m,])
  Sf <- Sf(beta[,m],sigma[m,])
  
  for(m in 1: (m.total-1)) 
  {
    beta[,m+1] <- beta[,m] - solve(GH[[2]], GH[[1]])     
    sigma[m+1,] <- sigma[m,] - Sf[[2]]^(-1)*Sf[[1]]
    
    Sf <- Sf(beta[,m+1],sigma[m+1,]) 
    GH <- GH(beta[,m+1],sigma[m+1,])     #递进去一个新的beta，为下一次迭代做准备
  }
  return(list(beta,sigma , m))         #得到的结果
}

Newton(x,y)
plot(Newton(x,y)[[2]],type="l")


