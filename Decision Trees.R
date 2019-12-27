install.packages("party")
library(party)
setwd('C:/Users/carlo/Desktop/Data science/ASDM/Decision Trees')
cardio_data<-read.csv("Cardio.csv", header= TRUE)

#Inspect the dataset 
names(cardio_data)
head(cardio_data)
tail(cardio_data)
summary(cardio_data)
str(cardio_data)
#Check the dimension and number of points of the "cardio_data" dataset
nrow(cardio_data)
ncol(cardio_data)
dim(cardio_data)

#We need categorical (Factor) data to class variable for prediction, hence we should convert the NSP variable to categorical
cardio_data$NSPF <-as.factor(cardio_data$NSP)
str(cardio_data)
#train and validate(test) data from our data. Divide 80% Training and 20% Validation parts for implementing our trees
set.seed(1234)
pd <-sample(2,nrow(cardio_data),replace=TRUE, prob=c(0.8,0.2))
train <-cardio_data[pd==1,]
validate <-cardio_data[pd==2,]
#Checking how many observations are in train and validate data sets
dim(train)
dim(validate)
#Now since we have train and validate data sets,we can implement Decision trees. Train the treeusing ctree()function in partypackage

cardio_tree <-ctree(NSPF~BPM+APC+FMPS+UCPS,data = train)

# Printing and plotting the tree
print(cardio_tree)
plot(cardio_tree)

# check the prediction on train data 
predict(cardio_tree)

tab<-table(predict(cardio_tree), train$NSPF)
print(tab)

# Calculate classification accuracy

sum(diag(tab))/sum(tab)

# classification error

1-sum(diag(tab))/sum(tab)

# validate the model on test data set

test_predict <-table(predict(cardio_tree, newdata= validate), validate$NSPF)
print(test_predict)

#Calculate classification accuracy

sum(diag(test_predict))/sum(test_predict)

# classification error

1-sum(diag(tab))/sum(tab)

