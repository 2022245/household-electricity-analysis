# Import the data and mark missing readings as NA.
electricity <- read.table(
  file = "~/household-electricity-analysis/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = c("?", ""),
  stringsAsFactors = FALSE
)

# Check the dataset size, column types and missing values.
print(dim(electricity))
str(electricity)
print(colSums(is.na(electricity)))



