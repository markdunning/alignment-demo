
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

refSeq <- "TTGGGAGGCTAAGGCAGGAAGAGGCTGGGAGACAGAGGCTACAGTGAGCCGAGATCACGCCACTGCACTCCAGCCTCAGTGACAGAGCAGGACCCTGTCTT"
library(RColorBrewer)
mypal <- brewer.pal(9,"Set1")
names(mypal) <- c("red","blue","green","purple","orange","yellow","brown","pink","grey")


library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  
  getSeq <- reactive({
    
    mySeq <- strsplit(input$theSeq,"")[[1]]
    
    
  })
  
  output$seqPlot <- renderPlot({
    

    mySeq <- getSeq()

    df <- data.frame(Read = mySeq, Base = 1:length(mySeq))
    gg <- ggplot(df, aes(x=Base,y=1,fill=Read,label=Read)) + geom_tile() + geom_text() 
    gg <-  gg +  scale_fill_manual(values=c("A" = as.character(mypal[3]),"C"=as.character(mypal[2]),"G"=as.character(mypal[6]),"T"=as.character(mypal[1]))) 
    gg <- gg + theme(axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank(),panel.background =  element_blank()) + theme(legend.position="none")
    breaks <- data.frame(xs = 0.5:(length(mySeq)+0.5))
    gg <- gg + geom_vline(data=breaks, aes(xintercept=xs)) + xlab("")
    gg
  })
  
  output$refPlot <- renderPlot({
    
    refSeq <- strsplit(refSeq,"")[[1]]
    
    startPos <- input$startPos
    endPos <- input$startPos + nchar(input$theSeq)-1
    
#    mySeq <- strsplit(input$theSeq,"")[[1]]
    refSeq <- refSeq[startPos:endPos]
    
    df <- data.frame(Ref = refSeq, Base = startPos:endPos)
    gg <- ggplot(df, aes(x=Base,y=1,fill=Ref,label=Ref)) + geom_tile() + geom_text() 
    gg <- gg +  scale_fill_manual(values=c("A" = as.character(mypal[3]),"C"=as.character(mypal[2]),"G"=as.character(mypal[6]),"T"=as.character(mypal[1]))) 
    gg <- gg + theme(axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank(),panel.background =  element_blank()) + theme(legend.position="none")
    breaks <- data.frame(xs = (startPos-0.5):(endPos+0.5))
    gg <- gg + geom_vline(data=breaks, aes(xintercept=xs)) + xlab("")
    gg
  })

  output$matchPlot <- renderPlot({

    refSeq <- strsplit(refSeq,"")[[1]]
    
    startPos <- input$startPos
    endPos <- input$startPos + nchar(input$theSeq)-1
    
    mySeq <- strsplit(input$theSeq,"")[[1]]
    refSeq <- refSeq[startPos:endPos]
    
    df <- data.frame(Ref = refSeq, Read = mySeq, Match = refSeq==mySeq,Base = startPos:endPos)
    gg <- ggplot(df, aes(x=Base,y=1,fill=Match,label=Ref)) + geom_tile() #+ geom_text() 
    gg <- gg  + scale_fill_manual(values=c("TRUE" = as.character(mypal[8]),"FALSE"="white"))
    gg <- gg + theme(axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank(),panel.background =  element_blank()) + theme(legend.position="none")
    breaks <- data.frame(xs = (startPos-0.5):(endPos+0.5))
    gg <- gg + geom_vline(data=breaks, aes(xintercept=xs)) + xlab("")
    gg
  })

})
