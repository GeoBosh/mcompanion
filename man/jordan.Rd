\name{jordan}
\alias{Jordan_matrix}
\alias{from_Jordan}
\alias{chain_ind}
\alias{chains_to_list}
\title{ Utilities for Jordan matrices }
\description{

  Utility functions for work with the Jordan decompositions of matrices:
  create a block diagonal matrix of Jordan blocks,
  restore a matrix from its Jordan decomposition,
  locate specific chains.

}
\usage{
Jordan_matrix(eigval, len.block)
from_Jordan(x, jmat, \dots)
chain_ind(chainno, len.block)
chains_to_list(vectors, heights)
}
\arguments{
  \item{eigval}{ eigenvalues, a numeric or complex vector. }
  \item{len.block}{
    lengths of Jordan chains, a vector of positive integers.
  }
  \item{x}{
    generalised eigenvectors, a matrix with one column for each
    (generalised) eigenvector.
  }
  \item{jmat}{ a Jordan matrix. }
  \item{chainno}{
    a vector of positive integers between 1 and \code{length(eigval)}
    specifying which Jordan chains to locate, see Details.
  }
  \item{...}{further arguments to pass on to \code{solve}.}
  \item{vectors}{a matrix of generalised eigenvectors of a matrix.}
  \item{heights}{
    a vector of chain lengths, \code{heights[i]} is the length of the
    i-th chain.
  }
}
\details{

  \code{Jordan_matrix} creates a Jordan matrix (block-diagonal matrix
  with Jordan blocks on the diagonal) whose i-th diagonal block
  corresponds to \code{eigval[i]} and is of size \code{len.block[i]}.
  If \code{len.block} is missing, \code{Jordan_matrix} returns
  \code{diag(eigenvalues)}.

  \code{from_Jordan} computes the matrix whose Jordan decomposition is
  represented by arguments \code{X} (chains) and \code{J} (Jordan
  matrix). Conceptually, the result is equivalent to \eqn{XJX^{-1}} but
  without explicitly inverting matrices (currently the result is the
  transpose of \code{solve(t(x), t(x \%*\% jmat), ...)}).

  \code{chain_ind} computes the columns of specified Jordan chains in a
  matrix of generalised eigenvectors. It is mostly internal function.
  If \code{x} is a matrix whose columns are generalised eigenvectors and
  the i-th Jordan chain is of length \code{len.block[i]}, then this
  function gives the column numbers of \code{x} containing the specified
  chains.
  Note that \code{chain_ind} is not able to deduce the total number of
  eigenvalues. It is therefore an error to omit argument
  \code{len.block} when calling it.

  \code{chains_to_list} converts the matrix \code{vectors} into a list
  of matrices. The i-th element of this list is a matrix whose columns
  are the vectors in the i-th chain.

}
\value{
  for \code{Jordan_matrix}, a matrix with the specified Jordan blocks on
  its diagonal.

  for \code{from_Jordan}, the matrix with the specified Jordan
  decomposition.

  for \code{chain_ind}, a vector of positive integers giving the columns
  of the requested chains.

  for \code{chains_to_list}, a list of matrices.

}
\author{Georgi N. Boshnakov}
\section{Level}{0}
\examples{
mat2 <- make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(0,1,0,0)), dim = 4, len.block = c(2))
mat2
mat2 \%*\% c(1,1,1,1) # e.v. for eigenvalue 1

mat2 \%*\% c(0,1,0,0)     # gen.e.v. for eigenvalue 1
c(1,1,1,1) + c(0,1,0,0) # same (confirming the above)

## mat2 X = X jordan.block
cbind(c(1,1,1,1), c(0,1,0,0)) \%*\% cbind(c(1,0), c(1,1))
mat2 \%*\% cbind(c(1,1,1,1), c(0,1,0,0))

mat2.X <- cbind(c(1,1,1,1), c(0,1,0,0), c(0,0,1,0), c(0,0,0,1))
mat2.X
mat2.J <- cbind(c(1,0,0,0), c(1,1,0,0), rep(0,4), rep(0,4))
mat2.J

mat2.X \%*\% mat2.J \%*\% solve(mat2.X)
mat2  # same

mat2.X \%*\% mat2.J
mat2 \%*\% mat2.X    # same
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ matrices }
