# Load data files downloaded from Qualtrics and Amazon
setwd("~/Documents/Berkeley/W241 - Field Experiments/Final Project/final")
turk_data <- read.csv("final_survey_results_mturk.csv", header=TRUE, sep=",")
qualtrics_data <- read.csv("final_survey_data_qualtrics.csv", header=TRUE, sep=",")

# Make sure we have a like-named column for joining the two data sets together
qualtrics_data$surveycode = qualtrics_data$random
turk_data$surveycode = turk_data$Answer.surveycode

# Join (note: respondents recruited outside of Turk won't have data in the Amazon file)
pilot_data_joined <- merge(turk_data, qualtrics_data, all.y = TRUE, by=c("surveycode") ) 


# Distill/Clean


# Limit to the subset of data necessary for the analysis
pilot_clean = pilot_data_joined[, c(
  "group",
  "What.is.your.gender.",
  "What.is.your.age.",
  "Do.you.hold.a.Bachelors.or.higher.college.degree.",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know..",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...1",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...2",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...3",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...4",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...5",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...6",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...7",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...8",
  "What.is.the.name.of.this.animal..If.you.don.t.know.the.animal.s.name..just.type..I.don.t.know...9",
  "Were.the.statistics.that.you.were.shown.during.this.study.helpful.in.identifying.the.various.anim..."
)]


# Simplify the column names
colnames(pilot_clean) = c(
  "group", "gender", "age", "bachelors", "animal1", "animal2", "animal3", "animal4", "animal5",
  "animal6", "animal7", "animal8", "animal9", "animal10", "helpful"
)


# Inspect the IDK values so we can catch and score them properly
idk_responses = c(as.character(pilot_clean$animal1), as.character(pilot_clean$animal2),
                  as.character(pilot_clean$animal3), as.character(pilot_clean$animal4),
                  as.character(pilot_clean$animal5), as.character(pilot_clean$animal6),
                  as.character(pilot_clean$animal7), as.character(pilot_clean$animal8),
                  as.character(pilot_clean$animal9))

# View responses
sort(unique(idk_responses))


# Convert text responses to scores. All variants of "I don't know" are counted as 1, everything else as 0
idk <- function(text) {
  return(as.integer(text %in% c(
    " \"I don't know.\"", " I DON'T KNOW", "\"I don't know\"", "80's hair metal Andre Braugher (I don't know)",
    "I  don't know", "I do not know", "I don;t know", "I don;t know.", "I don't k ow", "I don't kmow",
    "I don't knkw", "I don't knoe", "i don't know", "I don't know", "I don't Know", "I don't KNOW",
    "I Don't know", "I DON'T KNOW", "i don't know ", "I don't know ", "I don't Know ", "I don't know - looks like 'nessie' / cgi",
    "i don't know :(", "I don't know :(", "I don't know, but it's cute", "I don't know!", "I don't know.",
    "I don't know. ", "I don't know. Looks like a wingless bat!", "I don't know. None of there are real. ",
    "i don't know...oh come on!", "i don't know...this shit is hard", "I don't konw", "I don't kow",
    "I don't ky", "I don't lnow", "I don't[ know", "i don'tknow", "I don'tknow", "I don'tknow.",
    "i dont know", "I dont know", "I dont Know", "i dont know ", "I dont know ", "i dont' know",
    "I dont' know.", "I dont't know", "I dontknow", "I odn't know", "I really don't know ", "I. Don't know ",
    "i.dont know", "I've seen this one before... but don't know its name", "albino medusa newt (I don't know)",
    "Albinodontknow", "don't know", "Don't know", "Don't know ", "dont know", "Dont know", "elephagoat (I don't know)",
    "glamour pig (I don't know)", "idk", "Idk", "IDK", "Idon't know", "kangaroo mouse? (I don't know)",
    "medusa salamander (I don't know)", "opossum with super sonic hearing (I don't know)",
    "Same as the other one I don't know ", "teddy bear with fangs (I don't know)", "What! I don't know "
  )))
}


idk_or_blank <- function(text) {
  return(as.integer(idk(text) | text == ""))
}



# Score the responses (assuming blank != idk)
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


# Score the responses (assuming blank == idk)
pilot_clean$animal1_score_idk = idk_or_blank(pilot_clean$animal1)
pilot_clean$animal2_score_idk = idk_or_blank(pilot_clean$animal2)
pilot_clean$animal3_score_idk = idk_or_blank(pilot_clean$animal3)
pilot_clean$animal4_score_idk = idk_or_blank(pilot_clean$animal4)
pilot_clean$animal5_score_idk = idk_or_blank(pilot_clean$animal5)
pilot_clean$animal6_score_idk = idk_or_blank(pilot_clean$animal6)
pilot_clean$animal7_score_idk = idk_or_blank(pilot_clean$animal7)
pilot_clean$animal8_score_idk = idk_or_blank(pilot_clean$animal8)
pilot_clean$animal9_score_idk = idk_or_blank(pilot_clean$animal9)
pilot_clean$animal10_score_idk = idk_or_blank(pilot_clean$animal10)





# Generate total scores. This is our outcome variable!
pilot_clean$total_score = (pilot_clean$animal1_score + pilot_clean$animal2_score + pilot_clean$animal3_score
                        + pilot_clean$animal4_score + pilot_clean$animal5_score + pilot_clean$animal6_score
                        + pilot_clean$animal7_score + pilot_clean$animal8_score + pilot_clean$animal9_score
                        + pilot_clean$animal10_score)

pilot_clean$total_score_idk = (pilot_clean$animal1_score_idk + pilot_clean$animal2_score_idk + pilot_clean$animal3_score_idk
                           + pilot_clean$animal4_score_idk + pilot_clean$animal5_score_idk + pilot_clean$animal6_score_idk
                           + pilot_clean$animal7_score_idk + pilot_clean$animal8_score_idk + pilot_clean$animal9_score_idk
                           + pilot_clean$animal10_score_idk)



# Helpful dummy variables for identifying the different assignments
pilot_clean$control = as.integer(pilot_clean$group == 'control')
pilot_clean$treatment = as.integer(pilot_clean$group != 'control')
pilot_clean$moderate = as.integer(pilot_clean$group == 'moderate')
pilot_clean$strong = as.integer(pilot_clean$group == 'strong')


# Convert gender to dummy variable
pilot_clean$male = as.integer(pilot_clean$gender == 'Male')

# Convert Bachelors or higher degree to a dummy variable
pilot_clean$degree = as.integer(pilot_clean$bachelors == 'Yes')

# Convert the manipulation check variable into a dummy
pilot_clean$helpful_treated = as.integer(pilot_clean$helpful != 'I did not see any statistics')

# Not sure if I should use age or adjusted age here...?
# Adjusted age produces a more intuitive intercept value, but adds the cognitive
# overhead of using 24 as the base age. Raw age looks weird because intercept
# for pilot 2 data winds up being 13, which is an impossible value all on its
# own.
pilot_clean$age_adjusted = pilot_clean$age - min(pilot_clean$age)
# pilot_clean$age_adjusted


pilot_clean$over_thirty = as.integer(pilot_clean$age > 30)
pilot_clean$over_thirty

# Data Analysis


# Simplest regression
summary(lm(total_score ~ treatment, pilot_clean))
summary(lm(total_score_idk ~ treatment, pilot_clean))


# Separate the 2 levels of treatment
summary(lm(total_score ~ moderate + strong, pilot_clean))

# Add covariates
summary(lm(total_score ~ moderate + strong + male + degree + age_adjusted, pilot_clean))

# Test interaction hypothesis of treatment + male
summary(lm(total_score ~ treatment * male, pilot_clean))

# Test interaction hypothesis of treatment + degree
summary(lm(total_score ~ treatment * degree, pilot_clean))

# Test interaction hypothesis of treatment + age over thirty
summary(lm(total_score ~ treatment * over_thirty, pilot_clean))

