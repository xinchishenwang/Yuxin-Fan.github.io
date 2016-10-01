##############################################
##################简单线性回归################
##############################################
fit <- lm(weight~height,data=women)

summary(fit)

residuals(fit) #列出模型的残差
fitted(fit)    #列出拟合模型的预测值
women$weight   #实际的观测值  

#残差=实际观测值-模型预测值##residuals(fit)+fitted(fit)=women$weight#

plot(women$height,women$weight,
     xlab="Height(in inches)",
     ylab="weight(in pounds)")  #根据原始数据画出散点图

abline(fit)    #加一条拟合直线

##############################################
################多项式线性回归##################
##############################################

fit2 <- lm(weight~height + I(height^2),data=women)
summary(fit2)
plot(women$height,women$weight,
     xlab="Height(in inches)",
     ylab="weight(in pounds)")  #根据原始数据画出散点图

lines(women$height,fitted(fit2)) #加一条根据预测值点绘制出的预测曲线和原有散点对比
##使用car包来绘制二元关系图##包含线性拟合曲线和平滑拟合曲线（loess）
library(car)
scatterplot(weight~height,
            data=women,
            spread=F,
            lty=2,           ##设置 loess拟合曲线为虚线
            pch=19,          ##设置点为实心圆，默认为空心圆
            main="Women Age 30~39",
            xlab="Height(in inches)",
            ylab="Weight(lbs.)" )


##############################################
################多元线性回归####################
##############################################

class(state.x77)
#lm()函数需要一个数据框
states <- as.data.frame(state.x77[,c("Murder","Population",
                                     "Illiteracy","Income","Frost")])
##将数据转换为数据框形式，并筛选了部分变量

##检测两个变量之间的关系##
cor(states) 
library(car)
scatterplotMatrix(states,spread=F,lty=2,
                  main="Scatter Plot Matrix")
##绘制了变量间的散点图，并且添加了平滑和线性拟合曲线

fit <- lm(Murder~Population + Illiteracy + Income + Frost,
          data=states)
summary(fit)

##############################################
################回归诊断#####################
##############################################

##关于模型的置信区间
fit <- lm(Murder~Population + Illiteracy + Income + Frost,
          data=states)
confint(fit)

##标准方法。利用plot返回四幅图来评价模型的拟合情况

#第一个问题。简单回归的诊断图
fit <- lm(weight~height,data=women)
par(mfrow=c(2,2))
plot(fit)
#第二个问题。二次拟合诊断图
fit2 <- lm(weight~height + I(height^2),data=women)
par(mfrow=c(2,2))
plot(fit2)
#第三个问题。多元回归的诊断图
fit <- lm(Murder~Population + Illiteracy + Income + Frost,
          data=states)
par(mfrow=c(2,2))
plot(fit)

#解释四副诊断图#
#左上。线性假定。残差-拟合图，若自变量与因变量相关，那么残差值和预测值不存在某种联系，
#右上。正态性假定。QQ图
#左下。同方差性。若满足方差不变假定，应该随机分布
#右下。残差杠杆图。鉴别离群点，高杠杆点还有强影响点
#注：独立性是从其他角度来考虑的

##改进的方法。利用car包

#正态性
library(car)
fit <- lm(Murder~Population + Illiteracy + Income + Frost,
          data=states)
qqPlot(fit,labels=row.names(states),
       id.method="identify",
       simulate=T,
       main="Q-Q Plot")
#独立性
library(car)
durbinWatsonTest(fit)
#线性
library(car)
crPlots(fit)
#同方差性
library(car)
ncvTest(fit)    #计分检验,判断方差是否恒定，零假设为方差不变  

spreadLevelPlot(fit)   #给出幂次变换建议

##线性模型的综合验证
library(gvlma)
gvmodel <- gvlma(fit)
l)












