# Fit PCA on the seven electrical measurements.
# Scaling puts measurements with different units on a comparable scale.
pca <- prcomp(electricity_clean[3:9], center = TRUE, scale. = TRUE)

# Show how much variation each component explains.
variance_pct <- 100 * pca$sdev^2 / sum(pca$sdev^2)

print(round(rbind(
  Explained = variance_pct,
  Cumulative = cumsum(variance_pct)
), 2))

# Show which measurements contribute most to the first two components.
print(round(pca$rotation[, 1:2], 2))

# Calculate average PC1 and PC2 scores for each encoded time period.
period_scores <- sweep(
  crossprod(time_encoded, pca$x[, 1:2]),
  1, colSums(time_encoded), "/"
)
print(round(period_scores, 2))

# Plot the percentage of variation explained by each component.
plot(
  seq_along(variance_pct), variance_pct,
  type = "b", pch = 19, col = "steelblue", xaxt = "n",
  xlab = "Principal component",
  ylab = "Variation explained (%)",
  main = "PCA scree plot"
)
axis(1, at = seq_along(variance_pct))

# Keep the first five components. They explain about 97% of the variation.
pca_reduced <- pca$x[, 1:5]

print(dim(pca_reduced)) 