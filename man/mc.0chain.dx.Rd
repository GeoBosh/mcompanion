\name{mc.0chain.dx}
\alias{mc.0chain.dx}
\title{Extend chains for the top}
\description{
  Extend 0chains of the top left corner to chains for the top left square
  corner, internal function.
}
\usage{
mc.0chain.dx(mo, mo.col, chF0top, F0bot, tol0 = 1e-12)
}
\arguments{
  \item{ mo }{ mc order }
  \item{ mo.col }{ mc column order, must be less than \code{mo} }
  \item{ chF0top }{ 0chains of the top of the mc matrix, a list with one
    matrix for each chain}
  \item{ F0bot }{ bottom of the top of the mc matrix, a matrix}
  \item{ tol0 }{ tolerance for declaring a vector to be 0 }
}
\value{
  0chains for the top left \code{mo x mo} corner derived from \code{chF0top}
}
\details{

  For each chain in \code{chF0top} there are two possibilities.  Let
  \eqn{v} be the eigenvector in the chain, i.e. \code{F0top} \eqn{\times
  v=0}{x v = 0}.  If \code{F0bot} \eqn{\times v}{x v} is the zero vector,
  then the corresponding chain for the larger matrix is obtained by
  extending the vector to size \code{mo x mo} arbitrarily, most
  naturally with 0s.  Otherwise, if \code{F0bot} \eqn{\times v}{x v} is
  not the zero vector, a new eigenvector is (0,...,0,\code{F0bot}
  \eqn{\times v}{x v}) (there are mo.col zeroes here) and the remaining
  members of the chain are obtained from the given chain by
  \code{...}. Notice that the eigenvector in \code{chF0top} (after
  extension) becomes the second member of the resulting chain, etc.

  If the eigenvectors (0,...0,\code{F0bot} \eqn{\times v_i}{x v_i}) are
  linearly independent the job is done. But they may be linearly
  dependent. If this is the case some of them need to be dropped and a
  transformation is performed to obtain proper Jordan chains.

}
\author{Georgi N. Boshnakov}
\seealso{
   \code{\link{reduce_chains_simple}}
}
\keyword{ mcchain }
\keyword{internal}
