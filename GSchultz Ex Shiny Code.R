
library(shiny)
library(datasets) # datasets on R 
library(tidyverse) # used to view(trees)

# This is a made up variable added to the trees dataset to provide 
# a count of fallen cherries/tree.
new_trees <- mutate(trees, Cherry = sample(1:25, 31, replace=TRUE)) 

ui <- fluidPage(
  
  titlePanel("Cherry Trees"),
  
  sidebarLayout(
    
    sidebarPanel(
    
      #input variable to compare to cherry count
      selectInput("variable", "Variable:",
                  c("Circumference" = "Girth",
                    "Height" = "Height",
                    "Volume of Timber" = "Volume")),
      
      checkboxInput("outliers", "Show outliers", TRUE) # Show outliers checkbox
      # a smooth line checkbox could be added here 
    ),
    
    mainPanel(
      
      plotOutput("treePlot")
      
    )
  )
)
server <- function(input, output) {
  
  formulaText <- reactive({
    paste(input$variable, "~ Cherry")
  })
  
  output$caption <- renderText({
    formulaText()
  })

  output$treePlot <- renderPlot({
    plot(as.formula(formulaText()),
            data = new_trees,
            outline = input$outliers,
            col = "red", pch = 20)
  })
  
}

shinyApp(ui, server)
