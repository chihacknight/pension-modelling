
# Calculate liability of existing annuitants
calculate_annuitant_liability <- function(beneficiary_forecast,ror,npers) {
  annuitants = beneficiary_forecast[[1]]
  avg_benefits_forecast = beneficiary_forecast[[2]]
  
  pv_outflows = c()
  outflows = c()
  
  outflows = annuitants * avg_benefits_forecast
  
  for (n in 1:npers) {
    pv_outflows = c(pv_outflows,outflows[,n] / (1+ror/100)^(n))
  }
  
  return(list(pv_outflows,outflows))
}