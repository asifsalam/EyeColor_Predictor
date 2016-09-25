#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(ggplot2)
library(dplyr)
data("HairEyeColor")
hair_eye_color <- as.data.frame(HairEyeColor,stringsAsFactors = FALSE)
hair_eye_color$Eye <- factor(hair_eye_color$Eye,levels=c("Brown","Blue","Hazel","Green"))
eye_cols <- c("#511515","#000099","#776536","#004d00")
#hair_color <- "Brown"
#sex <- "Female"

num_samples <- function(id_hair_color,id_sex) {
    hair_eye_color$Sex <- tolower(hair_eye_color$Sex)
    selected_data <- hair_eye_color %>% filter(Hair==id_hair_color,Sex==tolower(id_sex))
    predicted_eye_color <- sample(selected_data$Eye,1,replace=FALSE, prob=selected_data$Ratio)
    output_text <- paste0("Your ",id_sex," target with a hair color ",id_hair_color," most likely has ",
                          predicted_eye_color," eyes.")
    output_text <- paste0(predicted_eye_color)
    return(output_text)
}

predict_eye_color <- function(id_hair_color,id_sex) {
    hair_eye_color$Sex <- tolower(hair_eye_color$Sex)
    selected_data <- hair_eye_color %>% filter(Hair==id_hair_color,Sex==tolower(id_sex))
    predicted_eye_color <- sample(selected_data$Eye,1,replace=FALSE, prob=selected_data$Ratio)
    return(paste0(predicted_eye_color))
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    output$hair_color <- renderText({
        toupper(input$id_hair_color)
    })
    output$sex <- renderText({
        toupper(paste0(input$id_sex,","))
    })
    output$predicted_eye_color <- renderText({
        predict_eye_color(input$id_hair_color,input$id_sex)
    })
    
  output$eye_color_plot <- renderPlot({
      selected_data <- hair_eye_color %>% filter(Hair==input$id_hair_color,Sex==input$id_sex)
      #selected_data <- hair_eye_color %>% filter(Hair=="Brown",Sex=="Female")

      selected_data <- selected_data %>% mutate(Ratio=Freq/sum(Freq)) %>% arrange(desc(Ratio))
      selected_data$Eye <- as.factor(selected_data$Eye)
      gg <- ggplot(selected_data,aes(x=Eye,y=Ratio,fill=Eye)) + geom_bar(stat="identity") + 
          scale_fill_manual(values=eye_cols, name="Eye Color")
      gg <- gg + ggtitle(paste0("Probability of Eye Colour\nTarget: ",input$id_sex, "\nHair Color: ",input$id_hair_color)) + 
          xlab("\nEye Colour") + ylab("Probability\n")
      print(gg)
      #plot(selected_data$Ratio,xlim=c(0,10),ylim=c(0,1))
      
  })
  
})
