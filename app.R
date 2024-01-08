# Install required packages if not already installed
library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)
library(ggplot2)

# Sample dataset based on the CTR data provided
data <- data.frame(
  Day = paste("Day", 1:10),
  LeftSidebar = c(2.5, 2.7, 2.8, 2.6, 3.0, 2.4, 2.9, 2.5, 2.6, 2.7),
  CenterPage = c(3.8, 3.5, 4.0, 3.7, 3.9, 3.6, 4.1, 3.4, 3.8, 3.9),
  RightSidebar = c(3.1, 2.9, 3.0, 3.2, 3.3, 2.8, 3.4, 3.1, 3.2, 3.5)
)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "CTR Analysis App"),
  dashboardSidebar(
    fileInput("file", "Upload CSV File"),
    textInput("placement_input", "Enter Day", value = "Day 1"),
    numericInput("Left_input","Enter Left Sidebar", value = 3),
    numericInput("Center_input", "Enter Center Page", value = 3),
    numericInput("Right_input","Enter Right Sidebar", value = 3),
    actionButton("add_data_button", "Add Data"),
    actionButton("reset_button", "Reset Data"),
    h4("Perform Statistical Analysis"),
    actionButton("analyze_button", "Analyze")
   
  ),
  dashboardBody(
    useShinyjs(),
    fluidRow(
      column(
        width = 12,
        h2(tags$b("Data Table")),
        DTOutput("table")),
    column(
      width = 6,
    h4(tags$b("Summary Output")),
    verbatimTextOutput("summary_output")),
    column(
      width = 6,
      h2(tags$b("About t-test")),
      textOutput("interpretation")
    ),
    column(
      width = 12,
      h4(tags$b("Visualizations")),
      plotOutput("barplot")),
  )
)
)

# Define server
server <- function(input, output) {
  data_input <- reactiveVal(data)
  
  observeEvent(input$add_data_button, {
    new_data <- data.frame(
      Day = input$placement_input,
      LeftSidebar = input$Left_input,
      CenterPage = input$Center_input,
      RightSidebar = input$Right_input
    )
    data_input(rbind(data_input(), new_data))
  })
  
  observeEvent(input$file, {
    if (!is.null(input$file$datapath)) {
      uploaded_data <- read.csv(input$file$datapath)
      data_input(uploaded_data)
    }
  })
  observeEvent(input$reset_button, {
    data_input(NULL)
  })
  
  output$table <- renderDT({
    datatable(data_input(), rownames = FALSE)
  })

  output$interpretation <- renderText({
    " The statistical analysis performed in the provided R Shiny application involves a t-test. Specifically, it uses a t-test to compare the means of different groups within the data. A t-test is a statistical hypothesis test that is used to determine if there is a significant difference between the means of two groups.

In the context of the application, the t-test is applied to assess whether there is a significant difference in Click-Through Rates (CTR) based on the placement of advertisements (Left Sidebar, Center Page, Right Sidebar). The null hypothesis (H0) typically posits that there is no significant difference, while the alternative hypothesis (H1) suggests that there is a significant difference.

The output of the t-test includes a p-value, which is used to determine the statistical significance of the observed differences. If the p-value is below a certain significance level (commonly 0.05), it suggests that there is enough evidence to reject the null hypothesis in favor of the alternative hypothesis, indicating a significant difference in CTR among the ad placement groups.

The interpretation provided in the summary output of the Shiny application indicates whether the p-value is less than 0.05 and whether the results are statistically significant at the 0.05 level. This information helps users make informed decisions about the effectiveness of different ad placement strategies based on CTR." 
  })
  observeEvent(input$analyze_button, {
    result <- t.test(data_input()[-1])
    output$summary_output <- renderText({
      paste("P-Value:", signif(result$p.value, 4), "\n",
            "Significant at 0.05 level:", ifelse(result$p.value < 0.05, "Yes", "No"))
    })
    means <- colMeans(data_input()[, -1])
    output$barplot <- renderPlot({
      
      # Barplot
      barplot(
        height = means,
        names.arg = names(means),
        col = c("skyblue", "lightgreen", "coral"),
        main = "Average CTR by Ad Placement",
        xlab = "Ad Placement",
        ylab = "Average CTR")
    })
  })
}

# Run the application
shinyApp(ui, server)
