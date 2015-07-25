require(dplyr)
setwd("~/Documents/Cleaning_data_proj") #Change this for your environment
#clean up the test data
testData<-read.table("test/X_test.txt",header=FALSE,sep="")
featureLabels<-read.table("features.txt")
featureLabelArray<-array(featureLabels$V2)
#If it is necessary to tidy the names up (apparently not though):
#featureLabelArray<-as.array(apply(featureLabelArray, 1,function(x) gsub("[()]","",x)))
#featureLabelArray<-as.array(apply(featureLabelArray, 1,function(x) gsub("[,]","_",x)))
names(testData)<-featureLabelArray
testActivityLabels<-read.table("test/y_test.txt")
names(testActivityLabels)<-"ActivityNumber"
testData<-cbind(testActivityLabels, testData)
testSubject<-read.table("test/subject_test.txt")
names(testSubject)<-"subject"
testData<-cbind(testSubject,testData)
#Clean up the training data (yes, would be better to make a function to do this stuff; I used find and replace)
trainData<-read.table("train/X_train.txt",header=FALSE,sep="")
featureLabels<-read.table("features.txt")
featureLabelArray<-array(featureLabels$V2)
names(trainData)<-featureLabelArray
trainActivityLabels<-read.table("train/y_train.txt")
names(trainActivityLabels)<-"ActivityNumber"
trainData<-cbind(trainActivityLabels, trainData)
trainSubject<-read.table("train/subject_train.txt")
names(trainSubject)<-"subject"
trainData<-cbind(trainSubject,trainData)
mergedData<-rbind(testData,trainData)
keepMergedData<-select(mergedData,matches("(mean\\(\\)|std\\(\\)|subject|ActivityNumber)"))
#Replace activity numbers with names, and put it as the first column:
activityLabels<-read.table("activity_labels.txt",header=FALSE)
names(activityLabels)[1]<-"ActivityNumber"
names(activityLabels)[2]<-"ActivityName"
cleanData<-left_join(keepMergedData,activityLabels,by="ActivityNumber")
activityNameColNum<-grep("^ActivityName$", colnames(cleanData))
activityNameArrange<-setdiff(c(1:ncol(cleanData)),activityNameColNum)
cleanData<-cleanData[,c(activityNameColNum,activityNameArrange)]
cleanData<-select(cleanData,-ActivityNumber)#We don't need this variable anymore

#Assignment part 5. 'The average of each variable for each activity and each subject
finalData<-cleanData %>% group_by(ActivityName,subject) %>% summarise_each(funs(mean))
