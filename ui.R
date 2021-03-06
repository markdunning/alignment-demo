
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Alignment Demo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("theSeq", "Your Sequence",choices=c("AGGCT", "TGTTA","AGGCT","TGGGA","GAGGA","GTGAG")),
      sliderInput("startPos",
                  "Start Position:",
                  min = 1,
                  max = 50,
                  value = 1,animate = TRUE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("seqPlot",height=300),
      plotOutput("refPlot",height=300),
      plotOutput("matchPlot",height=100)
    )
  )
))
