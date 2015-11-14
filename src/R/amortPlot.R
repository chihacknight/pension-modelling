df = amortUAAL()$value
df[df$Type=="Benefits Paid",]$Flows = -df[df$Type=="Benefits Paid",]$Flows

p <- ggplot(df,aes(x=Year)) + geom_bar(data=subset(df,Type=="State Payment"), aes(y=Flows/1000000,fill=Type), position="stack",stat="identity",width=0.8) +
      geom_bar(data=subset(df,Type=="Benefits Paid"),aes(y=Flows/1000000,fill=Type), position="stack",stat="identity",width=0.8) +
      geom_bar(data=subset(df,Type=="Asset Income"),aes(y=Flows/1000000,fill=Type), position="stack",stat="identity",width=0.8) +
      geom_line(data=subset(df,Type=="Fund Assets"),aes(y=Flows/1000000,Fill=Type),size=1) +
      scale_fill_manual(values=c("State Payment"="chartreuse4","Benefits Paid"="firebrick2","Asset Income"="blue")) + ylab("Flows ($mm)") + 
      theme(panel.background = element_rect(fill = "white"), plot.background = element_rect(fill='grey97'))
#p <- p + geom_point(data=subset(df,Type=="Fund Assets"),aes(x=Year,y=Flows/1000000,Fill=Type),size=4,shape=10)
print(p)

