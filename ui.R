## ui.R ##
library(shinydashboard)
library(leaflet)

ui <- dashboardPage(
        dashboardHeader(title = "Lightning network" ),
        
        ## Sidebar content
        dashboardSidebar(
                sidebarMenu(
                        menuItem("Dashboard", tabName = "ln_dashboard", icon = icon("dashboard")),
                        menuItem("Credits", tabName = "credits", icon = icon("th"))
                )
        ),
        dashboardBody(
                tabItems(
                        # dashboard content
                        tabItem(tabName = "ln_dashboard",
                                fluidRow(
                                        infoBoxOutput("dateBox"),
                                        infoBoxOutput("speedBox"),
                                        infoBoxOutput("pulseBox")
                                ),
                                fluidRow(
                                        box(title = "Sender: channels number per node", status = "primary", solidHeader = TRUE,
                                            plotOutput("sn", height = 300) ),
                                        box(title = "Sender: cumulated value per node", status = "primary", solidHeader = TRUE,
                                            plotOutput("sv", height = 300) ) 
                                ),
                                fluidRow(
                                   box(title = "Destination: channels number per node", status = "primary", solidHeader = TRUE,
                                       plotOutput("dn", height = 300) ),
                                   box(title = "Destination: cumulated value per node", status = "primary", solidHeader = TRUE,
                                       plotOutput("dv", height = 300) )
                                )
                                
                        ),
                       
                        # credits content
                        tabItem(tabName = "credits",
                                tags$a(
                                   href="https://github.com/valerio-vaccaro/Lightning-dashboard/",
                                   tags$img(
                                      style="position: absolute; top: 10; right: 0; border: 0;",
                                      src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png",
                                      alt="Fork me on GitHub"
                                   )
                                ),
                                h2("Lightning activity"),
                                "Lightning activity is a dashboard developed in R and shiny and able to show some summaries on LN.", br(),
                                br(),"All the code is available at", a("https://github.com/valerio-vaccaro/Lightning-dashboard"), br(),
                                br(),"Copyright (c) 2017-2018 Valerio Vaccaro", a("http://www.valeriovaccaro.it"), br(),
                                br(),"Permission is hereby granted, free of charge, to any person obtaining a copy", br(),
                                "of this software and associated documentation files (the \"Software\"), to deal", br(),
                                "in the Software without restriction, including without limitation the rights", br(),
                                "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell", br(),
                                "copies of the Software, and to permit persons to whom the Software is", br(),
                                "furnished to do so, subject to the following conditions:", br(),
                                br(),"The above copyright notice and this permission notice shall be included in all", br(),
                                "copies or substantial portions of the Software.", br(),
                                br(),"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR", br(),
                                "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,", br(),
                                "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE", br(),
                                "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER", br(),
                                "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,", br(),
                                "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE", br(),
                                "SOFTWARE."
                        )
                )
        )
)

