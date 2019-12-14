\name{permute_var}
\alias{permute_var}
\alias{permute_synch}
\title{Permute rows and columns of matrices}
\description{Permute rows and columns of matrices.}
\usage{
permute_var(mat, perm = nrow(mat):1)
permute_synch(param, perm)
}
\arguments{
  \item{mat}{a matrix.}
  \item{param}{a matrix or list, see Details.}
  \item{perm}{permutation, defaults to \code{nrow:1}.}
}
\details{

  Given a permutation, \code{permute_var} permutes the rows and columns
  of a matrix in such a way that if \code{mat} is the covariance matrix
  of a vector \code{x}, then the rearranged matrix is the covariance
  matrix of \code{x[perm]}. If \code{P} is the permutation matrix
  corresponding to \code{perm}, then the computed value is
  \code{P \%*\% mat \%*\% t(P)}.

  \code{permute_synch} performs the above transformation on all matrices
  found in \code{param}. More precisely, if \code{param} is a matrix,
  then the result is the same as for \code{permute_var}. Otherwise
  \code{param} should be a list and, conceptually, \code{permute_synch} is
  applied recursively on each element of this list. The net result is
  that each matrix, say \eqn{M}, in \code{param} is replaced by
  \eqn{PMP'} and each vector, say \eqn{v}, by \eqn{Pv}. The idea is that
  \code{param} may contain specification of a VAR model, all components
  of which need to be reshuffled if the components of the multivariate
  vector are permuted.

  All matrices in \code{param} must have the same number of rows, say
  \code{d}, but this is not checked. \code{perm} should be a permutation
  of \code{1:d}.

}
\value{
  for \code{permute_var}, a matrix,

  for \code{permute_synch}, a matrix or list of the same shape as
  \code{param} in which each matrix is transformed as described in
  Details.
}
\author{Georgi N. Boshnakov}
\examples{
Cl <- cor(longley) # from example for 'cor()'
nc <- ncol(Cl)
v <- 1:nc
names(v) <- colnames(Cl)

permute_var(Cl)
all(permute_var(Cl) == Cl[ncol(Cl):1, ncol(Cl):1])
}
\keyword{matrices}
