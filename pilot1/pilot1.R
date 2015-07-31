library("MTurkR")

# Authenticate
aws_credentials <- credentials(c("AKIAJTVF2RT7IDZQGOVQ", "Rroub72aeMC66dMB89Il70YWFyuVui5g+tRHLwc7"))

# Ingest
turk_data <- GetAssignments(hit="39O0SQZVJNKMHO43TZPRM5XC6YL7RY", return.all=TRUE)
qualtrics_data <- read.csv("~/Desktop/W241_Final_Pilot.csv", header=TRUE, sep=",")
qualtrics_data$surveycode = qualtrics_data$random

# Join
pilot_data_joined <- merge(turk_data, qualtrics_data, all.x = TRUE, all.y = TRUE, by=c("surveycode") ) 


# Distill/Clean

# Survey was not begun if the random string was not assigned. Exclude those records
pilot_data_joined = pilot_data_joined[!is.na(pilot_data_joined$random), ]
pilot_clean = pilot_data_joined[, c(
  "ctgroup", "gender", "age", "bachelors", "animal1", "animal2",
  "animal3", "animal4", "animal5", "animal6", "animal7", "animal8",
  "animal9", "animal10", "helpful"
)]

# Convert text responses to scores. Variants of "I don't know" are counted as 1, everything else as 0
idk <- function(text) {
  return(as.integer(text %in% c("I don't know", "I don't know.", "i don't know", "i don't know.")))
}

pilot_clean$animal1_score = idk(pilot_clean$animal1)
pilot_clean$animal2_score = idk(pilot_clean$animal2)
pilot_clean$animal3_score = idk(pilot_clean$animal3)
pilot_clean$animal4_score = idk(pilot_clean$animal4)
pilot_clean$animal5_score = idk(pilot_clean$animal5)
pilot_clean$animal6_score = idk(pilot_clean$animal6)
pilot_clean$animal7_score = idk(pilot_clean$animal7)
pilot_clean$animal8_score = idk(pilot_clean$animal8)
pilot_clean$animal9_score = idk(pilot_clean$animal9)
pilot_clean$animal10_score = idk(pilot_clean$animal10)

pilot_clean$total_score = (pilot_clean$animal1_score + pilot_clean$animal2_score + pilot_clean$animal3_score
                        + pilot_clean$animal4_score + pilot_clean$animal5_score + pilot_clean$animal6_score
                        + pilot_clean$animal7_score + pilot_clean$animal8_score + pilot_clean$animal9_score
                        + pilot_clean$animal10_score)

pilot_clean$control = as.integer(pilot_clean$ctgroup == 'control')
pilot_clean$treatment = as.integer(pilot_clean$ctgroup != 'control')
pilot_clean$moderate = as.integer(pilot_clean$ctgroup == 'moderate')
pilot_clean$strong = as.integer(pilot_clean$ctgroup == 'strong')


model = lm(total_score ~ treatment, pilot_clean)
summary(model)


  

pilot_clean$animal2   #5 antelope   XXX   => jerboa
pilot_clean$animal3   #1 bilby
pilot_clean$animal4   #3 exact + 4 close   p monkey  XXX  => wombatbat
pilot_clean$animal6   #1 axolotl
pilot_clean$animal7   #2 haggis
pilot_clean$animal9   #3 exact + 10 hyena   XXX   => weird shark
pilot_clean$animal10  #5 tapir  XXX


pilot_clean[, c("helpful", "ctgroup")]

