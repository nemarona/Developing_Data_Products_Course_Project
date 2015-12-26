---
title       : The Diabetes Risk Score
subtitle    : A shiny app that computes your risk of developing diabetes
author      : by Eduardo Rodríguez
job         : Course Project for the Developing Data Products class at Coursera
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : standalone    # {standalone, draft}
knit        : slidify::knit2slides
---

## The Diabetes Risk Score

- Introduced by Jaana Lindström and Jaakko Tuomilehto
  (paper available [here](http://www.ncbi.nlm.nih.gov/pubmed/12610029)).
- Attempts to identify individuals at a high risk of developing the disease
  without laboratory tests.
- Based on age, body mass index, waist circumference, history of
  antihypertensive drug treatment and high blood glucose, physical activity,
  and daily consumption of fruits, berries, or vegetables.
- Score goes from 0 (lowest risk) to 20 (highest risk).
- It also computes an associated probability of developing diabetes within ten years.
- There are some caveats; e.g., family history of diabetes is not taken
  into account (see paper!).

---

## The Shiny App

Shiny app hosted on the Shiny Apps server 
([click here](https://nemarona.shinyapps.io/Developing_Data_Products_Course_Project)).

<img class="center" src="shinyapp-screenshot.png" height=500>

---

## Usage



Users supply their data via the input widgets on the left panel.
Height and weight are used to compute the body mass index (BMI).
Here's an example calculation:

```r
sex <- "M"
age <- 38
height <- 172   # in centimeters
weight <- 78    # in kilograms
bmi <- bmiCalc(height, weight)
waist <- 90     # in centimeters
bpm <- FALSE    # Blood pressure medication?
hbg <- FALSE    # High blood glucose?
pa <- FALSE     # Physical activity at least 4 hours per week?
vfb <- TRUE     # Daily consumption of vegetables, fruits, or berries?
diabetesRisk(sex, age, bmi, waist, bpm, hbg, pa, vfb)
```

```
## [1] 2.000000000 0.004541256
```

---

## Inner workings

- Each variable contributes to the score according to the specifications
  given by Lindström and Tuomilehto in their paper.
- The `diabetesRisk()` function returns the score and an associated probability,
  computed with the formula
  $$p = \frac{1}{1 + e^{-t}},$$
  where $t = \beta_{0} + \beta_{1} x_{1} + \beta_{2} x_{2} + \cdots$.
- The $\beta$-coefficients come from a logistic regression model.

