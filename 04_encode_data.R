# Extract the hour and group readings into four six-hour periods.
reading_hour <- as.integer(substr(electricity_clean$Time, 1, 2))

time_period <- cut(
  reading_hour,
  breaks = c(0, 6, 12, 18, 24),
  labels = c("Night", "Morning", "Afternoon", "Evening"),
  right = FALSE
)

# Create one binary column per period.
time_encoded <- model.matrix(~ time_period - 1)
colnames(time_encoded) <- levels(time_period)

# Check that every reading belongs to exactly one period.
stopifnot(nrow(time_encoded) == nrow(electricity_clean))
stopifnot(all(rowSums(time_encoded) == 1))

# Show how many readings are in each period.
print(colSums(time_encoded)) 