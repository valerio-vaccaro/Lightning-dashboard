library(ggplot2)
library(jsonlite)
library(dplyr)

setwd("~/r-studio-workspace/lightning")

res <- fromJSON("http://bitcoin.vaccaro.tech/listnodes.json")
nodes <- bind_rows(res$nodes)
nodes$type <- sapply( nodes$addresses, function(m) m[["type"]] ) 
nodes$address <- sapply( nodes$addresses, function(m) m[["address"]] )
nodes$port <- sapply( nodes$addresses, function(m) m[["port"]] )
save(nodes, file="data/nodes.RData")

res <- fromJSON("http://bitcoin.vaccaro.tech/listchannels.json")
channels <- bind_rows(res$channels)
save(channels, file="data/channels.RData")

