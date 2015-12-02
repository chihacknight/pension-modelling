
dat <- data.frame(
  factor = factor(c("Assets","Liabilities","Unfunded")),
  Amount = c(starting_wealth[1], totalLiability(),totalLiability()-starting_wealth[1]))

stacked_absolute<-ggplot(data=dat, aes(x=factor, y=Amount, fill=factor)) +
  geom_bar(stat="identity")+ scale_fill_brewer(palette='Dark2') + 
  scale_y_continuous(labels=function(x) x / 1e6, name="") +
  scale_x_discrete(name="") +
  theme(panel.background = element_rect(fill = "white"), plot.background = element_rect(fill='grey97'), legend.position="none") + 
  geom_text(aes(label = prettyNum(Amount,big.mark=","), y = 25e6), size = 6) + 
  ggtitle(paste("Funded Ratio: ",round(fundingRatio(),2),"%",sep="")) + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size=24,vjust=1))

print(stacked_absolute)