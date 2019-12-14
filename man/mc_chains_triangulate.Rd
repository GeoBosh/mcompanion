\name{mc_chains_triangulate}
\alias{mc_chains_triangulate}
\title{Triangulate a system of 0eigenvectors}
\description{
  Triangulate a system of 0eigenchains.
}
\usage{
mc_chains_triangulate(chains, mo, mo.col)
}
\arguments{
  \item{ chains }{ chains, see details }
  \item{ mo }{ mc order }
  \item{ mo.col }{ mc column order }
}
\value{
  the  modified chains, a list
}
\details{
  \code{mc_chains_triangulate} triangulates a set of chains to make it easier
  to extend 0chains.

  \code{chains} is a  list of chains for the 0 eigenvalue of
  an mcmatrix. Each chain is represented by a matrix with the eigenvector
  in the first column.

  For a multi-companion matrix the maximum number of chains for an
  eigenvalue  is \code{mo}.

  Only the last \code{mo} elements of eigenvectors of mc matrices
  corresponding to the zero eigenvalue may be non-zero.

  \code{mc_chains_triangulate} triangulates the eigenvectors in the following
  sense. Let \eqn{i_1} be the first non-zero element of the first
  eigenvector. Then the elements in position \eqn{i_1} of the remaining
  eigenvectors are made equal to zero by adding to them a multiple of
  the first eigenvector. The corresponding transformation is done on
  the remaining elements of the chains so that they remain proper
  chains. Then the position, \eqn{i_2}, of the first non-zero element of
  the second eigenvector is found and the elements of the third and the
  following eigenvectors at that position are made zero by adding to them a
  multiple of the second eigenvector. The process is repeated until the
  last eigenvector is reached.

  If \code{mo} is 4 and there are 4 chains, for example, then the above
  procedure will typically transform the bottom \eqn{4\times4} block of the
  matrix obtained from the 4 eigenvectors into a lower triangular
  matrix. If there are zero elements in the original bottom
  \eqn{4\times4} block, then the result will not be a lower triangular
  matrix but the shape will be equivalent for the purposes of extending
  the eigenvectors.

  todo: describe the above precisely in a separate document,
        vzh. rakopisnite belezhki za izpolzvaniya algoritam.

  todo: it is probably worth to do this somewhat more elaborately for
        numerical stability.

  todo: This function is not specific to zero eigenchains.
        It can be used to put in canonic order any other eigenchain (but
        check).
        Change the name?

  todo: strictly speaking, for canonical order more is needed when there
        are chains with the same heights.
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{mc_0chains}} which call this function.
}
\keyword{ mcchain }
\keyword{internal}
