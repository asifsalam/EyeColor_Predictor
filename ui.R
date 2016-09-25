#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
#hair_colors <- unique(hair_eye_color$Hair)
eye_cols <- c("#511515","#000099","#776536","#004d00")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
  # Application title
  titlePanel("(Private) Eye Color Predictor"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h3("Clues"),
        radioButtons("id_sex","Suspect's Sex:",
                          c("Female" = "Female",
                            "Male" = "Male")),
        selectInput("id_hair_color","Suspect's Hair Color:",
                   c("Black","Blond","Brown","Red"),selected=1),
        br(),
        br(),
        p(em("* Also useful in other situations.  Concerned parents whose child is bringing someone for dinner need no longer
             guess the color of the friend's eyes. Even if the online profile only describes beautiful hair and says nothting
             about eye color, with this tool, the date can still be pleasant. In fact, with just a little foresight, you no longer
             need to be shocked by the color of someone's eyes. Our AI tells you exactly what to expect."))
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        
        h4("Our patent pending clever AI enables leading Private Investigators to predict the color of a target's eye, based simply on a 
           glimpse of the hair.*"),
        strong("Instructions: Select your target's sex and hair color from the left to get an accurate prediction of their eye color.",
               style="color:blue"),
        br(),
        br(),
        strong("Prediction",style="color:red"),
        span("Our AI predicts that the eye color of your ",span(textOutput("sex",inline=TRUE))),
        span(textOutput("hair_color",inline=TRUE)),
        span(" haired target is:"),
        #div(id="prediction",style="background:#FDE4DE",strong("test")),
        strong(" ",textOutput("predicted_eye_color",inline=TRUE),"  ",style="background:#FFD2D2"),
        br(),
        em("The AI is only human, and can make mistakes.  See the graph below for other possible colors."),
        br(),
        br(),
        plotOutput("eye_color_plot")
    )
  )
))
