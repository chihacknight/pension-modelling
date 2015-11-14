# Using nominal not PV, t=1 means the payments due at the end of this year
BenefitsDue = colSums(actives_liability()[[2]]) + colSums(inactives_liability()[[2]])+
  colSums(survivor_liability()[[2]]) + colSums(annuitant_liability()[[2]])+
  colSums(new_survivor_liability()[[2]]) + colSums(actives_survivor_liability()[[2]])+
  colSums(inactives_survivor_liability()[[2]])
StatePayment = c(rep(0,input$amortdelay),rep(levelPayment(),input$amort),rep(0,60-input$amort-input$amortdelay))
FundingRatio = c()
rate = input$disc/100

initial_wealth = starting_wealth[1]

if (input$amort==0) {
  initial_wealth = starting_wealth[1] + requiredContributions()
}

# For purposes of asset forecast, starting wealth won't be plotted
for (i in 1:60) {
  benefits_paid = BenefitsDue[i]
  
  if (i==1) {
    investment_income = initial_wealth*rate
    asset_balance = initial_wealth + investment_income - benefits_paid + StatePayment[i]
    
    # Vectors for plotting
    AssetIncome = c(investment_income)
    AssetForecast = c(asset_balance)
  }
  else {
    investment_income = AssetForecast[i-1]*rate
    asset_balance = AssetForecast[i-1] + investment_income - benefits_paid + StatePayment[i]
    
    # Vectors for plotting
    AssetIncome = c(AssetIncome,investment_income)
    AssetForecast = c(AssetForecast,asset_balance)
  }
  
  # This would need to be based on PV of future cash flows starting at i
  FundingRatio = c(FundingRatio,asset_balance / sum(BenefitsDue[(i+1):60]))
}

# Create data frame for plotting
Year = rep(seq(2015,2074),4)
Type = c(rep("Asset Income",60),rep("State Payment",60),rep("Benefits Paid",60),rep("Fund Assets",60))
Flows = c(AssetIncome,StatePayment,BenefitsDue,AssetForecast)
df = data.frame(Flows,Year,Type)

df
