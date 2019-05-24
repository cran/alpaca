## ---- eval = FALSE-------------------------------------------------------
#  data(psid, package = "bife")
#  head(psid)

## ---- eval = FALSE-------------------------------------------------------
#  ##    ID LFP KID1 KID2 KID3     INCH AGE TIME
#  ## 1:  1   1    1    1    1 58807.81  26    1
#  ## 2:  1   1    1    0    2 41741.87  27    2
#  ## 3:  1   1    0    1    2 51320.73  28    3
#  ## 4:  1   1    0    1    2 48958.58  29    4
#  ## 5:  1   1    0    1    2 53634.62  30    5
#  ## 6:  1   1    0    0    3 50983.13  31    6

## ---- eval = FALSE-------------------------------------------------------
#  library(alpaca)
#  stat <- feglm(LFP ~ KID1 + KID2 + KID3 + log(INCH) | ID + TIME, psid, binomial("probit"))
#  summary(stat)

## ---- eval = FALSE-------------------------------------------------------
#  ## binomial - probit link
#  ##
#  ## LFP ~ KID1 + KID2 + KID3 + log(INCH) | ID + TIME
#  ##
#  ## Estimates:
#  ##            Estimate Std. error z value Pr(> |z|)
#  ## KID1      -0.676905   0.056301 -12.023   < 2e-16 ***
#  ## KID2      -0.344383   0.049896  -6.902  5.13e-12 ***
#  ## KID3      -0.007039   0.035344  -0.199     0.842
#  ## log(INCH) -0.234136   0.054403  -4.304  1.68e-05 ***
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#  ##
#  ## residual deviance= 6069.65,
#  ## null deviance= 8152.05,
#  ## n= 5976, l= [664, 9]
#  ##
#  ## ( 7173 observation(s) deleted due to perfect classification )
#  ##
#  ## Number of Fisher Scoring Iterations: 6

## ---- eval = FALSE-------------------------------------------------------
#  apes.stat <- getAPEs(stat)
#  summary(apes.stat)

## ---- eval = FALSE-------------------------------------------------------
#  ## Estimates:
#  ##             Estimate Std. error z value Pr(> |z|)
#  ## KID1      -0.0880159  0.0373733  -2.355    0.0185 *
#  ## KID2      -0.0447791  0.0197079  -2.272    0.0231 *
#  ## KID3      -0.0009152  0.0050072  -0.183    0.8550
#  ## log(INCH) -0.0304440  0.0161221  -1.888    0.0590 .
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## ---- eval = FALSE-------------------------------------------------------
#  stat.bc <- biasCorr(stat)
#  summary(stat.bc)

## ---- eval = FALSE-------------------------------------------------------
#  ## binomial - probit link
#  ##
#  ## LFP ~ KID1 + KID2 + KID3 + log(INCH) | ID + TIME
#  ##
#  ## Estimates:
#  ##            Estimate Std. error z value Pr(> |z|)
#  ## KID1      -0.596292   0.056301 -10.591   < 2e-16 ***
#  ## KID2      -0.303358   0.049896  -6.080   1.2e-09 ***
#  ## KID3      -0.006111   0.035344  -0.173  0.862733
#  ## log(INCH) -0.207068   0.054403  -3.806  0.000141 ***
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#  ##
#  ## residual deviance= 6069.65,
#  ## null deviance= 8152.05,
#  ## n= 5976, l= [664, 9]
#  ##
#  ## ( 7173 observation(s) deleted due to perfect classification )
#  ##
#  ## Number of Fisher Scoring Iterations: 6

## ---- eval = FALSE-------------------------------------------------------
#  apes.stat.bc <- getAPEs(stat.bc)
#  summary(apes.stat.bc)

## ---- eval = FALSE-------------------------------------------------------
#  ## Estimates:
#  ##            Estimate Std. error z value Pr(> |z|)
#  ## KID1      -0.096502   0.033379  -2.891   0.00384 **
#  ## KID2      -0.049094   0.017778  -2.761   0.00575 **
#  ## KID3      -0.000989   0.005041  -0.196   0.84448
#  ## log(INCH) -0.033511   0.014861  -2.255   0.02414 *
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## ---- eval = FALSE-------------------------------------------------------
#  library(data.table)
#  setDT(psid)
#  psid[, LLFP := shift(LFP), by = ID]

## ---- eval = FALSE-------------------------------------------------------
#  dyn <- feglm(LFP ~ LLFP + KID1 + KID2 + KID3 + log(INCH) | ID + TIME, psid, binomial("probit"))
#  dyn.bc <- biasCorr(dyn, L = 1L)
#  summary(dyn.bc)

## ---- eval = FALSE-------------------------------------------------------
#  ## binomial - probit link
#  ##
#  ## LFP ~ LLFP + KID1 + KID2 + KID3 + log(INCH) | ID + TIME
#  ##
#  ## Estimates:
#  ##           Estimate Std. error z value Pr(> |z|)
#  ## LLFP       1.01608    0.04695  21.643   < 2e-16 ***
#  ## KID1      -0.45389    0.06787  -6.687  2.27e-11 ***
#  ## KID2      -0.15737    0.06031  -2.610   0.00907 **
#  ## KID3       0.01562    0.04331   0.361   0.71839
#  ## log(INCH) -0.18834    0.06165  -3.055   0.00225 **
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#  ##
#  ## residual deviance= 4777.58,
#  ## null deviance= 6549.14,
#  ## n= 4792, l= [599, 8]
#  ##
#  ## ( 1461 observation(s) deleted due to missingness )
#  ## ( 6896 observation(s) deleted due to perfect classification )
#  ##
#  ## Number of Fisher Scoring Iterations: 6

## ---- eval = FALSE-------------------------------------------------------
#  apes.dyn.bc <- getAPEs(dyn.bc)
#  summary(apes.dyn.bc)

## ---- eval = FALSE-------------------------------------------------------
#  ## Estimates:
#  ##            Estimate Std. error z value Pr(> |z|)
#  ## LLFP       0.186312   0.070340   2.649   0.00808 **
#  ## KID1      -0.072324   0.027220  -2.657   0.00788 **
#  ## KID2      -0.025075   0.011242  -2.230   0.02572 *
#  ## KID3       0.002489   0.004967   0.501   0.61632
#  ## log(INCH) -0.030011   0.013689  -2.192   0.02835 *
#  ## ---
#  ## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

