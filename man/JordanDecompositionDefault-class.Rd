\name{JordanDecompositionDefault-class}
\Rdversion{1.1}
\docType{class}
\alias{JordanDecompositionDefault-class}
\alias{JordanDecomposition-class}
\alias{coerce,JordanDecompositionDefault,matrix-method}
\alias{initialize,JordanDecompositionDefault-method}

\title{A basic class for Jordan decompositions}
\description{A basic class for Jordan decompositions.}
\details{

  Class \code{"JordanDecompositionDefault"} represents Jordan
  decompositions. It inherits from the virtual class
  "JordanDecomposition", which serves as a base class for Jordan
  decompositions. These classes should be considered internal.

}
\section{Objects from the Class}{

  Objects from class \code{"JordanDecompositionDefault"} can be created
  by  a call to  \code{JordanDecomposition()}.

  Objects can be created by calls of the form
  \code{new("JordanDecompositionDefault", heights, ...)}.

}
\section{Slots}{
  \describe{
    \item{\code{values}:}{Object of class \code{"number"},
      vector of eigenvalues (one value for each Jordan chain).
    }
    \item{\code{heights}:}{Object of class \code{"integer"},
      the heights of the Jordan chains.
    }
    \item{\code{vectors}:}{Object of class \code{"matrix"},
      the (generalised) eigenvectors (similarity matrix).
    }
  }
}
\section{Extends}{
Class \code{"\linkS4class{JordanDecomposition}"}, directly.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "JordanDecompositionDefault",
	to = "matrix")}:

      gives the matrix represented by the Jordan decomposition, i.e.
      \eqn{XJX^{-1}}. As with other coerce methods, use
      \code{as(obj, "matrix")}, where \code{obj} is the Jordan
      decomposition object.

    }
    \item{initialize}{\code{signature(.Object = "JordanDecompositionDefault")}: ... }
	 }
}
\author{
  Georgi N. Boshnakov
}
\seealso{
  \code{\link{JordanDecomposition}}
}
\examples{
showClass("JordanDecompositionDefault")

m <- matrix(c(1,2,4,3), nrow = 2)
new("JordanDecompositionDefault", values = rep(0,2), vectors = m)
}
\keyword{classes}
