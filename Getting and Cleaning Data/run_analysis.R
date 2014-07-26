## read the dataset which the assignment need

  trainla<-read.table("./UCI HAR Dataset/train/y_train.txt")
  trainda<-read.table("./UCI HAR Dataset/train/X_train.txt")
  trainsub<-read.table("./UCI HAR Dataset/train/subject_train.txt")
  testla<-read.table("./UCI HAR Dataset/test/y_test.txt")
  testda<-read.table("./UCI HAR Dataset/test/X_test.txt")
  testsub<-read.table("./UCI HAR Dataset/test/subject_test.txt")
  feature<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=F)
  
##coerce trainla and testla to factor for merging
  
  testla<-factor(as.character(testla$V1),levels=c("1","2","3","4","5","6"),
                 labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                          "SITTING", "STANDING", "LAYING"))
  trainla<-factor(as.character(trainla$V1),levels=c("1","2","3","4","5","6"),
                  labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                           "SITTING", "STANDING", "LAYING"))

##merge the testla,testsub,testda to a newdata named "test"
##merge the trainla,trainsub,trainda to a newdata named "train"
  
  test<-cbind(testla,testsub,testda)
  train<-cbind(trainla,trainsub,trainda)

##name test and train,then merge them to a new data named da
  
  names(test)<-c("activity","people",feature$V2)
  names(train)<-c("activity","people",feature$V2)
  da<-rbind(test,train)

##Extracts only the measurements on the mean and standard deviation 
##for each measurement.then we get a new data named newda
  
  grep("mean|Mean" ,names(da),fixed=F)
  meanind<-grep("mean\\(" ,names(da),fixed=F)
  stdind<-grep("std" ,names(da),fixed=F)
  newda<-da[,c(1,2,meanind,stdind)]

##creates a independent tidy data set with the average of each 
##variable for each activity and each subject.   
  
  nnewdata<-aggregate(newda,by=list(kindsofactivity=newda$activity,
                                    subjectpeople=newda$people),mean)
  nnewdata<-nnewdata[,-c(3:4)]
