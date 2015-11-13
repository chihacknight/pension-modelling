dat <- data.frame(
  factor = factor(c("Assets","Liabilities")),
  Amount = c(starting_wealth[1], totalLiability()))



stacked_absolute<-ggplot(data=dat, aes(x=factor, y=Amount, fill=factor)) +
  geom_bar(stat="identity")+
  scale_y_continuous(labels=function(x) x / 1e6, name="in Millions") +
  scale_x_discrete(name="") +
  theme(legend.position="none")

print(stacked_absolute)