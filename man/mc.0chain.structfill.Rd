\name{mc.0chain.structfill}
\alias{mc.0chain.structfill}
\title{Add structural vectors to a 0eigenchain, internal function}
\description{
  Add structural (generalised) eigenvectors to a 0eigenchain, if possible.
  These are vectors that do not depend on the  elements in the
  non-trivial part of the mc matrix. In particular, their first mo.col
  elements are zeroes.
}
\usage{
mc.0chain.structfill(mo, mo.col, chain, v0 = rep(0, mo))
}
\arguments{
  \item{ mo }{ mc order}
  \item{ mo.col }{ mc column order}
  \item{ chain }{
     a matrix with the eigenvector in the first column and successive
     generalised eigenvectors in the following columns.  A vector may
     stand for a matrix with one column.
  }
  \item{ v0 }{ vector to use as bottom of  the new vectors}
}
\value{
  the  chain, possibly appended with additional vectors
}
\details{
  The size of the matrix is deduced from the length of the vector(s) in
  \code{chain}.

  Structural chains associated with the zero eigenvalue appear when
  \code{mo.col} is smaller than the dimension of the matrix. Such chains
  do not depend on the actual values in the non-structural part of the
  matrix. As such they are the same when the size, multi-companion order
  and \code{mo.col} are fixed. If the  core of the matrix is singular
  the structural chains do not describe  completely the space
  associated with the zero eigenvalue.

  It is quite straight-forward to generate a structural chain associated
  with a given eigenvector or to complete a partially given
  chain. However, no attempt is made to check if the supplied chain may
  indeed be the beginning of a structural chain.  Such a check is
  straightforward but is not implemented since the function is internal
  and is called  only by functions that know (hopefully) what they are
  doing.

}
\author{Georgi N. Boshnakov}
\keyword{ mcchain }
\keyword{internal}
