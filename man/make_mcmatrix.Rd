\name{make_mcmatrix}
\alias{make_mcmatrix}
\alias{make_mcchains}
\title{ Generate a multi-companion matrix from spectral description}
\description{
  Generate a multi-companion matrix or its Jordan decomposition from
  spectral parameters.
}
\usage{
make_mcmatrix(type = "real", what.res = "matrix", \dots, eigval0)

make_mcchains(eigval, co, dim, len.block, eigval0 = FALSE,
              mo.col = NULL, what.co = "bottom", \dots)
}
\arguments{
  \item{eigval}{ the eigenvalues, a numeric vector }
  \item{co}{ the seeding parameters for the eigenvectors, a matrix}
  \item{dim}{ the dimension of the matrix, a positive integer }
  \item{len.block}{ lengths of Jordan chains,
    \code{len.block[i]} is for \code{eigval[i]} }
  % \item{what.co}{ how to interpret the elements of \code{co}, see details }
  \item{type}{ mode of the matrix, real or complex }
  \item{what.res}{ format of the result, see details }
  \item{eigval0}{ If TRUE completes the matrix to a square matrix, see
    details. \code{eigval0} is ignored by \code{make_mcmatrix} (it
    always sets it to \code{TRUE}).}
  \item{\dots}{
    for \code{make_mcmatrix}, these are additional arguments to be passed
    to  \code{make_mcchains}. For \code{make_mcchains}, arguments in
              \code{"..."} are passed on to  \code{mc_0chains}.
  }
  \item{mo.col}{
    the last non-zero column in the top of the mc-matrix. The default is
    \code{dim}.
  }
  \item{what.co}{
    a character string equal to \code{"bottom"} (default) or
    \code{"top"}, specifying whether the 'co' parameters give the last
    or the first few elements of the (generalised) eigenvectors.
  }
}
\details{

  \code{make_mcmatrix} creates a multi-companion matrix specified by
  spectral parameters. \code{make_mcchains} creates a matrix of
  eigenvectors and generalised eigenvectors from the given spectral
  parameters.

  \code{make_mcmatrix} passes the spectral parameters to
  \code{make_mcchains} to generate the (generalised) eigenvectors. It
  then calls \code{Jordan_matrix} to create the corresponding Jordan
  matrix.  The results are combined to produce the multicompanion
  matrix.  By default, the real part is returned, which is appropriate
  if all complex spectral parameters come in complex conjugate
  pairs. This may be changed by argument \code{type}. A list containing
  the matrix and the Jordan factors is returned if \code{what.res =
  "list"}.

  The closely related function \code{\link{sim_mc}} is like
  \code{make_mcmatrix} but it does not need complete specification of
  the matrix - it completes
  any missing information (eigenvalues, co) with randomly generated
  entries. The result of both functions is a list or ordinary matrix,
  use \code{\link{mCompanion}} to obtain a \code{MultiCompanion} object
  directly.

  \code{make_mcchains} constructs the eigensystem, \code{make_mcmatrix}
  calls \code{make_mcchains} (passing the \code{...} arguments to it)
  and forms the matrix. \code{make_mcchains} passes the \code{...}
  arguments to \code{mc_0chains}.
  % \code{make_mcev} and \code{make_mcgev}. Currently (July 2007) the
  % only one (of the '...' arguments?) of importance to the user is
  % \code{what.co}.

  \code{make_mcchains} creates the full eigenvectors from the \code{co}
  parameters. If the number of vectors is smaller then \code{dim} and
  \code{eigval0} is TRUE  it then completes the system with chains for
  the zero eigenvalue. More specifically, it assumes that the number of
  the given chains is \code{mo.col},  takes chains corresponding
  to the zero eigenvalue, if any, and adds additional eigenvectors
  and/or generalised eigenvectors to construct the complete system.

  The mc-order is determined from the dimension of the 'co'
  parameters. If that is equal to \code{dim}, the mc-matrix is actually a
  general matrix.

  \strong{TODO:} cover the case \code{mo < mo.col}?

}
\value{
  \code{make_mcmatrix} normally returns the multi-companion matrix (as an
  ordinary matrix) having the given spectral properties but if
  \code{what.res = "list"}, it returns a list containing the matrix and
  the spectral information:

  \item{eigval}{eigenvalues, a vector}
  \item{len.block}{lengths of Jordan chains, a vector}
  \item{mo}{multi-companion order, positive integer}
  \item{eigvec}{generalied eigenvectors, a matrix}
  \item{co}{seeding parameters}
  \item{mo.col}{top order}
  \item{mat}{the multi-companion matrix, a matrix}

  \code{make_mcchains} returns a similar list without the component
  \code{mat}.
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2009gen}{mcompanion}
}
\author{Georgi N. Boshnakov}
\note{The result is an ordinary matrix. Also, some entries that should
  be 0 may be non-zero due to numerical error.

  To get a MultiCompanion object use \code{\link{mCompanion}}.
}
\seealso{
  \code{\link{make_mcev}},
  \code{\link{make_mcgev}},
  \code{\link{sim_mc}},
  \code{\link{mCompanion}}
}
\examples{
make_mcmatrix(eigval = c(1, 0.5), co = cbind(c(1,1), c(1, -1)), dim = 4,
              mo.col = 2,
              len.block = c(1, 1))

## one unit root, one root = 0.5
make_mcmatrix(eigval = c(1, 0.5), co = cbind(c(1,1), c(1, -1)), dim = 6,
              mo.col = 2,
              len.block = c(1, 1))

## two simple unit roots, one root = 0.5
make_mcmatrix(eigval = c(1, 1, 0.5), co = cbind(c(1,1), c(1, -1), c(1, 1)), dim = 6,
              mo.col = 3,
              len.block = c(1, 1, 1))

## two unit roots with a single Jordan chain, one root = 0.5
make_mcmatrix(eigval = c(1, 0.5), co = cbind(c(1,1), c(0, 1), c(1, 1)), dim = 6,
              len.block = c(2, 1))


## make_mcchains
make_mcchains(c(1, 0.5), co = cbind(c(1,1), c(1, 1)), dim = 4,
              len.block = c(1, 1), eigval0 = TRUE)

## one unit root, one root = 0.5
make_mcchains(c(1, 0.5), co = cbind(c(1,1), c(1, 1)), dim = 6,
              len.block = c(1, 1), eigval0 = TRUE)

## two simple unit roots, one root = 0.5
make_mcchains(c(1, 1, 0.5), co = cbind(c(1,1), c(1, -1), c(1, 1)), dim = 6,
              len.block = c(1, 1, 1), eigval0 = TRUE)

## two unit roots with a single Jordan chain, one root = 0.5
make_mcchains(c(1, 0.5), co = cbind(c(1,1), c(1, -1), c(1, 1)), dim = 6,
              len.block = c(2, 1), eigval0 = TRUE)



## examples with mc-order = dim
make_mcchains(c(1), co = cbind(c(1,1,1,1), c(1,2,1,1)), dim = 4,
              len.block = c(2), eigval0 = TRUE)
## do not complete with chians for the 0 eigval:
make_mcchains(c(1), co = cbind(c(1,1,1,1), c(1,2,1,1)), dim = 4,
              len.block = c(2), eigval0 = FALSE)

make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(1,2,1,1)), dim = 4,
              len.block = c(2))
make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(1,2,3,4)), dim = 4,
              len.block = c(2))
}
\keyword{matrices}


