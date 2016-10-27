#ui.R

library(shiny)

shinyUI(fluidPage(
  theme = "bootstrap.css",
  
  titlePanel(h1(div("Simply Predicting Your Next Word", style="color:red"),
                align= "center")),
  
  sidebarLayout(
    
    sidebarPanel(
      
      h3(div("What does this App do?",style="color:yellow")), 
      h3("This App predicts your next word based on what words you have typed. 
          Simply begin typing English words into the text box to test it out.
          The App will instaneously clean and print your words. Based on your 
          selection, the App will predict one word or three words as candidates 
          for your next word. Currently, this App only supports English language, 
        and it will remove non-alphanumeric characters for prediction."),
      br(),
      h4("Lear more about this App:",
          tags$a(href="https://github.com/zweinstein/SwiftKey_Text_Prediction", "Click here!"))
      

      
    ),
    
    mainPanel(
      h3("Please type English words in this box (separate each word by space):"),
      textInput("inputWords", "", width='80%', placeholder="Type your text here..."),
      h3(div("You have typed:",style="color:yellow")),
      h4('(after removing non-alphanumeric characters)'),
      h3(textOutput("cleanWords")),
      tags$head(tags$style("#cleanWords{color: red;
                                 font-size: 30px;
                                 font-style: italic;
                                 }")),

      br(),
      
      h3(div("What's the next word?",style="color:yellow")),
      h4(radioButtons("numPred", label = "", 
                   choices = list("Show me your best guess!" = 1, 
                                  "Show me your top 3 guesses!" = 3),
                   selected = 1)
        ),
      
      conditionalPanel(condition = "input.numPred == 1",
                       actionButton("pred1a", label = h3(textOutput("pred1a_label")),
                                    class="btn btn-danger")),
      
      conditionalPanel(condition = "input.numPred == 3",
                       actionButton("pred1", label = h3(textOutput("pred1_label")),
                                    class="btn btn-danger"),
                       actionButton("pred2", label = h3(textOutput("pred2_label")),
                                    class="btn btn-success"),
                       actionButton("pred3", label = h3(textOutput("pred3_label")),
                                    class="btn btn-info")),
      br(),
      h4('Acknowledgement:'),
      h4('Thanks to Professors Jeff Leek, Roger Peng, and Brian Caffo (Johns Hopkins University)
         for organizing the Data Science Specialization on Coursera.'),
      h4('Thanks to SwiftKey (our corporate partner in this capstone project) for providing the raw
         text documents collected from Twitter, blogs and news sources.'),
      h4('Thanks to my brilliant Coursera classmates for sharing their insights and discussions on 
         natural language processing.'),
      # h4("Part of the user interface of this App was inspired and learnt from",
      #    tags$a(href="http://rpubs.com/herchu1/shinytextprediction", "Hernán Foffani's previous App")), 
         
      br(),
      h4("Powered by:", 
         tags$img(src='RStudio-Ball.png', heigth=60, width=60),
         align ="right"),
      h4("Developed by:", 
         tags$img(src='ZW.jpg', heigth=60, width=50),
         align="right")
      
    )
  )
)
)
