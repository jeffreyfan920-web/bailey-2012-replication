# Replication: Bailey (2012) Table 3 (Columns 1 & 2)

Replication of Table 3, Columns (1) and (2) from **Bailey (2012)**, *"Reexamining the Impact of Family Planning Programs on US Fertility: Evidence from the War on Poverty and the Early Years of Title X"*, *American Economic Journal: Applied Economics*.

## Model Specifications
- **Column (1)**: TWFE DiD with County FE and Year FE (`| fips + year`).
- **Column (2)**: High-dimensional TWFE DiD with County FE and State-by-Year FE (`| fips + st^year`).
- **Weights**: County female population aged 15–44 in 1970 (`pop1544_70`).
- **Inference**: Clustered standard errors at the county level (`fips`).

## Note on Singletons
Following Correia (2015), `fixest::feols` drops 30 singleton observations under `state^year` fixed effects to prevent degrees-of-freedom inflation. The estimated coefficients are numerically identical to the published paper.
