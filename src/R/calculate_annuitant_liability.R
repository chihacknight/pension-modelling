
# Calculate liability of existing annuitants
calculate_annuitant_liability <- function(beneficiary_forecast,ror,npers) {
  annuitants = beneficiary_forecast[[1]]
  avg_benefits_forecast = beneficiary_forecast[[2]]
  
  pv_outflows = c()
  outflows = c()
  
  outflows = annuitants * avg_benefits_forecast
  
  # Forecasting files assume n==1 means the starting position, however I'm still discounting it
  # This will understate the PV since cash flows are actually spread out over the year
  # However the cash flows are likely overstated since I'm not accounting for intra-year mortality
  # Overall there's about a $17M difference in actuarial liability between using n and n-1 in the below calculation
  # Also using n-1/2 is a possible middle ground
  for (n in 1:npers) {
    pv_outflows = c(pv_outflows,outflows[,n] / (1+ror/100)^(n))
  }
  
  return(list(pv_outflows,outflows))
}