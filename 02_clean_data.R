# Count rows with at least one missing value.
incomplete_rows <- !complete.cases(electricity)
print(sum(incomplete_rows))

# Count exact duplicates and repeated date-time pairs.
print(sum(duplicated(electricity)))
print(sum(duplicated(electricity[c("Date", "Time")])))

# Check the ranges of the seven measurement columns.
print(summary(electricity[3:9]))

# Keep rows with complete readings for the analysis.
electricity_clean <- electricity[!incomplete_rows, ]

# Report how many rows were removed and the final dataset size.
cat("Incomplete rows removed:", sum(incomplete_rows), "\n")
cat("Cleaned rows:", nrow(electricity_clean), "\n")
cat("Cleaned columns:", ncol(electricity_clean), "\n")
cat("Missing values remaining:", sum(is.na(electricity_clean)), "\n")