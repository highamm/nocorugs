# load packages
library(shiny)
library(tidyverse)

# load data (from web)
nascar <- read_csv("https://myslu.stlawu.edu/~iramler/data/nascar.csv")
var_names <- names(nascar)[-1] # dump the Driver name

# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Application title
    titlePanel("NASCAR Driver Data"),

    # Sidebar with a select box inputs for variables
    sidebarLayout(
        sidebarPanel(
            selectInput("yvar", label = h3("Select y-variable"), 
                        choices = var_names, 
                        selected = "DriverRating"),
            selectInput("xvar", label = h3("Select x-variable"), 
                        choices = var_names, 
                        selected = "AvgFinish"),
            
            ),
        # Show a plot of the variables in main panel
        mainPanel(
           plotOutput("scatPlot")
        )
    )
)

# Define server logic required to draw a scatterplot
server <- function(input, output) {
    output$scatPlot <- renderPlot({
        ggplot(data = nascar, 
               mapping = aes_string(y = input$yvar,
                                    x = input$xvar)
               ) +
            geom_point() +
            geom_smooth()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
