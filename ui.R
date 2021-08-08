library(shiny)
library(shinyWidgets)
library(plotly)


fluidPage(
tags$style('.container-fluid {
                             background-color: #00000;
              }'),tags$h2("COVID-19 : Simulation",style={"color:#0080FF;font-size: 35px !important"}),
  #titlePanel(title=div(img(src="sier.png"), "My Title")),
             #vs Healthcare Capacity"),
  hr(),
  #p(div(HTML("Disclaimer: This simulation is for research and educational purposes only and is not intended to be a tool for decision-making. There are many uncertainties and debates about the details of COVID-19 infection and transmission and there are many limitations to this simple model. This work is licensed under a <a href=https://creativecommons.org/licenses/by-sa/4.0/> Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) License </a>"))),
  
  
  sidebarLayout(
    
    sidebarPanel(
      
      fluidRow(
        
        column(width=8,
               
               setSliderColor(c(rep("#b2df8a", 3)), sliderId=c(8,9,10)),
               h4(div(HTML("<em>Set parameters...</em>"))),
               sliderInput("IncubPeriod", "Duration of incubation period", 0, 20, 5, step=0.5, post = " days"),
               sliderInput("DurMildInf", "Duration of mild infections", 0, 20, 6, step=1, post = " days"),
               sliderInput("FracSevere", "% of infections that are severe", 0, 100, 15, step=1, pre="%"),
               sliderInput("DurHosp", "Duration of severe infection", 0, 10, 6, step=1, post = " days"),
               sliderInput("FracCritical", "% of infections that are critical",0, 20, 5, step=1, pre="%"),
               sliderInput("TimeICUDeath", "Duration critical infection", 0, 30, 8, step=1, post = " days"),
               sliderInput("ProbDeath", "Death rate", 0, 100, 40, step=1, pre="%"),
               #htmlOutput("CFR"),
               br(),
               #hr()
               
         #      ),
        #column(width=6,

               h4(div(HTML("<em>Set transmission rates...</em>"))),
               sliderInput("b1", div(HTML("Mild infections")), 0, 3, 0.5, step=0.01, post="/day"),
               sliderInput("b2", div(HTML("Severe infections")),0, 3, 0.1, step=0.01, post="/day"),
               sliderInput("b3", div(HTML("Critical infections")),0, 3, 0.1, step=0.01, post="/day"),
               # radioButtons("AllowSeason", "Allow seasonality in transmission?",
               #              choices = list("Yes" = "Yes","No" = "No"),inline=TRUE, selected="No"),
               conditionalPanel(
                 condition="output.square == 'Yes'",
                 sliderInput("seas.amp", "Amplitude of seasonality", 0, 100, 0, step=10, pre="%"),
                 sliderInput("seas.phase", "Day of peak transmission (relative to t=0)", -365, 365, 0, step=1, post = " days"),
               ),
               # radioButtons("AllowAsym", "Allow asymptomatic infections?",
               #              choices = list("Yes" = "Yes","No" = "No"),inline=TRUE,selected="No"),
               conditionalPanel(
                 condition="output.square == 'Yes'",
                 sliderInput("FracAsym", "% of infections that are asymptomatic", 0, 100, 30, step=1, pre="%"),
                 sliderInput("DurAsym", "Duration of asymptomatic infections", 1, 20, 6, step=1, post = " days"),
                 sliderInput("b0", div(HTML("Asymptomatic transmission rate")), 0, 3, 0.5, step=0.02, post="/day"),
               ),
                      # radioButtons("AllowPresym", "Allow pre-symptomatic transmission?",
                      #              choices = list("Yes" = "Yes","No" = "No"),inline=TRUE, selected="No"),
               conditionalPanel(
                 condition="output.square == 'Yes'",
                 sliderInput("PresymPeriod", "Time before symptom onset at which transmission is possible", 0, 3, 2, step=0.5, post = " days"), #Make reactive
                 sliderInput("be", div(HTML("Presymptomatic transmission rate")),0, 3, 0.5, step=0.02, post="/day"),
               ),
        actionButton("reset", "Reset all"),
               hr(),

        )
      )
      # h4(div(HTML("<em>Set simulation values...</em>"))),
      # #sliderInput("LogN", div(HTML("Total population size (log10)")), 1, 9, 3, step=0.1),
      # #htmlOutput("N"),
      # column(width=5,
      #        numericInput("N", div(HTML("Population size:")), value=1000, max=10^10, min=1000, step=1000)
      # ),
      # column(width=5,
      #        numericInput("InitInf","Initial # infected:",value = 1, min = 1, step = 1)
      # ),
      # br(),
      # sliderInput("Tmax", div(HTML("Maximum time")),0, 1000, 150, step=50, post=" days"),
      # actionButton("reset", "Reset all"),    
      # width=5
    ),
    
    mainPanel(
              img(src='images/SEIR_labeled.png',width=600,height=250),
      
      #p(div(HTML("Test")))
      navbarPage("Output:",
                 
                 tabPanel("Projection",
                          fluidPage(
                            fluidRow(
                              
                              h3("Graph :"),
                              #p(HTML("Simulate the natural course of a COVID-19 epidemic in a single population without any interventions.")),
                              
                              plotlyOutput("plot0"),
                              br(),
                              br(),
                              # column(width=6,
                              #        radioButtons("yscale", "Y axis scale:",
                              #                     choices = list("Linear" = "linear","Log10" = "log"),inline=TRUE)
                              #        ),
                              
                              h4(div(HTML("<em>Set simulation values...</em>"))),
                              #sliderInput("LogN", div(HTML("Total population size (log10)")), 1, 9, 3, step=0.1),
                              #htmlOutput("N"),
                              column(width=6,
                                     radioButtons("PlotCombine", "Total infected..",
                                                  choices = list("Yes" = "Yes","No" = "No"),inline=TRUE, selected="Yes")
                              ),
                              column(width = 10,
                              sliderInput("Tmax", div(HTML("Maximum time")),0, 5000, 150, step=50, post=" days"),
                            
                              ),
                              br(),
                              column(width=5,
                                     numericInput("N", div(HTML("Population size:")), value=1000, max=10^10, min=1000, step=1000)
                              ),
                              column(width=5,
                                     numericInput("InitInf","Initial # infected:",value = 1, min = 1, step = 1)
                              ),
                              
                              
                              br()
                              #,p(HTML("<b>User instructions:</b> The graph shows the expected numbers of individuals over time who are infected, recovered, susceptible, or dead over time. Infected individuals first pass through an exposed/incubation phase where they are asymptomatic and not infectious, and then move into a symptomatic and infections stage classified by the clinical status of infection (mild, severe, or critical). A more detailed description of the model is provided in the Model Description tab. The population size, initial condition, and parameter values used to simulate the spread of infection can be specified through the sliders located in the left-hand panel. Default slider values are equal to estimates taken from the literature (see Sources tab). To reset default values, click on the <em>Reset all</em> button located on the bottom of the panel. The plot is interactive: Hover over it to get values, double-click a curve in the legend to isolate it, or single-click to remove it. Dragging over a range allows zooming."))
                            )
                          )
                 )
                 #                ),
                 #                p(HTML("<b>Intervention type: reducing transmission, </b> for example via social distancing or quarantining in the community (for those with mild infection) or better isolation and personal-protective wear in hospitals (for those with more severe infection). Transmission from each of the clinical stages of infection can only be reduced if the user has chosen parameters such that these stages contribute to transmission.")),
                 #                sliderInput("s1C", "Reduction in transmission rate (mild infections) ", 0, 100, 30, pre="%",step=1, animate=TRUE),
                 #                sliderInput("s2C", "Reduction in transmission rate (severe infections) ", 0, 100, 0, pre="%",step=1, animate=TRUE),
                 #                sliderInput("s3C", "Reduction in transmission rate (critical infections) ", 0, 100, 0, pre="%",step=1, animate=TRUE),
                 #                conditionalPanel(
                 #                  condition="input.AllowAsym == 'Yes' || input.AllowPresym == 'Yes' ",
                 #                  sliderInput("s0C", "Reduction in transmission from pre/asymptomatic infections ", 0, 100, 0, pre="%",step=1, animate=TRUE),
                 #                ),
                 #                radioButtons("RoundOneCap", "Round values to nearest integar post-intervention?",
                 #                             choices = list("True" = "True","False" = "False"), inline=TRUE),
                 #              )
                 #              #,p(HTML("<b>User instructions:</b> The graph shows the expected numbers of individuals over time who are infected, recovered, susceptible, or dead over time, with and without an intervention. Infected individuals first pass through an exposed/incubation phase where they are asymptomatic and not infectious, and then move into a symptomatic and infections stage classified by the clinical status of infection (mild, severe, or critical). A more detailed description of the model is provided in the Model Description tab. The population size, initial condition, and parameter values used to simulate the spread of infection can be specified through the sliders located in the left-hand panel. Default slider values are equal to estimates taken from the literature (see Sources tab). The strength and timing of the intervention is controlled by the sliders below the plot. To reset default values, click on the <em>Reset all</em> button located on the bottom of the panel. The plot is interactive: Hover over it to get values, double-click a curve in the legend to isolate it, or single-click to remove it. Dragging over a range allows zooming."))
                 #            )
                 #          )
                 # )

                 # ,tabPanel("Model", br(),
                 #          fluidRow(column(12,
                 #                          withMathJax(),
                 #                          h2("Model Description"),
                 #                          plotOutput("plot4", height=200),
                 #                          includeMarkdown("SEIR.Rmd"),
                 #                          #h3("Equations"),
                 #                          br(),
                 #                          h2("Output"),
                 #                          h3("Rate parameters of dynamic model"),
                 #                          p(HTML("These parameters can be changed using the sliders in the other tabs. The values in this table represent the current values chosen via the sliders. Note that the transmission rates chosen by the sliders are always scaled by \\(N\\), so that \\(\\beta*N\\) is constant as \\(N\\) changes.")),
                 #                          tableOutput("ParameterTable"),br(),
                 #                          h3("Ratios of cases during early growth phase"),
                 #                          p(HTML("These values are calculated based on the current model parameters")),
                 #                          tableOutput("RatioTable"),br(),
                 #          ))),

                 # tabPanel("Sources",
                 #          fluidPage(
                 #            br(),
                 #            uiOutput("parameterDesc")
                 #          )),
                 # # tabPanel("Output",
                 # #          fluidPage(
                 # #            br(),
                 # #            h3("Rate parameters of dynamic model"),
                 # #            p(HTML("These parameters can be changed using the sliders in the other tabs. The values in this table represent the current values chosen via the sliders. Note that the transmission rates chosen by the sliders are always scaled by \\(N\\), so that \\(\\beta*N\\) is constant as \\(N\\) changes.")),
                 # #            tableOutput("ParameterTable"),br(),br(),
                 # #          )),
                 # tabPanel("Tutorial",
                 #          fluidPage(
                 #            br(),
                 #            uiOutput("Tutorial")
                 #            #includeMarkdown("Tutorial.Rmd")
                 #          )),
                 
                 # tabPanel("About",
                 #          fluidPage(
                 #            br(),
                 #            includeMarkdown("About.Rmd")
                 #          ))
                 
      ),
      width=7
    )
    
  )
  
)

