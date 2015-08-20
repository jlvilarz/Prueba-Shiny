library(shiny)
library(UsingR)
setwd("C:/Users/jlvilarz/Documents/GitHub/Prueba-Shiny")
getwd()


sample.compound <- function(num.sim,lambda,alpha,beta){
  conta <- 0
  sample <- NULL
  while (conta < num.sim) {
    
    n <- rpois(1,lambda)
    cuantia <- rgamma(n,alpha,beta)
    sample <- c(sample,sum(cuantia))
    conta <- conta + 1
  }
  sort(sample)
}

#sample <- sample.compound(input$text4,input$text1,input$text2,input$text3)
shinyServer(
  function(input, output) {
    
    # output$simulation <- renderPrint({c(input$NumSim,input$lambda,input$alpha,input$beta)})
#       NumSim <- input$NumSim
#       lambda <- input$lambda
#       a <- input$alpha
#       b <- input$beta
      # sam <- reactive({sample.compound(input$NumSim,input$lambda,input$alpha,input$beta)})
      
      output$newHist <- renderPlot({
        set.seed(input$seed)
        sample <- sample.compound(input$NumSim,input$lambda,input$alpha,input$beta)
        hist(sample, 
             xlab='compound random variable', freq=FALSE, col='lightgreen',main=paste('Histogram of compound Poisson(',input$lambda,')',
                                                                                      '-Gamma(',input$alpha,',',input$beta,') ',
                                                                                      'random variable'))
        usr <- par( "usr" )
        #usr
        
        p <- input$Probability
        VaR <- round(quantile(sample,p),0)
        TVaR <- round((length(sample[sample>VaR]+1))^(-1)*sum(sample[sample>VaR]),0)
        lines(c(VaR, VaR), c(0, usr[4]-usr[4]/10),col="red",lwd=5)
        text(VaR+(usr[2]-usr[1])/13,9*usr[4]/10,paste('VaR ',p,' = ',VaR))
        lines(c(TVaR, TVaR), c(0, 3*usr[4]/4),col="red",lwd=5)
        text(TVaR+(usr[2]-usr[1])/13, 3*usr[4]/4, paste("TVaR ", p,'  =',TVaR))
      })
#       
  }
)
    
# #     
#   }
# )