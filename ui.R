# http://www.ncbi.nlm.nih.gov/pubmed/12610029
# http://shiny.rstudio.com/

# shinyUI(fluidPage(
#     titlePanel("My Shiny App"),
#     sidebarLayout(
#         sidebarPanel(),
#         mainPanel()
#     )
# ))

shinyUI(fluidPage(
    titlePanel("The Diabetes Risk Score"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("sex", "Sex / Gender", c("Male" = "M", "Female" = "F")),
            numericInput("age", "Age (years)", 45, min = 18, max = 100, step = 1),
            numericInput("height", "Height (cm)", 160, min = 100, max = 250, step = 1),
            numericInput("weight", "Weight (kg)", 60, min = 30, max = 300, step = 1),
            numericInput("waist", "Waist circumference (cm)", 80, min = 50, max = 200, step = 1),
            radioButtons("bpm", "Have you ever used drugs for high blood pressure?",
                         c("No" = FALSE, "Yes" = TRUE)),
            radioButtons("hbg", "Have you ever been told by a health-care professional
                         that you have diabetes or latent diabetes?",
                         c("No" = FALSE, "Latent diabetes" = TRUE, "Diabetes" = TRUE)),
            radioButtons("pa", "Physical activity",
                         c("Less than 4 hours per week" = FALSE, "At least 4 hours per week" = TRUE)),
            radioButtons("vfb", "Do you eat vegetables, fruits, or berries
                         on a daily basis?", c("No" = FALSE, "Yes" = TRUE))
        ),
        
        mainPanel(
            h2("Welcome!"),
            hr(),
            p("This", a(href = "http://shiny.rstudio.com/", "shiny"),
              "app computes the",
              a(href = "http://www.ncbi.nlm.nih.gov/pubmed/12610029", "Diabetes Risk Score"),
              "as introduced by Jaana Lindström and Jaakko Tuomilehto."),
            p("The Diabetes Risk Score attempts to identify individuals
              at an increased risk for the disease. Its value varies from
              0 (lowest risk) to 20 (highest risk)."),
            p("The variables that define the score are age, BMI, waist
              circumference, history of antihypertensive drug treatment
              and high blood glucose, physical activity, and daily consumption
              of fruits, berries, or vegetables."),
            p("Use the input widgets on the left panel to enter your information."),
            p("Please note that weight must be given in kilograms, while
              height and waist circumference must be given in centimeters."),
            p("Your body mass index (BMI) is computed from weight and height."),
            hr(),
            h4('Body mass index (BMI)'),
            verbatimTextOutput("bmi"),
            h4('Score'),
            verbatimTextOutput("score"),
            h4("Probability of developing diabetes"),
            verbatimTextOutput("probability"),
            hr(),
            h4("Disclaimer"),
            p("Do not use for self-diagnosis. Based on ",
              a(href = "http://www.ncbi.nlm.nih.gov/pubmed/12610029", "The Diabetes Risk Score"),
               "by Jaana Lindström and Jaakko Tuomilehto."),
            hr(),
            p("This",
              a(href = "http://shiny.rstudio.com/", "shiny"),
              "app was developed by",
              a(href = "https://github.com/nemarona", "Eduardo Rodríguez"),
              "as the Course Project for the",
              a(href = "https://www.coursera.org/learn/data-products",
                "Developing Data Products"), "class at",
              a(href = "https://www.coursera.org/", "Coursera."))
        )
    )
))