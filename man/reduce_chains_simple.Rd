\name{reduce_chains_simple}
\alias{reduce_chains_simple}
\title{Transform a chain and drop excess, internal function}
\description{
  Transform a chain and drop excess, internal function.
}
\usage{
reduce_chains_simple(chains, sort = TRUE)
}
\arguments{
  \item{ chains }{ list of 0chains }
  \item{ sort }{ flag for sorting, see details }
}
\value{
  list  of chains
}
\details{

  Given one or more chains corresponding to a common eigenvalue,
  \code{reduce_chains_simple} transforms the chains so that redundant
  eigenvectors are removed. In the process, the heights of some chains
  may decrease and the number of chains may be reduced, too.

  If \code{sort == TRUE} the function reorders the chains so that their
  lengths are in decreasing order.  However, the algorithm depends on
  this being done, so this argument should be used when the chains are
  known to be already sorted.

  I wrote this function as part of the support for chains of
  multi-companion matrices associated with the 0 eigenvalue.  When
  chains specified via the top left \code{mo.col x mo.col} subchains are
  extended to chains of the top left \code{mo x mo} corner the
  (extended) eigenvectors may not be linearly independent.
}
\author{Georgi N. Boshnakov}
\seealso{
 \code{\link{mc.0chain.dx}}}
\keyword{ mcchain }
\keyword{internal}
