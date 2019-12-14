\name{SmallMultiCompanion-class}
\Rdversion{1.1}
\docType{class}
\alias{SmallMultiCompanion-class}
\alias{coerce,SmallMultiCompanion,matrix-method}
\alias{initialize,SmallMultiCompanion-method}

\title{A class for small multi-companion matrices}
\description{A class for internal use for work with small
  multi-companion matrices.
}
\section{Objects from the Class}{

  This class is for internal use.

  Objects can be created by calls of the form
  \code{new("SmallMultiCompanion", Mtop, Mbot, jdMtop, MbotXtop)}.
}
\section{Slots}{
  \describe{
    \item{\code{jdMtop}:}{Object of class \code{"JordanDecomposition"} ~~ }
    \item{\code{Mtop}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{Mbot}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{MbotXtop}:}{Object of class \code{"matrix"} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "SmallMultiCompanion", to = "matrix")}: ... }
    \item{initialize}{\code{signature(.Object = "SmallMultiCompanion")}: ... }
    \item{JordanDecomposition}{\code{signature(values = "SmallMultiCompanion", vectors = "missing")}: ... }
	 }
}
\author{
  Georgi N. Boshnakov
}
\seealso{
  \code{\linkS4class{MultiCompanion}}
}
\examples{
mat2 <- make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(0,1,0,0)), dim = 4,
len.block = c(2))
mat2
## Jordan decomp. of mat2[1:2,1:2]:
x2 <- matrix(c(1,1,-1,0), ncol =2)
jd <- matrix(c(1,0,1,1), ncol = 2)
mat2[1:2,1:2] - x2 \%*\% jd \%*\% solve(x2)
jdobj <- JordanDecomposition(values = 1, vectors = x2, heights = 2)

m1 <- new("SmallMultiCompanion", mat2[1:2, 1:2], Mbot = mat2[3:4, 1:2], jdMtop = jdobj)
m1a <- new("SmallMultiCompanion", Mbot = mat2[3:4, 1:2], jdMtop = jdobj)
as.matrix(m1) - as.matrix(m1a)  # (approx.) 0's
}
\keyword{classes}
