diabetesRisk <- function(sex, age, bmi, waist, bpm, hbg, pa, vfb) {
    # Coefficients
    beta <- c(0.650, 0.940, 0.015, 0.938, 1.021, 1.424, 0.714, 2.263, 0.268, 0.165)
    # Scores
    s <- c(2, 3, 1, 3, 3, 4, 2, 5, 2, 1)
    # Initialize all variables to zero
    x <- numeric(10)
    # Age (years)
    if (age >= 45 & age < 55) x[1] <- 1
    if (age >= 55) x[2] <- 1
    # BMI (kg/m^2)
    if (bmi > 25 & bmi <= 30) x[3] <- 1
    if (bmi > 30) x[4] <- 1
    # Waist circumference (cm)
    if (sex == "M" & waist >= 94 & waist < 102) x[5] <- 1
    if (sex == "M" & waist >= 102) x[6] <- 1
    if (sex == "F" & waist >= 80 & waist < 88) x[5] <- 1
    if (sex == "F" & waist >= 88) x[6] <- 1
    # Use of blood pressure medication
    if (bpm) x[7] <- 1
    # History of high blood glucose
    if (hbg) x[8] <- 1
    # Physical activity (at least 4 hours/week)
    if (pa == FALSE) x[9] <- 1
    # Daily consumption of vegetables, fruits, or berries
    if (vfb == FALSE) x[10] <- 1
    score <- drop(x %*% s)
    t <- -5.658 + drop(x %*% beta)
    sigma <- 1/(1 + exp(-t))
    c(as.integer(score), sigma)
}

bmiCalc <- function(height, weight) {
    weight/height^2
}

shinyServer(
    function(input, output) {
        bmi <- reactive({bmiCalc(input$height/100, input$weight)})
        drs <- reactive({diabetesRisk(input$sex, input$age, bmi(), input$waist,
                                      input$bpm, input$hbg, input$pa, input$vfb)})
        output$bmi <- renderPrint({bmi()})
        output$score <- renderPrint({drs()[1]})
        output$probability <- renderPrint({drs()[2]})
    }
)