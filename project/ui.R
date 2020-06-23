library(shiny)
shinyUI(fluidPage(
    titlePanel("predict the species using the factor"),
    sidebarLayout(
        sidebarPanel(
        radioButtons("radio", label = h3("prediction by factors"),
                     choices = list( "Septals"=1,"petals"=2,"both"=3), 
                     selected = 1)
        ),
    mainPanel(
        h3("plot"),
        plotOutput("plot1"),
        h3("Decision tree"),
        plotOutput("plot2"),
        h3("prediction"),
        tableOutput("prediction")
        
    ))
))
