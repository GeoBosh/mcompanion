\name{spec_root0}
\alias{spec_root0}
\title{Give the spectral parameters for zero eigenvalues of mc-matrices}
\description{
  Give the spectral parameters for zero eigenvalues of
  mc-matrices.
}
\usage{
spec_root0(dim, mo, mo.col)
}
\arguments{
  \item{dim}{dimension of the matrix, a positive integer.}
  \item{mo}{multi-companion order, a positive integer.}
  \item{mo.col}{last non-zero column in the top of the mc-matrix, a
    non-negative integer.
  }
}
\details{
  \code{spec_root0} prepares a structure for the zero roots of an
  mc-matrix.
}
\value{
  a list with the following components:
  \item{mo           }{multi-companion order}
  \item{ev.type      }{type of the eigenvalues}
  \item{co.type      }{not used currently (\strong{:todo:})}
  \item{n.root       }{number of non-zero roots}
  \item{ev.abs       }{absolute values of roots}
  \item{ev.arg       }{arguments of eigenvalues (0 for positive ev)}
  \item{block.length }{lengths of Jordan blocks}
  \item{co.abs       }{absolute values of seed parameters}
  \item{co.arg       }{arguments of seed parameters (Hz: 0 for positive; 1/2 for negative)}
  \item{co0          }{redundant but keep it for now.}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{spec_root1}},
  \code{\link{mcSpec}}
}
\examples{
spec_root0(4,2,3)
spec_root0(4,2,2)
spec_root0(4,2,1)
spec_root0(5,2,3)
spec_root1(4,2,2)

spec_root0(6,4,2)
spec_root0(6,4,4)
spec_root0(10,4,8)
}
\keyword{mcspec}
