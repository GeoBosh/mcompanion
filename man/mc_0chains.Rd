\name{mc_0chains}
\alias{mc_0chains}
\title{ Generate eigenchains for zero eigenvalues }
\description{
  Generate eigenchains for zero eigenvalues of multi-companion matrices
}
\usage{
mc_0chains(dim, mo, mo.col, vec0, flagtriang = TRUE)
}
\arguments{
  \item{dim}{ dimension of the matrix }
  \item{mo}{ multi-companion order }
  \item{mo.col}{ number of (non-zero) structural columns }
  \item{vec0}{ a list of Jordan chains for non-structural zero
    eigenvalues, see details }
%  \item{F0bot}{bottom of the top of the matrix, used only if \code{mo.col<mo}}
  \item{flagtriang}{triangulase the vectors?}
}
\details{

  Non-structural eigenvectors for zero eigenvalues may be specified with the
  \code{vec0} argument. It is a list with one element for each
  non-structural 0 eigenvalue. This element is a matrix with the seeding
  chain for the corresponding chain (!!! edit this !!!) with enough
  number of rows (at least the multi-companion order). This is often a
  zero chain for a mc matrix of smaller or larger size. In that case the
  vectors in the chain are extended or shrinked, respectively. However,
  extending and shrinking of 0-chains is different from the ordinary
  case of non-zero eigenvalues and involves increasing or decreasing the
  number of vectors in the chain.

  If \code{vec0} is missing or equal to \code{list()} the function
  assumes that the only 0 eigenvalues are the structural ones, i.e. that
  there are no 0 eigenvalues among the remaining eigenvalues.
}
\value{
  A list with elements \code{eigval}, \code{len.block}, \code{eigvec},
  and \code{chains}. These may be easily merged with the output from
  \code{make_mcev}.
}
%\references{ ~put references to the literature/web site here ~ }
\author{Georgi N. Boshnakov}
\note{
  This function covers all possibilities but has not been tested
  properly in the case when non-structural 0 eigenvalues are present.

  \strong{TODO:} Prepare meaningful examples and tests.

  2015-12-27: dropped argument F0bot. The old signature was
  \code{mc_0chains(dim, mo, mo.col, vec0, F0bot = NULL, flagtriang = TRUE)}.


}
\seealso{ \code{\link{make_mcev}} }
\examples{
mc_0chains(6, 4, 1)
mc_0chains(6, 4, 2)
mc_0chains(6, 4, 3)
mc_0chains(6, 4, 4)

mc_0chains(6, 2, 2)
mc_0chains(6, 2, 4)
mc_0chains(6, 2, 3)
mc_0chains(6, 2, 3, list(matrix(1,              ncol=1, nrow=6)))
mc_0chains(6, 2, 3, list(matrix(c(1,0,0,0,0,0), ncol=1, nrow=6)))
mc_0chains(6, 2, 3, list(matrix(c(0,1,0,0,0,0), ncol=1, nrow=6)))
mc_0chains(6, 2, 3, list(matrix(c(0,0,0,0,0,1), ncol=1, nrow=6)))
mc_0chains(6, 2, 3, list(matrix(c(0,0,0,0,1,0), ncol=1, nrow=6)))

mc_0chains(2, 2, 2,list(matrix(c(0,1),ncol=1,nrow=2)))

mc_0chains(12,4,2)
}
\keyword{ mcchain }
\keyword{internal}
