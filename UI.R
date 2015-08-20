# This is the Shiny project
library(shiny)

setwd("C:/Users/jlvilarz/Documents/GitHub/Prueba-Shiny")
getwd()

shinyUI(pageWithSidebar(
  headerPanel("Risk Measures for a Compound Poisson-Gamma distribution"),
  sidebarPanel(
    h1('VaR and TVaR sample estimates'),
    h3('To simulate the compound distribution, we must fix the parameters 
       of Poisson and gamma distributions, the simulation number, the risk measures probability level
       and finally the simulation seed'),
    h4('Poisson parameter'),
    numericInput('lambda','lambda',10,min=0.2,max=50,step=0.2),
    h4('Gamma parameters'),
    numericInput('alpha','alpha',30,min=0.2,max=50,step=0.5),
    numericInput('beta','beta',11,min=0.2,max=50,step=0.5),

    h4('Number of simulations'),
    numericInput('NumSim','NumSim',10000,min=1000,max=30000,step=1000),
    
    sliderInput('Probability', 'Risk measures probability level',value = 0.9, min = 0.05, max = 0.995, step = 0.005,),
    
    h4('Simulation seed'),
    numericInput('seed','seed',1000,min=10,max=10000,step=10)
  ),
  mainPanel(
    plotOutput('newHist'),
    h3('Once we have stored the simulation in the variable "sample", we estimate the VaR and TVaR by means of:'),
    h4(code('p <- input$Probability')),
    h4(code('VaR <- round(quantile(sample,p),0)')),
    h4(code('TVaR <- round((length(sample[sample>VaR]+1))^(-1)*sum(sample[sample>VaR]),0)'))
    
  )
))