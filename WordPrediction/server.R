#server.R

# load("data/g1to6_top3.Rdata", envir=.GlobalEnv)
source("predTop3.R")

library(shiny)

shinyServer(
  function(input, output, session){
    
    clean <- reactive({CleanText(input$inputWords)})
    word <- reactive({MatchPredict(clean())})
    
    output$cleanWords <- renderText(paste(clean()))
    
    output$predWord1 <- renderText({paste(word()[1])})

    output$predWord2 <- renderText({paste(word()[2])})

    output$predWord3 <- renderText({paste(word()[3])})
    
    # labeled text buttons interactively controlled in ui.R
    output$pred1_label <- renderText({
      paste(word()[1])
    })
    output$pred1a_label <- renderText({
      paste(word()[1])
    })
    output$pred2_label <- renderText({
      paste(word()[2])
    })
    output$pred3_label <- renderText({
      paste(word()[3])
    })
    
    # predict word candidate #1
    observe({
      if (input$pred1 == 0) return()
      isolate({
        updateTextInput(session, "inputWords",
                        value = paste(input$inputWords, word()[1]))
      })
    })

    observe({
      if (input$pred1a == 0) return()
      isolate({
        updateTextInput(session, "inputWords",
                        value = paste(input$inputWords, word()[1]))
      })
    })

    # predict word candidate #2
    observe({
      if (input$pred2 == 0) return()
      isolate({
        updateTextInput(session, "inputWords",
                        value = paste(input$inputWords, word()[2]))
      })
    })
    
    # predict word candidate #3
    observe({
      if (input$pred3 == 0) return()
      isolate({
        updateTextInput(session, "inputWords",
                        value = paste(input$inputWords, word()[3]))
      })
    })
    
  })