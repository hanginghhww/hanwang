
#global
library(shiny)
library(shinythemes)
library(dplyr)
library(data.table)
library(plotly)
library(tidyr)
library(googleVis)
library(leaflet)
library(leaflet.extras)
library(dygraphs)
library(zoo)
library(dplyr)
library(xts)
#map
map=data.frame(fread('coinmap.csv'))
map$Created.On=substring(map$'Created.On',1,10)
map$Created.On=as.Date(map$'Created.On')  
map1=separate(map,Location,into=c('longitude','latitude'),sep=',')
map1$longitude=as.numeric(map1$longitude)
map1$latitude=as.numeric(map1$latitude)

#price line

bitcoin2 = data.frame(fread('bitcoin.csv'))
bch2=data.frame(fread('bch.csv',fill = TRUE))
btg2=data.frame(fread('btg.csv',fill = TRUE))
dash2=data.frame(fread('dash.csv',fill = TRUE))
dcr2=data.frame(fread('dcr.csv',fill = TRUE))
dgb2=data.frame(fread('dgb.csv',fill = TRUE))
doge2=data.frame(fread('doge.csv',fill = TRUE))
etc2=data.frame(fread('etc.csv',fill = TRUE))
eth2=data.frame(fread('eth.csv',fill = TRUE))
pivx2=data.frame(fread('pivx.csv',fill = TRUE))
vertcoin2=data.frame(fread('vertcoin.csv',fill = TRUE))
vtc2=data.frame(fread('vtc.csv',fill = TRUE))
xem2=data.frame(fread('xem.csv',fill = TRUE))
xmr2=data.frame(fread('xmr.csv',fill = TRUE))
xvg2=data.frame(fread('xvg.csv',fill = TRUE))
zec2=data.frame(fread('zec.csv',fill = TRUE))

bitcoin2$date=as.Date(bitcoin2$date)
bch2$date=as.Date(bch2$date)
btg2$date=as.Date(btg2$date)
dash2$date=as.Date(dash2$date)
dcr2$date=as.Date(dcr2$date)
dgb2$date=as.Date(dgb2$date)
doge2$date=as.Date(doge2$date)
etc2$date=as.Date(etc2$date)
eth2$date=as.Date(eth2$date)
pivx2$date=as.Date(pivx2$date)
vertcoin2$date=as.Date(vertcoin2$date)
vtc2$date=as.Date(vtc2$date)
xem2$date=as.Date(xem2$date)
xmr2$date=as.Date(xmr2$date)
xvg2$date=as.Date(xvg2$date)
zec2$date=as.Date(zec2$date)
names(bitcoin2)[names(bitcoin2) == 'Date'] <- 'date'


 bch1= data.frame(date=bch2$date,price=bch2$price.USD.)
 bitcoin1=data.frame(date=bitcoin2$date,price=bitcoin2$Price)
 btg1= data.frame(date=btg2$date,price=btg2$price.USD.)
 dash1=data.frame(date=dash2$date,price=dash2$price.USD.)
 dcr1=data.frame(date=dcr2$date,price=dcr2$price.USD.)
 dgb1=data.frame(date=dgb2$date,price=dgb2$price.USD.)
 doge1=data.frame(date=doge2$date,price=doge2$price.USD.)
 etc1=data.frame(date=etc2$date,price=etc2$price.USD.)
 eth1=data.frame(date=eth2$date,price=eth2$price.USD.)
 pivx1 =data.frame(date=pivx2$date,price=pivx2$price.USD.)
 vertcoin1=data.frame(date=vertcoin2$date,price=vertcoin2$price.USD.)
 vtc1=data.frame(date=vtc2$date,price=vtc2$price.USD.)
 xem1=data.frame(date=xem2$date,price=xem2$price.USD.)
 xmr1=data.frame(date=xmr2$date,price=xmr2$price.USD.)
 xvg1=data.frame(date=xvg2$date,price=xvg2$price.USD.)
 zec1=data.frame(date=zec2$date,price=zec2$price.USD.)


pricelines= full_join(bch1,bitcoin1,by='date')%>%
  full_join(.,btg1,by='date') %>%
  full_join(.,dash1,by='date') %>%
  full_join(.,dcr1,by='date') %>%
  full_join(.,dgb1,by='date') %>%
  full_join(.,doge1,by='date') %>%
  full_join(.,etc1,by='date') %>%
  full_join(.,eth1,by='date') %>%
  full_join(.,pivx1,by='date') %>%
  full_join(.,vertcoin1,by='date') %>%
  full_join(.,vtc1,by='date') %>%
  full_join(.,xem1,by='date') %>%
  full_join(.,xmr1,by='date') %>%
  full_join(.,xvg1,by='date') %>%
  full_join(.,zec1,by='date')
names(pricelines)[names(pricelines) == 'price.x'] <- 'bch'
names(pricelines)[names(pricelines) == 'price.y'] <- 'bitcoin'
names(pricelines)[names(pricelines) == 'price.x.x'] <- 'btg' 
names(pricelines)[names(pricelines) == 'price.y.y'] <- 'dash' 
names(pricelines)[names(pricelines) == 'price.x.x.x'] <-  'dcr' 
names(pricelines)[names(pricelines) == 'price.y.y.y'] <- 'dgb' 
names(pricelines)[names(pricelines) == 'price.x.x.x.x'] <- 'doge'
names(pricelines)[names(pricelines) == 'price.y.y.y.y'] <- 'etc'
names(pricelines)[names(pricelines) == 'price.x.x.x.x.x'] <- 'eth'
names(pricelines)[names(pricelines) == 'price.y.y.y.y.y'] <- 'pivx'
names(pricelines)[names(pricelines) == 'price.x.x.x.x.x.x'] <- 'vertcoin'
names(pricelines)[names(pricelines) == 'price.y.y.y.y.y.y'] <- 'vtc'
names(pricelines)[names(pricelines) == 'price.x.x.x.x.x.x.x'] <- 'xem'
names(pricelines)[names(pricelines) == 'price.y.y.y.y.y.y.y'] <- 'xmr'
names(pricelines)[names(pricelines) == 'price.x.x.x.x.x.x.x.x'] <- 'xvg'
names(pricelines)[names(pricelines) == 'price.y.y.y.y.y.y.y.y'] <- 'zec'

bch=pricelines$bch
bitcoin=pricelines$bitcoin
btg=pricelines$btg
dash=pricelines$dash
dcr=pricelines$dcr
dgb=pricelines$dgb
doge=pricelines$doge
ect=pricelines$etc
eth=pricelines$eth
pivx=pricelines$pivx
vertcoin=pricelines$vertcoin
vtc=pricelines$vtc
xem=pricelines$xem
xmr=pricelines$xmr
xvg=pricelines$xvg
zec=pricelines$zec

z=cbind(bch,bitcoin,btg,dash,dcr,dgb,doge,ect,eth,pivx,vertcoin,vtc,xem,xmr,xvg,zec)
newdata=xts(z,pricelines$date)



#variables
mapcat=c("Atm","Attraction","Cafe","Default","Drug Store","Educational Business","Food","Grocery", "Lodging",
         "Nightlife","Shopping","Sports","Transport","Travel Agency","Trezor Retailer" )
groupColors = colorFactor(c("#E03A3C", "#009DDC","#62BB47",'#a50026','#d73027','#f46d43','#fdae61','#fee090','#ffffbf','#e0f3f8','#abd9e9','#74add1','#4575b4','#313695','#bf812d'),
                           domain =c("Atm","Attraction","Cafe","Default","Drug Store","Educational Business","Food","Grocery", "Lodging",
                                     "Nightlife","Shopping","Sports","Transport","Travel Agency","Trezor Retailer" )) 
lines=c('bitcoin','bch','btg','dash','dcr','dgb','doge','etc','eth','pivx','vertcoin','vtc','xem','xmr','xvg','zec')