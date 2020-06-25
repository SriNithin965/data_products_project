library(shiny)
shinyUI(fluidPage(
    titlePanel("predict the species using the factor"),
    sidebarLayout(
        sidebarPanel(
        radioButtons("radio1", label = h3("prediction by which algrothim"),
                     choices = list( "rf:random forest"=1,"gbm:multivarite regression"=2,"rpart:decision tree"=3), 
                     selected = 1),
        sliderInput("pre", "select the size of prediction:", min = 1, max = 150, value = 15)
    ),
    mainPanel(
        h3("plot"),
        plotOutput("plot1"),
        h3("Decision tree"),
        plotOutput("plot2"),
        h3("prediction"),
        plotOutput("prediction"),
        plotOutput('plot3')
    ))
))
