\name{mc_eigen}
\alias{mc_eigen}
\alias{mc_eigenvalues}
\title{The eigen decomposition of a multi-companion matrix}
\description{
  Give the eigenvalues or the entire eigen decomposition of a
  multi-companion matrix
}
\usage{
mc_eigen(x, ...)
mc_eigenvalues(x, ...)
}
\arguments{
  \item{x}{
    a multi-companion matrix, an object of class MultiCompanion.
  }
  \item{\dots}{additional arguments, currently not used. }
}
\details{

  Both functions first check if the decomposition is stored in
  \code{x} and, if that is the case, return the result without
  computations. This is particularly useful when the matrix is created
  from its spectral decomposition in the first place. The only
  restrictions on the result in this case come from the structure of
  multi-companion matrices.

  Otherwise they use \code{eigen} to do the main computation. In
  addition, if the top of the matrix has structural columns of zeroes,
  \code{mc_eigen} takes care to call \code{eigen} with a sub-matrix
  whose last column is not zero, and handles the zero eigenvalues
  separately.

  Note that \code{x@mo.col} is the last column containing nonzero
  elements in the top of the matrix. By calling \code{eigen} on the top
  left \code{x@mo.col} square block, rather than on the entire matrix,
  we achieve several things. Firstly, this block may turn out to be
  non-singular. In that case, the chains corresponding to zero
  eigenvalues, if any, are structural and straightforward. Secondly, if
  this block turns out to be singular, we know that by reducing the
  dimension we have left out only elements corresponding to zero
  eigenvalues. The vectors associated with zero eigenvalues are somewhat
  tricky in this case, but manageable.

  The net effect is that the only restriction comes from the use of
  \code{eigen}, which does not handle Jordan chains of length larger
  than one.  In general, this is not a problem, since chains with more
  than one vector are not likely to occur numerically. In particular, it
  is relatively safe to assume that the space spanned by the non-zero
  eigenvalues of the multicompanion matrix has a basis of
  eigenvectors. However, when \code{x@mo.col} is smaller than the
  dimension of the matrix, eigenchains associated with the zero value
  can easily occur, due to the structure of the matrix.  That is why we
  pay special attention to them.

  In \code{mc_eigen} the handling of the zero eigenvalues is based on
  \code{\link{mc_chain_extend}}.  The latter takes care also of zero
  eigenvalues whose Jordan blocks are of size larger than one.

}
\value{
  For \code{mc_eigenvalues}, the eigenvalues as a vector.

  For \code{mc_eigen}, the eigenvalues and eigenvectors as a list with
  components \code{values} and \code{vectors}. In addition the list
  contains a component \code{len.block} with the lengths of the Jordan
  chains.

}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
}
\author{Georgi N. Boshnakov}
\note{
  \code{mc_eigenvalues} currently simply calls \code{eigen} if the
  eigenvalues are not stored in the object. It is probably mostly useful
  when the interest is in the nonzero eigenvalues.
}
\examples{
x <- sim_mc(6,4,mo.col=2)
x
y <- mCompanion(x,detect="gen")
y
z <- as.matrix(y)
xx <- mCompanion(x=z,mo.col=2)
mc_eigen(xx)
}
\keyword{ matrices }

