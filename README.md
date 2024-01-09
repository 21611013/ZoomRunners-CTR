# CTR Analysis Shiny App

This repository contains the code for a Click-Through Rate (CTR) Analysis Shiny App built using R Shiny. The app allows users to upload datasets, manually input data, perform statistical analysis using a t-test, and visualize the results through tables and plots.

## Features:

- **Data Input:**
  - Upload CSV files or manually input data for analysis.
  - Reset data functionality for a fresh start.

- **Statistical Analysis:**
  - Perform t-test to compare CTR means for different ad placements.
  - Interpretation of statistical results provided in the app.

- **Visualization:**
  - Visualize average CTR through a bar plot.
  - Dynamic DataTable to explore uploaded or input data.

## Dataset:

The application uses a sample dataset with CTR data, including information on the placement of advertisements in the Left Sidebar, Center Page, and Right Sidebar.

## How to Use:

1. Clone or download this repository to your local machine.
2. Open the R Shiny Dashboard script using RStudio or another R environment.
3. Interact with the dashboard by navigating through tabs:
   - **Data Table:** Explore the uploaded or manually input data.
   - **Summary Output:** Interpret the statistical analysis results.
   - **About t-test:** Understand the t-test and its application in the context of CTR.
   - **Visualizations:** View the average CTR through a bar plot.

## Application Structure:

The dashboard consists of three main tabs:

1. **Data Table:**
   - Upload or input data.
   - Reset data functionality.
   - Dynamic DataTable to explore and visualize data.

2. **Statistical Analysis:**
   - Perform a t-test to assess the significance of CTR differences.
   - Interpretation of t-test results provided.

3. **Visualizations:**
   - Bar plot illustrating the average CTR for each ad placement.

## Credits:

This Shiny App is inspired by the need for a user-friendly tool to analyze and interpret CTR data. The structure and design of the code draw inspiration from various Shiny Dashboard templates and online resources.

Feel free to explore, modify, and use the dashboard for your purposes. If you encounter any issues or have suggestions for improvements, please let us know!
