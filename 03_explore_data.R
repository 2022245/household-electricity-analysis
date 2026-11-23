# Extract the hour (0 to 23) from each reading's time.
hour <- as.integer(substr(electricity_clean$Time, 1, 2))

# Average the available minute-by-minute power readings for each hour.
hourly_power <- tapply(electricity_clean$Global_active_power, hour, mean)
hours <- as.integer(names(hourly_power))

# Plot the average active power across the day.
plot(
  hours, hourly_power,
  type = "o", pch = 19, col = "steelblue", lwd = 2,
  xaxt = "n",
  xlab = "Hour of day",
  ylab = "Average active power (kW)",
  main = "Average household power by hour"
)
axis(1, at = seq(0, 23, by = 2))

# Print the hour with the highest average and its value.
peak <- which.max(hourly_power)
cat(sprintf("Peak hour: %02d:00 (%.2f kW)\n", hours[peak], hourly_power[peak]))

# Calculate Pearson correlations between the seven measurement columns.
measurements <- electricity_clean[3:9]
correlations <- cor(measurements)
print(round(correlations, 2))

# Shorten the labels so they fit on the chart.
labels <- c("Active power", "Reactive power", "Voltage", "Current",
            "Sub-meter 1", "Sub-meter 2", "Sub-meter 3")
dimnames(correlations) <- list(labels, labels)

# Keep the original variable order and use a fixed scale from -1 to +1.
heatmap(
  correlations,
  Rowv = NA, Colv = NA, scale = "none", symm = TRUE,
  col = hcl.colors(21, "Blue-Red 3"),
  breaks = seq(-1, 1, length.out = 22),
  margins = c(9, 9),
  main = "Correlations between electrical measurements"
)  
# Find the highest power reading and show when it happened.
power <- electricity_clean$Global_active_power
peak_row <- which.max(power)

print(electricity_clean[
  peak_row, c("Date", "Time", "Global_active_power")
])

# Flag high readings using the spread of the middle half of the data.
upper_limit <- quantile(power, 0.75) + 1.5 * IQR(power)
high_count <- sum(power > upper_limit)

cat(sprintf("High-reading cutoff: %.3f kW\n", upper_limit))
cat(sprintf("Readings above the cutoff: %d (%.2f%%)\n",
            high_count, 100 * high_count / length(power)))   