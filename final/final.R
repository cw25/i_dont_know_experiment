# Load data files downloaded from Qualtrics and Amazon
setwd("~/Documents/Berkeley/W241 - Field Experiments/Final Project/final")
turk_data <- read.csv("final_survey_results_mturk.csv", header=TRUE, sep=",")
qualtrics_data <- read.csv("final_survey_data_qualtrics.csv", header=TRUE, sep=",")

# Make sure we have a like-named column for joining the two data sets together
qualtrics_data$surveycode = qualtrics_data$random
turk_data$surveycode = turk_data$Answer.surveycode

# Join (note: respondents recruited outside of Turk won't have data in the Amazon file)
final_data_joined <- merge(turk_data, qualtrics_data, all.y = TRUE, by=c("surveycode") ) 


# Distill/Clean


# Limit to the subset of data necessary for the analysis
final_clean = final_data_joined[, c(
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
colnames(final_clean) = c(
  "group", "gender", "age", "bachelors", "animal1", "animal2", "animal3", "animal4", "animal5",
  "animal6", "animal7", "animal8", "animal9", "animal10", "helpful"
)


# Inspect the IDK values so we can catch and score them properly
idk_responses = c(as.character(final_clean$animal1), as.character(final_clean$animal2),
                  as.character(final_clean$animal3), as.character(final_clean$animal4),
                  as.character(final_clean$animal5), as.character(final_clean$animal6),
                  as.character(final_clean$animal7), as.character(final_clean$animal8),
                  as.character(final_clean$animal9))

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


idk_including_blank <- function(text) {
  return(as.integer(idk(text) | text == ""))
}




# Score the responses (assuming blank != idk)
final_clean$animal1_score_excl = idk(final_clean$animal1)
final_clean$animal2_score_excl = idk(final_clean$animal2)
final_clean$animal3_score_excl = idk(final_clean$animal3)
final_clean$animal4_score_excl = idk(final_clean$animal4)
final_clean$animal5_score_excl = idk(final_clean$animal5)
final_clean$animal6_score_excl = idk(final_clean$animal6)
final_clean$animal7_score_excl = idk(final_clean$animal7)
final_clean$animal8_score_excl = idk(final_clean$animal8)
final_clean$animal9_score_excl = idk(final_clean$animal9)
final_clean$animal10_score_excl = idk(final_clean$animal10)


# Score the responses (assuming blank == idk)
final_clean$animal1_score_incl = idk_including_blank(final_clean$animal1)
final_clean$animal2_score_incl = idk_including_blank(final_clean$animal2)
final_clean$animal3_score_incl = idk_including_blank(final_clean$animal3)
final_clean$animal4_score_incl = idk_including_blank(final_clean$animal4)
final_clean$animal5_score_incl = idk_including_blank(final_clean$animal5)
final_clean$animal6_score_incl = idk_including_blank(final_clean$animal6)
final_clean$animal7_score_incl = idk_including_blank(final_clean$animal7)
final_clean$animal8_score_incl = idk_including_blank(final_clean$animal8)
final_clean$animal9_score_incl = idk_including_blank(final_clean$animal9)
final_clean$animal10_score_incl = idk_including_blank(final_clean$animal10)




# Generate total scores. This is our outcome variable!
final_clean$total_score_excl = (final_clean$animal1_score_excl + final_clean$animal2_score_excl + final_clean$animal3_score_excl
                        + final_clean$animal4_score_excl + final_clean$animal5_score_excl + final_clean$animal6_score_excl
                        + final_clean$animal7_score_excl + final_clean$animal8_score_excl + final_clean$animal9_score_excl
                        + final_clean$animal10_score_excl)

final_clean$total_score_incl = (final_clean$animal1_score_incl + final_clean$animal2_score_incl + final_clean$animal3_score_incl
                           + final_clean$animal4_score_incl + final_clean$animal5_score_incl + final_clean$animal6_score_incl
                           + final_clean$animal7_score_incl + final_clean$animal8_score_incl + final_clean$animal9_score_incl
                           + final_clean$animal10_score_incl)

# Look at the data to get a sense of how scores differ
final_clean[final_clean$total_score_incl != final_clean$total_score_excl, c("total_score_incl", "total_score_excl")]


# Helpful dummy variables for identifying the different assignments
final_clean$control = as.integer(final_clean$group == 'control')
final_clean$treatment = as.integer(final_clean$group != 'control')

final_clean$moderate = as.integer(final_clean$group == 'moderate')
final_clean$strong = as.integer(final_clean$group == 'strong')


# Define never-takers as those who did not answer any animal questions
# Those answering up to 9 of the questions will be handled as though
# they were treatedx
final_clean$complied = as.integer(final_clean$treatment & 
                        (final_clean$animal1 != '' | final_clean$animal2 != '' 
                        | final_clean$animal3 != '' | final_clean$animal4 != ''
                        | final_clean$animal5 != '' | final_clean$animal6 != ''
                        | final_clean$animal7 != '' | final_clean$animal8 != ''
                        | final_clean$animal9 != '' | final_clean$animal10 != ''))


final_clean$moderate_complied = as.integer(final_clean$moderate & final_clean$complied)
final_clean$strong_complied = as.integer(final_clean$strong & final_clean$complied)


# Convert gender to dummy variable
final_clean$male = as.integer(final_clean$gender == 'Male')

# Convert Bachelors or higher degree to a dummy variable
final_clean$degree = as.integer(final_clean$bachelors == 'Yes')

# Convert the manipulation check variable into a dummy
final_clean$stats_helpful = as.integer(final_clean$helpful != 'I did not see any statistics')

# Using age over 24 (the lowest age observed in the study). Without the adjustment,
# when the age is included in regressions, the intercept comes out around 13,
# which seems like an impossible value and can be a bit confusing.
final_clean$age_over_24 = final_clean$age - min(final_clean$age)

# Convert age over 30 into a dummy variable
final_clean$over_thirty = as.integer(final_clean$age > 30)




# Data Analysis


# Include libraries for IV regression and robust standard errors
library(AER)
library(sandwich)

# Use IV/2-stage regression to derive the estimated CACE, including our covariates
# of interest. We start with the model that excludes blank responses from being
# counted as IDKs. Having fewer IDKs in treatment will cause the CACE to be
# overestimated, so we refer to it as the "upper" model since it will become the
# upper bound in our extreme value bounds.
model_excl = ivreg(total_score_excl ~ complied + male + degree + over_thirty, 
                                    ~ treatment + male + degree + over_thirty,
                                    data=final_clean)
upper_model = summary(model_excl)
upper_model
upper_bound_cace = upper_model$coefficients[2,1]
upper_rse = coeftest(model_excl, vcovHC(model_excl))
upper_rse
upper_robust_se = upper_rse[[7]]

# Check the outputs for the CACE and robust SE
upper_bound_cace
upper_robust_se

# Compute the 97.5% quantile for the more extreme effect
# Signs look a little funny because the effect we are measuring
# is negative. A greater effect means fewer IDK responses.
ci_upper = upper_bound_cace - (1.96 * upper_robust_se)
ci_upper


# Now run the same model for the "lower" estimate
model_incl = ivreg(total_score_incl ~ complied + male + degree + over_thirty,
                                    ~ treatment + male + degree + over_thirty,
                                    data=final_clean)
lower_model = summary(model_incl)
lower_model
lower_bound_cace = lower_model$coefficients[2,1]
lower_rse = coeftest(model_incl, vcovHC(model_incl))
lower_rse
lower_robust_se = lower_rse[[7]]

# Check outputs
lower_bound_cace
lower_robust_se

# Compute the 2.5% quantile for the less extreme effect
ci_lower = lower_bound_cace + (1.96 * lower_robust_se)
ci_lower




# Use the inclusive model since it represents the lesser effect (stay conservative)
# and investigate the additional hypotheses


# Hypothesis 2: Seeing highly confident summary statistics will lead to a greater reduction in IDK
# responses than seeing moderately confident summary statistics
model_h2 = ivreg(total_score_incl ~ strong_complied + moderate_complied + male + degree + over_thirty,
                                    ~ strong + moderate + male + degree + over_thirty,
                                    data=final_clean)
summary(model_h2)


# Hypothesis 3: Males under treatment will be even less likely than females to answer IDK
model_h3 = ivreg(total_score_incl ~ complied * male + degree + over_thirty,
                 ~ treatment * male + degree + over_thirty,
                 data=final_clean)
summary(model_h3)


# Hypothesis 4: Holders of 4-year college degrees will be even more likely to answer IDK
model_h4 = ivreg(total_score_incl ~ complied * degree + male + over_thirty,
                 ~ treatment * degree + male + over_thirty,
                 data=final_clean)
summary(model_h4)


# Hypothesis 5: Participants over the age of 30 receiving the treatment are more likely to answer IDK
model_h5 = ivreg(total_score_incl ~ complied * over_thirty + male + degree,
                 ~ treatment * over_thirty + male + degree,
                 data=final_clean)
summary(model_h5)


# Manipulation check
t.test(
  final_clean$stats_helpful[final_clean$control == 1 & !is.na(final_clean$stats_helpful)],
  final_clean$stats_helpful[final_clean$control == 0 & !is.na(final_clean$stats_helpful)]
)
 



