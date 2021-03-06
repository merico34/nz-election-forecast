library(shiny)
library(shinyjs)
library(ggvis)

load("parties.rda")

minsl <- 0.05
maxsl <- 0.95

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  useShinyjs(),
  tags$style(HTML("
@import url('https://fonts.googleapis.com/css?family=Lato');
                      
body {font-family: 'Lato', 'Lucida Grande', Verdana, Lucida, Helvetica, Arial, Calibri, sans-serif;}
")),
  
  
  # Application title
  titlePanel("Forecasts for New Zealand General Election 2017"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    id = "parameters",
    column(3,
       checkboxGroupInput("coal_members",
                   "Select coalition members",
                   choices = parties,
                   selected = c("ACT", "National", "United Future", "Māori")
         
       ),
       #hr(),
       actionButton("reset_input", "Reset all assumptions"),
       hr(),
       
HTML("<p>The choices of parties for a coalition lead to predictions of the number of 
seats in Parliament.   Party vote is simulated based on the model described at 
<a href='http://ellisp.github.io/elections/elections.html'>Peter's Stats Stuff</a>.
Conversion of party vote to number of seats requires assumptions of some key electorate outcomes.
Adjusting the sliders for the electorates below and to the right will create new simulations of
electorate seats, and hence of total seats allocated.</p>"),
       
       
       hr(),
h4("Important electorates"),
       sliderInput("epsom", "Epsom - probability of ACT win", min = minsl, max = maxsl, value = 0.8),
       sliderInput("ohariu", "Ohariu - probability of United Future win", min = minsl, max = maxsl, value = 0.6),
p("Northland electorate, while of interest, is not included here as NZ First are believed likely to reach the 
5% threshold even if they do not retain the electorate.")
       ),
    column(3, hr(),
           # see http://www.newshub.co.nz/home/politics/2017/02/what-the-mana-maori-deal-would-ve-meant-in-the-2014-election.html
           h4("Māori electorates"),
       sliderInput("m1", "Tāmaki Makaurau - probability of Labour win", min = minsl, max = maxsl, value = 0.49),
       sliderInput("m2", "Te Tai Hauāuru - probability of Labour win", min = minsl, max = maxsl, value = 0.52),
       sliderInput("m3", "Ikaroa-Rāwhiti - probability of Labour win", min = minsl, max = maxsl, value = 0.55),
       sliderInput("m4", "Te Tai Tonga - probability of Labour win", min = minsl, max = maxsl, value = 0.58),
       sliderInput("m5", "Te Tai Tokerau - probability of Labour win", min = minsl, max = maxsl, value = 0.48),
       sliderInput("m6", "Hauraki-Waikato - probability of Labour win", min = minsl, max = maxsl, value = 0.64),
       sliderInput("m7", "Wairaki - probability of Labour win", min = minsl, max = maxsl, value = 0.30),
       p("Te Tai Tokerau is assumed to go to either Mana or Labour; all other Māori electorates assumed to go to
either Māori or Labour.")
    ),
    column(6,
           h3("Probability distribution of won seats"),
           ggvisOutput("perc_plot"),
           htmlOutput("prob"),
           ggvisOutput("seats_plot"),
HTML("<p>All predictions should be taken with great caution.  Modelled party vote estimates are based 
on poll numbers from 2014 to 2017, adjusted for how well each polling firm has predicted parties' actual
vote in previous elections.  The modelled uncertainty takes into account polling sampling error, the 
challenge of forecasting in time, and randomness on election day.  
See the <a href='http://ellisp.github.io/elections/elections.html'>
full description of the method</a> or the <a href = 'https://github.com/ellisp/nz-election-forecast'>
source code</a> for more details.  <a href='http://ellisp.github.io/elections/elections.html'>
Comments are welcome.</a></p>")           
           )
    )
    
    
  )
)
