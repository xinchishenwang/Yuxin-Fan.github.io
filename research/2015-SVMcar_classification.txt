#----------------------SVM--------------------------#

##############################################################
#######################collecting data########################
##############################################################
cars <- read.csv("car.csv")
str(cars)

##############################################################
#################exoloring and preparing data###############
##############################################################
cars_train <- cars[401:1728, ]
cars_test <- cars[1:400, ]

##############################################################
####################training a model ###################
##############################################################
library(kernlab)
car_classifier <- ksvm(class ~ ., data = cars_train,
                          kernel = "vanilladot")
car_classifier

##############################################################
####################evaluating model performance #############
##############################################################
car_predictions <- predict(car_classifier, cars_test)
head(car_predictions)
table(car_predictions, cars_test$class)
agreement <- car_predictions == cars_test$class
table(agreement)
prop.table(table(agreement))

##############################################################
####################improve model performance #############
##############################################################
car_classifier_rbf <- ksvm(class ~ ., data = cars_train,
                              kernel = "rbfdot")
car_predictions_rbf <- predict(car_classifier_rbf,
                                  cars_test)

table(car_predictions_rbf, cars_test$class)

agreement_rbf <- car_predictions_rbf == cars_test$class
table(agreement_rbf)

prop.table(table(agreement_rbf))

#-----------------------ANN--------------------------#







