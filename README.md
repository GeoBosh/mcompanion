[![CRANStatusBadge](http://www.r-pkg.org/badges/version/mcompanion)](https://cran.r-project.org/package=mcompanion)
[![R-CMD-check](https://github.com/GeoBosh/mcompanion/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GeoBosh/mcompanion/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/GeoBosh/mcompanion/branch/master/graph/badge.svg?token=8DPALQF8DY)](https://app.codecov.io/gh/GeoBosh/mcompanion)

# Installing mcompanion

The [latest stable version](https://cran.r-project.org/package=mcompanion) is on
CRAN.

    install.packages("mcompanion")

You can install the [development version](https://github.com/GeoBosh/mcompanion) of
`mcompanion` from Github:

    library(devtools)
    install_github("GeoBosh/mcompanion")


# Overview


Package "mcompanion" provides a class for multi-companion matrices with methods
for arithmetic and factorization.  A method for generation of multi-companion
matrices with prespecified spectral properties is provided, as well as some
utilities for periodically correlated and multivariate time series models. See
[Boshnakov (2002)](https://dx.doi.org/10.1016/S0024-3795(01)00475-X) and
[Boshnakov & Iqelan (2009)](https://dx.doi.org/10.1111/j.1467-9892.2009.00617.x).

Package "mcompanion" implements multi-companion matrices as discussed by
Boshnakov (2002) and Boshnakov and Iqelan (2009).  The main feature is the
provided parsimonious parameterisation of such matrices based on their
eigenvalues and the seeds for their eigenvectors.  This can be used for
specification and parameterisation of models for time series and dynamical
systems in terms of spectral characteristics, such as the poles of the
associated filters or transition matrices.

See also [the web site](https://geobosh.github.io/mcompanion/) of mcompanion.

