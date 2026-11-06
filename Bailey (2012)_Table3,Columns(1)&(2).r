# ==============================================================================
# Replication: Bailey (2012) Table 3, Columns (1) & (2)
# Outcome: General Fertility Rate (GFR)
# ==============================================================================

library(haven)
library(dplyr)
library(fixest)
library(haven)


# 1. 讀取數據與整理變量
df <- read_dta("data/vs_fo_final.dta") %>% rename(gfr_non = gfr_nonint)


fp_vars <- grep("^fp_on", names(df), value = TRUE)
fp_vars    # 睇下搵到邊幾個



# 2. Model 1 (Table 3 Col 1): County FE + Year FE
f1 <- as.formula(paste("gfr_non ~", paste(fp_vars, collapse = " + "), "+ i(year) | fips"))

m1 <- feols(f1, data = df, weights = ~pop1544_70, cluster = ~fips)


# 3. Model 2 (Table 3 Col 2): County FE + State-by-Year FE
df2 <- df %>% mutate(st = floor(fips / 1000))

f2 <- as.formula(paste("gfr_non ~", paste(fp_vars, collapse = " + "), "| fips + st^year"))

m2 <- feols(f2, data = df2, weights = ~pop1544_70, cluster = ~fips)


# 4. 輸出乾淨對照表 (對齊論文格式)
etable(
  m1, m2,
  headers = c("Col (1): C + Y", "Col (2): C + S-Y"),
  order = c("fp_on_1", "fp_on1", "fp_on2", "fp_on3"),
  dict = c(
    fp_on_1 = "Years -5 to -1",
    fp_on1  = "Years 1 to 5",
    fp_on2  = "Years 6 to 10",
    fp_on3  = "Years 11 to 15"
  ),
  digits = 3,
  fitstat = c("n", "r2")
)
