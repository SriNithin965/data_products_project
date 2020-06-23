library(shiny)
library(corrplot)
library(rpart)
library(rpart.plot)
library(caret)
library("gbm")
data(iris)
shinyServer(function(input,output){

  inTrain1 <- createDataPartition(y=iris$Species,p=0.5,list = FALSE)
  training1 <- iris[inTrain1,]
  testing1 <- iris[-inTrain1,]
  model1 <- train(Species~.,data=training1,method = "rf")
  pred1 <- reactive({pred <- predict(model1,testing1)
    testing1$predRight <- pred ==testing1$Species
    table(pred,testing1$Species)})
  
  iris2 <- subset(iris,select= c(Petal.Length,Petal.Width,Species))
  inTrain2 <- createDataPartition(y=iris2$Species,p=0.6,list = FALSE)
  training2 <- iris2[inTrain2,]
  testing2 <- iris2[-inTrain2,]
  model2 <- train(Species~.,data=training2,method = "rf")
  pred2 <- reactive({pred <- predict(model2,testing2)
   testing2$predRight <- pred ==testing2$Species
   table(pred,testing2$Species)})
    
  iris_3 <- subset(iris,select = c(Sepal.Length,Sepal.Width,Species))
  inTrain3 <- createDataPartition(y=iris_3$Species,p=0.5,list = FALSE)
  training3 <- iris_3[inTrain3,]
  testing3 <- iris_3[-inTrain3,]
  model3 <- train(Species~.,data=training3,method = "rf")
  pred3 <- reactive({pred <- predict(model3,testing3)
    testing3$predRight <- pred ==testing3$Species
    table(pred,testing3$Species)})
    
    output$plot1 <- renderPlot({
      if(input$radio==3){
      corrPlot <- cor(training1[, -length(names(training1))])
      corrplot(corrPlot, method="color")}
      else if(input$radio == 2){
        corrPlot <- cor(training2[, -length(names(training2))])
        corrplot(corrPlot, method="color") 
      }
      else{
        corrPlot <- cor(training3[, -length(names(training3))])
        corrplot(corrPlot, method="color")
      }
      })
    output$plot2 <- renderPlot({
      if(input$radio==3){
        treeModel <- rpart(Species ~ ., data=training1, method="class")
        prp(treeModel)}
      else if(input$radio == 2){
        treeModel <- rpart(Species ~ ., data=training2, method="class")
        prp(treeModel) 
      }
      else{
        treeModel <- rpart(Species ~ ., data=training3, method="class")
        prp(treeModel)
      }
    })
    output$prediction <- renderTable({
      if(input$radio==3){
      pred1()
      }
      else if (input$radio == 2){
        pred2()
      }
      else {
        pred3()
      }
      })
})

