% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hdma2.R
\name{wrap_mediation}
\alias{wrap_mediation}
\title{Run mediation analysis for a set of markers}
\usage{
wrap_mediation(qval, X, Y, M, covar = NULL, U = NULL, FDR = 0.1, sims = 3, ...)
}
\arguments{
\item{qval}{set of qValues from max2() function}

\item{X}{an explanatory variable matrix with n rows and d columns.
Each column corresponds to a distinct explanatory variable (Exposure).
Explanatory variables must be encoded as numeric variables.}

\item{Y}{an explanatory variable matrix with n rows and d columns.
Each column corresponds to a distinct explanatory variable (Outcome).
Explanatory variables must be encoded as numeric variables.}

\item{M}{a response variable matrix with n rows and p columns.
Each column corresponds to a beta-normalized methylation profile.
Response variables must be encoded as numeric. No NAs allowed.}

\item{covar}{set of covariable, must be numeric.}

\item{U}{set of latent factors from mEWAS() function}

\item{FDR}{FDR threshold to pass markers in mediation analysis}

\item{sims}{number of Monte Carlo draws for nonparametric bootstrap or quasi-Bayesian approximation.
10000 is recommended.}

\item{...}{argument of the mediate function from the mediation package}
}
\value{
Tables of results of mediation analyzes for markers with a qValue below the FDR threshold.
Indirect effect (ACME - average causal mediation effect), ADE (average direct effect),
PM (proportion mediated) and TE (total effect). Composition of tables: estimated effect,
confidence interval and mediation pValue.
We also return, We also return the results of the linear regressions.
The xm table corresponds to the regressions of X on Mi and
the my table to the regressions of Y on Mi knowing X.
With Mi corresponding to the different CpGs tested.
}
\description{
Estimate various quantities for causal mediation analysis for each
significant markers, including average causal mediation effects
(indirect effect), average direct effects, proportions mediated,
and total effect.
}
\details{
We use the mediate() function of the mediation package on the set of markers having a qValue lower
than the FDR threshold. This function makes it possible to estimate their indirect effects and to
test their significance.
}
\examples{

library(hdma2)

data(example)

# Run mEWAS

res <- mEWAS(X = example$X, Y = example$Y, M = example$M, K = 5)

# Keep latent factors for mediation

U <- res$U2

# Run max2

res <- max2(pval1 = res$pValue[, 1], pval2 = res$pValue[, 2])

# Run mediation (only 3 simulations for estimate and test indirect effect)

res <- wrap_mediation(qval = res$qval,
                            X = example$X,
                            Y = example$Y,
                            M = example$M,
                            U = U, sims = 3)

# Plot summary

plot_summary_ACME(res$ACME)

plot_summary_med(res)

}
\author{
Basile Jumentier
}
