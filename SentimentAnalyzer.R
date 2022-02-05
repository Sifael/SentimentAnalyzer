" =====================================================
            BUIDING SENTIMENT ANALYSIS APP
======================================================"

library(shiny)
library(shinydashboard)
library(shinyWidgets)



"===============================
           HEADER
==============================="
header = dashboardHeader( title = "Sentiment Analyzer")




"===============================
           SIDEBAR
==============================="

sidebar = dashboardSidebar(
  
    sidebarMenu(
      menuItem( text = "Sentiment Analyzer", icon = icon('fire'), tabName = "sentiment_analyzer" ),
      menuItem( text = "About Sentiment Analyzer", icon = icon("bars"), tabName = "about_sentiment_analyzer")
    )
  
)


"===============================
           BODY
==============================="
body = dashboardBody(
  
  tabItems(
    tabItem( tabName = "sentiment_analyzer", uiOutput("sentiment_analyzer") ),
    tabItem( tabName = "about_sentiment_analyzer")
  )
  
)


"===============================
          SERVER
==============================="

text_placeholders = c("The pizza was amazing", "The artist was not impressive", "Great music and atmosphere")
server = function(input, output){
  
  
  # REACTIVE METHOD
  text_input = eventReactive( input$run_sentiment, { input$user_input }  )
  
  
  # MAIN SENTIMENT UI
  output$sentiment_analyzer = renderUI({
      
       div(
            style="padding-top: 5rem; text-align: center;
                   display: flex; align-items: center; flex-direction: column; margin: auto;",
            textAreaInput( inputId = "user_input", 
                           label = h4("Enter Your Text for Sentiment Analysis: "),
                           placeholder = sample(text_placeholders, 1),
                           width = "60%", rows = 13,
                           resize = "both"),
            actionBttn( inputId = "run_sentiment",
                        label = "Run Sentiment", 
                        style = "jelly", 
                        color = "primary",
                        no_outline = TRUE), br(),br(),
            uiOutput("sentiment_prediction")
            
       )  
    
  })
  
  # SENTIMENT PREDICTION
  output$sentiment_prediction = renderUI({
    
    if ( text_input() == "" ){  div(  h4("You have not entered any text for classification") ) }
    else { 
        
      div(
        h4(tags$b("Your Text: ") , text_input() ),
        h4(tags$b("Sentiment Classification: "), "Sentiment"  ),
        h4(tags$b("Probability: "), "Probability Value" ),
 
      )}
  })
  
}





"===============================
          RUN APP
==============================="

shinyApp( ui = dashboardPage( header = header, sidebar = sidebar, body = body), server = server )
