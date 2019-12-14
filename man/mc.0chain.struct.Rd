\name{mc.0chain.struct}
\alias{mc.0chain.struct}
\title{ Compute structural Jordan chains for zero eigenvalues }
\description{
  Compute structural Jordan chains for zero eigenvalues,
}
\usage{
mc.0chain.struct(dim, mo, mo.col, chains = list(), sort = TRUE)
}
\arguments{
  \item{dim}{ dimension of the mc-matrix, a positive integer }
  \item{mo}{ multi-companion order}
  \item{mo.col}{ top order }
  \item{chains}{a list of Jordan chains for zero eigenvalues}
  \item{sort}{
    if TRUE sort the chains in descending order of their lengths.
  }
}
\details{
  Structural Jordan chains for 0 eigenvalues are present when
  \code{mo.col < dim}.

  If \code{chains} is empty, then this function assumes that the
  structural chains span the space corresponding to 0 eigenvalues
  (equivalently, the \code{mo.col x mo.col} principal submatrix is of
  full rank).

  Otherwise, the chains given by \code{chains} are amended with the
  structural chains. The given chains are usually changed in the
  process. (Actually, \code{mc.0chain.struct} doesn't change existing
  chains. It only adds new ones if needed, since it assumes that
  triangulation has already been done.)

  Note that a multi-companion matrix cannot have more than \code{mo}
  chains corresponding to an eigenvalue. In particular, it is not
  appropriate to ignore the possibility for chains of length larger than
  1, as is normal in numerical computations, see the references for
  details.

}
\value{
  a list with with the following components:
  \item{eigval}{the eigenvalues (all 0 here), one for each chain}
  \item{len.block}{the lengths of the  chains}
  \item{chains}{ a list with one element (a matrix) for each Jordan chain}
}
\author{Georgi N. Boshnakov}
\note{
  The more obscure particular cases need testing.
}
\seealso{
    \code{\link{mc_0chains}} which calls this function.
}
\examples{
y742t <- mc.0chain.struct(7, 4, 2) # sort = TRUE is default
y742f<- mc.0chain.struct(7, 4, 2, sort = FALSE)

o <- order(y742f[[2]], decreasing = TRUE)
y742fa <- lapply(y742f, function(x) x[o])
stopifnot(identical(y742t, y742fa))
}
\keyword{ mcchain }
\keyword{internal}
