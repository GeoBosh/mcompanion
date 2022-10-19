\name{VAR2pcfilter}
\alias{VAR2pcfilter}
\title{PAR representations of VAR models}
\description{
  
  Give the univariate periodic autoregression representation of a VAR
  model. Several arrangements are supported as discussed by
  \insertCite{boshnakov2009gen;textual}{mcompanion}. If the VAR model
  contains unit roots on the unit circle, then the univariate model is
  periodically integrated.
  
}
\usage{
VAR2pcfilter(phi, \dots, Sigma, Phi0, Phi0inv, D, what = "coef", perm)
}
\arguments{
  \item{phi}{VAR coefficients, a matrix, see Details.}
  \item{\dots}{
    alternative way to specify the VAR coefficients by giving a matrix
    for each lag in separate arguments, see section \sQuote{Details}.
  }
  \item{Sigma}{covariance matrix of innovations.}
  \item{Phi0}{coefficient matrix at lag 0 (alternative to \code{Sigma}).}
  \item{Phi0inv}{inverse of \code{Phi0} (alternative to \code{Sigma} and
    \code{Phi0}). If \code{Phi0inv} is lower triangular, then it is the
    Cholesky factor of Sigma (in Sigma\eqn{{} = LDL'}).}
  \item{D}{the diagonal matrix corresponding to \code{Phi0}, not used if
    \code{Sigma} is specified.
  }
  \item{what}{what to return, a string. If equal to \code{"coef"},
    return the PAR coefficients only (as a matrix with one row for each
    ``season''); if equal to \code{"coef.and.var"} return also the
    innovation variances. Otherwise return additional quantities (useful
    for exploration).
  }
  \item{perm}{
    a permutation specifying the ordering of the variables when treated
    as ``seasons''. The default, \code{d:1}, corresponds to the U-form,
    see section \sQuote{Details}.
  }
}
\details{

  \code{VAR2pcfilter} converts a VAR model to a scalar periodic
  autoregressive (PAR) model. There are various ways to specify a VAR
  model and associate its variables with seasons of the scalar
  representation, see \insertCite{boshnakov2009gen;textual}{mcompanion}
  for a detailed discussion and the terminology used here.

  % There is some flexibility in the model specification but in all cases,

  The VAR coefficients \code{phi,...} are those in the standard form of
  the VAR model \insertCite{@e.g., see @boshnakov2009gen}{mcompanion}.
  There are two ways to specify them. The first is to put them side by
  side in a matrix \eqn{[\Phi_1, \ldots, \Phi_p]} and give this matrix
  as argument \code{phi}. Alternatively, the matrices \eqn{\Phi_i} may
  be given directly as arguments to \code{VAR2pcfilter}, as in
  \code{VAR2pcfilter(Phi1, Phi2, Phi3, Sigma = Sigma)}.

  The specification of the model can be completed by giving the
  covariance matrix, \code{Sigma}, of the innovations.  Alternatively,
  it is possible to give the components of the \eqn{UDU'} decomposition
  of \code{Sigma}. In this case argument \code{D} is a vector giving the
  diagonal of the matrix \eqn{D}, while \code{Phi0inv} represents the
  upper triangular matrix \eqn{U}. A further option is to use argument
  \code{Phi0} to specify the inverse of \eqn{U}. In summary, give either
  \code{Sigma} or \code{D} and one of \code{Phi0inv} and \code{Phi0}.

  \code{Phi0} can e interpreted as the coefficient at lag zero in the
  U-form \insertCite{boshnakov2009gen}{mcompanion} of the VAR model.
  \code{diag(D)} is the variance matrix of the innovations in that
  form. \code{D} also gives the variances of the innovations in the PAR
  (periodic autoregression) form.

  By default, \code{VAR2pcfilter} constructs the U-form of the VAR model
  and extracts the coefficients of the PAR filter from it. This means
  that the variables in the multivariate vector are given ``seasons'' in
  reverse order (the first variable takes the last season, and so on).
  For the reasons behind this default, see
  \insertCite{boshnakov2009gen;textual}{mcompanion}.  Another
  arrangement can be chosen with the help of argument
  \code{perm}. \code{perm} should be a permutation specifying the
  desired allocation of variables to seasons. The default corresponds to
  \code{perm=d:1}, where \code{d} is the number of
  seasons. \code{perm=1:d} could be used to request the ``natural''
  order.

  When \code{D} and \code{Phi0inv} (or \code{Phi0}) are given, the
  matrix \code{Sigma} is not computed if argument \code{perm} is missing
  but it is if \code{perm} is present. This means that \code{perm = d:1}
  may be used to force the formation of \code{Sigma} and recomputation
  of \code{Phi0} and \code{Phi0inv}. This is redundant if the latter two
  are unit upper-triangular (which is assumed but not checked) but may
  be handy if, for example, the Cholesky decomposition with a lower
  triangular matrix is available.

}
\value{

  If \code{what="coef"}, a matrix containing the periodic model
  coefficients (one row for each season).

  If \code{what="coef.and.var"}, a list containing the coefficients and
  the innovations' variances:
  \item{pcfilter}{PAR coefficients, a matrix}
  \item{var}{innovation variances, a vector}

  Otherwise the returned list contains an additional component,
  \code{Uform}, which is itself a list with components:
  \item{Sigma}{covariance matrix of innovations,}
  \item{U0}{coefficient for lag zero,}
  \item{U}{the remaining AR coefficients,}
  \item{U0inv}{the inverse of \code{U0},}
  \item{perm}{permutation giving the season of each variable.}

  Note: \code{U0} and \code{U} correspond to \eqn{A0} and \eqn{A} in the
  reference (Boshnakov and Iqelan 2009).
}
\references{
  \insertRef{boshnakov2009gen}{mcompanion}
}
\author{Georgi N. Boshnakov}
\note{
  This function uses some non-exported internal functions:
  \describe{
    \item{.ldl}{
      Computes the LDL' Cholesky decomposition with unit
      lower-triangular matrix L,
    }
    \item{.udu}{
      Computes the UDU' Cholesky decomposition with unit
      upper-triangular matrix U.
    }
  }
  Could export these if they are deemed more widely useful.
}

\seealso{
  \code{\link{mf_VSform}},
  \code{\link{sim_pcfilter}}
}
\examples{
## create a pc filter
rfi <- sim_pcfilter(2,3)
rfi$pcfilter

## turn it into VAR form
flt <- new("MultiFilter", coef = rfi$pcfilter)
I1 <- mf_VSform(flt, form="I")
I1

## from VAR to scalar form
flt2 <- VAR2pcfilter(I1$Phi, Sigma = I1$Phi0inv \%*\% t(I1$Phi0inv))
flt2

## confirm that we are back to the original
##   (VAR2pcfilter doesn't drop redundant zeroes, so we do it manually)
    all.equal(flt2[ , 1:3], rfi$pcfilter) ## TRUE
}
\keyword{ts}
