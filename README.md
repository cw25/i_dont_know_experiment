#I Don't Know#

Are people less likely to admit they don’t know the answer to a questions when they can see other people’s previous responses?

I conducted this field experiment to answer that question as part of my coursework for my Masters program at UC Berkeley. Data were collected through Qualtrics surveys and participants were recruited through personal appeals and Amazon Mechanical Turk.

I've tried to capture all materials used in the experiment here. Analysis code is written in R, captured in an RMarkdown document for use with RStudio, and used to produce the final PDF write-up document using RStudio's knitr integration.

If you have questions about the experiment, results, or anything else, I'm happy to answer questions at: chris.walker@ischool.berkeley.edu

***

#Frequently Asked Questions#


**Q:** _(This was the most common question...)_ Were the animals real?

**A:** 8 out of 10 were real. The original plan was to have 10 fake animals, but believable fake animal images are really hard to find! In the end, I had to settle for using pictures of very obscure animals instead.

-


**Q:** When I took the survey, I saw people's previous responses. Didn't that affect people's answers?

**A:** Yes, exactly! The true purpose of the study was to find out whether the presence of statistics changed how frequently people would admit that they didn't know the answer. My hypothesis was that people would answer IDK less frequently if they could see previous responses.

-


**Q:** Wait, back to the animals... Why did it matter if they were real or fake?

**A:** I wanted to measure how frequently people admitted that they didn't know the answer. The best way to do that is to present people with a question where it is guaranteed that they don't know the answer. If they know the real identity of the animal, they wouldn't face the choice that I was interested in studying. That's why I tried to use highly obscure animals when I couldn't find good fake ones.

-


**Q:** So, were the previous response statistics real?

**A:** Nope. Totally fake!

-


**Q:** Hang on, I didn't see statistics! What the heck?

**A:** That means you were part of the experiment's control group. I measured the frequency of IDK responses both with stats (treatment) and without stats (control), then compared the results to measure the effect that the stats had.

-


**Q:** I knew some of the animals. What does that mean?

**A:** The fact that some animals were identifiable does introduce some questions about the validity of the results for this experiment. A future version of this experiment could improve things by finding a full set of 10 fake animals. If you're interested in how this problem affects the experiment's validity, or about the validity of the experiment in general, check out the full paper where this and other concerns are raised.

-


**Q:** What were the final results of the experiment?

**A:** I was able to show that the presence of the statistics did indeed have a significant effect on people's tendency to answer IDK. Using a conservative estimation strategy, people answered IDK 2 - 3.5 fewer times when presented with the summary stats (p < 0.001).

If you'd like to read the technical write-up with all the R code and statistical nerdery, you can find it here: https://github.com/cw25/i_dont_know_experiment/blob/master/final/final.pdf

-


**Q:** I feel so unsatisfied. Can I ask more questions?

**A:** Sure! chris.walker@ischool.berkeley.edu


