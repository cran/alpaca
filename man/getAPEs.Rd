% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getAPEs.R
\name{getAPEs}
\alias{getAPEs}
\title{Compute average partial effects after fitting binary choice models with a one-/two-/three-way error 
component}
\usage{
getAPEs(
  object = NULL,
  n.pop = NULL,
  panel.structure = c("classic", "network"),
  sampling.fe = c("independence", "unrestricted"),
  weak.exo = FALSE
)
}
\arguments{
\item{object}{an object of class \code{"biasCorr"} or \code{"feglm"}; currently restricted to 
\code{\link[stats]{binomial}}.}

\item{n.pop}{unsigned integer indicating a finite population correction for the estimation of the 
covariance matrix of the average partial effects proposed by 
Cruz-Gonzalez, Fernández-Val, and Weidner (2017). The correction factor is computed as follows: 
\eqn{(n^{\ast} - n) / (n^{\ast} - 1)}{(n.pop - n) / (n.pop - 1)}, 
where \eqn{n^{\ast}}{n.pop} and \eqn{n}{n} are the sizes of the entire 
population and the full sample size. Default is \code{NULL}, which refers to a factor of zero and 
a covariance obtained by the delta method.}

\item{panel.structure}{a string equal to \code{"classic"} or \code{"network"} which determines the 
structure of the panel used. \code{"classic"} denotes panel structures where for example the same
cross-sectional units are observed several times (this includes pseudo panels). 
\code{"network"} denotes panel structures where for example bilateral trade flows are observed 
for several time periods. Default is \code{"classic"}.}

\item{sampling.fe}{a string equal to \code{"independence"} or \code{"unrestricted"} which imposes 
sampling assumptions about the unobserved effects. \code{"independence"} imposes that all 
unobserved effects are independent sequences. \code{"unrestricted"} does not impose any
sampling assumptions. Note that this option only affects the optional finite population correction. 
Default is \code{"independence"}.}

\item{weak.exo}{logical indicating if some of the regressors are assumed to be weakly exogenous (e. g. 
predetermined). If object is of class \code{"biasCorr"}, the option will be automatically set to 
\code{TRUE} if the chosen bandwidth parameter is larger than zero. Note that this option only 
affects the estimation of the covariance matrix. Default is \code{FALSE}, which assumes that all 
regressors are strictly exogenous.}
}
\value{
The function \code{\link{getAPEs}} returns a named list of class \code{"APEs"}.
}
\description{
\code{\link{getAPEs}} is a post-estimation routine that can be used to estimate average partial 
effects with respect to all covariates in the model and the corresponding covariance matrix. The 
estimation of the covariance is based on a linear approximation (delta method) plus an optional 
finite population correction. Note that the command automatically determines which of the regressors 
are binary or non-binary.

\strong{Remark:} The routine currently does not allow to compute average partial effects based 
on functional forms like interactions and polynomials.
}
\examples{
\donttest{
# Generate an artificial data set for logit models
library(alpaca)
data <- simGLM(1000L, 20L, 1805L, model = "logit")

# Fit 'feglm()'
mod <- feglm(y ~ x1 + x2 + x3 | i + t, data)

# Compute average partial effects
mod.ape <- getAPEs(mod)
summary(mod.ape)

# Apply analytical bias correction
mod.bc <- biasCorr(mod)
summary(mod.bc)

# Compute bias-corrected average partial effects
mod.ape.bc <- getAPEs(mod.bc)
summary(mod.ape.bc)
}
}
\references{
Cruz-Gonzalez, M., I. Fernández-Val, and M. Weidner (2017). "Bias corrections for probit and 
logit models with two-way fixed effects". The Stata Journal, 17(3), 517-545.

Czarnowske, D. and A. Stammann (2020). "Fixed Effects Binary Choice Models: Estimation and Inference
with Long Panels". ArXiv e-prints.

Fernández-Val, I. and M. Weidner (2016). "Individual and time effects in nonlinear panel models 
with large N, T". Journal of Econometrics, 192(1), 291-312.

Fernández-Val, I. and M. Weidner (2018). "Fixed effects estimation of large-t panel data 
models". Annual Review of Economics, 10, 109-138.

Hinz, J., A. Stammann, and J. Wanner (2020). "State Dependence and Unobserved Heterogeneity
in the Extensive Margin of Trade". ArXiv e-prints.

Neyman, J. and E. L. Scott (1948). "Consistent estimates based on partially consistent 
observations". Econometrica, 16(1), 1-32.
}
\seealso{
\code{\link{biasCorr}}, \code{\link{feglm}}
}
