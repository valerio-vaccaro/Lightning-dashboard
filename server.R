# server.R
library(ggplot2)
library(ggpmisc)
library(anytime)
library(grid)
library(stringr)
library(RJSONIO)
library(Rbitcoin)
library(plyr)
library(igraph)
library(dplyr)
library(lubridate)

# load data
load("./data/nodes.RData")
load("./data/channels.RData")

today <- as.numeric(as.POSIXct(Sys.Date()))*1000

server <- function(input, output) {
   
   sender <- channels %>% 
      group_by(source, active) %>% 
      summarise(n=n(), 
                sum = sum(satoshis),
                max = max(satoshis),
                min = min(satoshis)
      )
   
   destination <- channels %>% 
      group_by(destination, active) %>% 
      summarise(n=n(), 
                sum = sum(satoshis),
                max = max(satoshis),
                min = min(satoshis)
      )
   
   output$dateBox <- renderInfoBox({
      infoBox(
         "Nodes", 
         paste("Public: ",sum(unlist(nodes$port)!=0, na.rm = TRUE), "-", "Private: ", sum(nodes$nodeid!="")- sum(unlist(nodes$port)!=0, na.rm = TRUE)),
         icon = icon("server"),
         color = "green"
      )
   })
   
   output$speedBox <- renderInfoBox({
      infoBox(
         "Channels", 
         paste("Active: ",sum(channels$active), "-", "Non active: ",sum(!channels$active)),
         icon = icon("shopping-cart"),
         color = "yellow"
      )
   })
   
   output$pulseBox <- renderInfoBox({
      infoBox(
         "Bitcoin", 
         paste(sum(channels$satoshis)/100000000, "BTC"),
         icon = icon("bitcoin"),
         color = "red"
      )
   })

   output$sn <- renderPlot({
      ggplot(sender) +
         geom_histogram(aes(x=n, fill=active), bins = 50) +
         scale_x_log10()  +
         annotate("text", x = Inf, y = Inf, label = paste0(as.Date(anytime(today/1000)), " - valeriovaccaro.it"),
                  hjust=1.1, vjust=1.1, col="black", cex=4,
                  fontface = "bold", alpha = 0.3) +
         ggtitle("Histogram of outcoming channels") +
         labs(y="Nodes", x="Outcoming channels") +
         theme(axis.text.x = element_text(angle=45, hjust=1))
   })
   
   output$dn <- renderPlot({
      ggplot(destination) +
         geom_histogram(aes(x=n, fill=active), bins = 50) +
         scale_x_log10()  +
         annotate("text", x = Inf, y = Inf, label = paste0(as.Date(anytime(today/1000)), " - valeriovaccaro.it"),
                  hjust=1.1, vjust=1.1, col="black", cex=4,
                  fontface = "bold", alpha = 0.3) +
         ggtitle("Histogram of incoming channels") +
         labs(y="Nodes", x="Incoming channels") +
         theme(axis.text.x = element_text(angle=45, hjust=1))
   })
   
   output$sv <- renderPlot({
      ggplot(sender) +
         geom_histogram(aes(x=sum, fill=active), bins = 50) +
         scale_x_log10()  +
         geom_vline(xintercept=100000000, linetype=2, color="red") +
         annotate("text", x = Inf, y = Inf, label = paste0(as.Date(anytime(today/1000)), " - valeriovaccaro.it"),
                  hjust=1.1, vjust=1.1, col="black", cex=4,
                  fontface = "bold", alpha = 0.3) +
         ggtitle("Histogram of outcoming channels values") +
         labs(y="Nodes", x="Outcoming channels value") +
         theme(axis.text.x = element_text(angle=45, hjust=1))
   })
   
   output$dv <- renderPlot({
      ggplot(destination) +
         geom_histogram(aes(x=sum, fill=active), bins = 50) +
         scale_x_log10()  +
         geom_vline(xintercept=100000000, linetype=2, color="red") +
         annotate("text", x = Inf, y = Inf, label = paste0(as.Date(anytime(today/1000)), " - valeriovaccaro.it"),
                  hjust=1.1, vjust=1.1, col="black", cex=4,
                  fontface = "bold", alpha = 0.3) +
         ggtitle("Histogram of incoming channels values") +
         labs(y="Nodes", x="Incoming channels value") +
         theme(axis.text.x = element_text(angle=45, hjust=1))
   })
   
   
}