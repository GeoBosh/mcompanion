\name{spec_root1}
\alias{spec_root1}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Give the spectral parameters for eigenvalues  of mc-matrices
  equal to one
}
\description{Give the spectral parameters for eigenvalues  of
  mc-matrices equal to one.
}
\usage{
spec_root1(mo, root1 = numeric(0), iorder = 0, siorder = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mo}{mc order.}
  \item{root1}{Jordan block lengths for the unit roots, a vector of
    positive integer numbers.
  }
  \item{iorder}{order of integration, a non-negative integer.}
  \item{siorder}{order of seasonal integration, a non-negative integer.}
}
\details{

  The specifications given by \code{root1}, \code{iorder} and
  \code{siorder} are combined and the spectral parameters prepared.

  In principle, argument \code{root1} is sufficient, the other two
  are for convenient specification of integration and seasonal
  integration.



  \strong{TODO:} rename argument \code{root1}!
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
  \item{co1          }{temporary hack; \strong{TODO:} check the calling code and
    remove it!}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{mcSpec}},
  \code{\link{spec_root0}}
}
\examples{
spec_root1(4, root1 = 1)
spec_root1(4, root1 = c(1,0,0,0))  # same
spec_root1(4, iorder = 1)          # same

spec_root1(4, root1 = 2)
spec_root1(4, root1 = c(2,0,0,0))  # same
spec_root1(4, iorder = 2)          # same

spec_root1(4, root1 = c(1,1,1,1))
spec_root1(4, siorder = 1)          # same

spec_root1(4, root1 = c(2,2,2,2))
spec_root1(4, siorder = 2)          # same


spec_root1(4, root1 = c(2,1,1,1))
spec_root1(4, iorder = 1, siorder = 1) # same


spec_root1(4, root1 = c(2,1))
spec_root1(4, root1 = c(2,1,1))

}
\keyword{mcspec}
