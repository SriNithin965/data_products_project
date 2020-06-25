library(shiny)
library(corrplot)
library(lattice)
library(ggplot2)
library('e1071')
library(rpart)
library(rpart.plot)
library(caret)
library(gbm)
library(randomForest)
data(iris)
shinyServer(function(input,output){
  model1 <-reactive({
    if(input$radio1==1){
    model <- train(Species~.,data=iris,method = "rf")
  }
  else if(input$radio1==2){
    model <- train(Species~.,data=iris,method = "gbm")
  }
  else{
    model <- train(Species~.,data=iris,method = "rpart")
  }
  }) 
   output$plot1 <- renderPlot({
      corrPlot <- cor(iris[, -length(names(iris))])
      corrplot(corrPlot, method="color")
})
  pred <- reactive({ 
    val <- input$pre
    test <- iris[1:val,]
    pred <- predict(model1(),test)
   test$predRight <- pred ==test$Species
   test
  })
    output$prediction <- renderPlot({
        test <- pred()
      qplot(Petal.Width,Petal.Length,colour=predRight,
            data=test,main="predictions")
      })
    
      output$plot2 <- renderPlot({
        treeModel <- rpart(Species ~ ., data=iris, method="class")
        prp(treeModel)
    })
    output$plot3 <- renderPlot({
      test <- pred()
      qplot(Sepal.Width,Sepal.Length,colour=predRight,
            data=test,main="predictions")
    })
})

