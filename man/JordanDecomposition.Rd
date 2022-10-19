\name{JordanDecomposition}
\docType{methods}
\alias{JordanDecomposition}
\alias{JordanDecomposition-methods}
\alias{JordanDecomposition,ANY,ANY-method}
\alias{JordanDecomposition,JordanDecomposition,missing-method}
\alias{JordanDecomposition,list,missing-method}
\alias{JordanDecomposition,missing,matrix-method}
\alias{JordanDecomposition,missing,missing-method}
\alias{JordanDecomposition,number,matrix-method}
\alias{JordanDecomposition,number,missing-method}
\alias{JordanDecomposition,SmallMultiCompanion,missing-method}
\title{Create objects representing Jordan decompositions}
\description{Create objects representing Jordan decompositions.}
\usage{
JordanDecomposition(values, vectors, heights, ...)
}
\arguments{
  \item{values}{
    eigenvalues, a vector of length equal to the number of Jordan chains.
  }
  \item{vectors}{
    the (generalised) eigenvectors, a matrix.
  }
  \item{heights}{
    a vector of positive integers, \code{heights[i]} is the height of
    \code{values[i]}.
  }
  \item{\dots}{
    further arguments that may be needed by methods.
  }
}
\details{

  \code{JordanDecomposition} is an S4 generic function. It creates
  objects representing Jordan decompositions. Dispatch is on the first
  two arguments, \code{values} and \code{vectors}.

  The names of the arguments correspond to slots in class
  "JordanDecompositionDefault", which is the class of the objects
  created by methods in package \pkg{mcompanion} and inherits from the
  virtual class "JordanDecomposition".

}
\value{
  an object inheriting from "JordanDecomposition"
}
\author{Georgi N. Boshnakov}
\section{Methods}{
\describe{

\item{\code{signature(values = "ANY", vectors = "ANY")}}{
  the default method; currently raises an error.
}

\item{\code{signature(values = "JordanDecomposition", vectors = "missing")}}{
  simply returns \code{values}.
}

\item{\code{signature(values = "list", vectors = "missing")}}{

  In this case \code{values} can be a list with components \code{"values"},
  \code{"vectors"} and \code{"heights"}. This method has an additional
  argument \code{"names"} which can be used when the components of the
  list are different, e.g.

  \code{names = c(values = "eigval", vectors = "eigvec", heights = "len.block")}.
}


\item{\code{signature(values = "missing", vectors = "matrix")}}{
  This is equivalent to the case \code{values = "number"} with \code{values}
  set to a vector of missing values.
}

\item{\code{signature(values = "missing", vectors = "missing")}}{

  \code{values} (\code{vectors}) is set to a vector (matrix) of missing
  values. The dimensions are deduced from argument \code{heights}, so
  \code{heights} cannot be missing for this signature.

}

\item{\code{signature(values = "number", vectors = "matrix")}}{
  This is equivalent to calling \code{new} for class
  \code{"JordanDecompositionDefault"} with arguments \code{values},
  \code{vectors} and \code{heights}.
}

\item{\code{signature(values = "number", vectors = "missing")}}{
  This is equivalent to the case \code{vectors = "matrix"} with \code{vectors}
  set to a matrix of missing values.
}

\item{\code{signature(values = "SmallMultiCompanion", vectors = "missing")}}{
  This computes the Jordan decomposition of an object from class
  "SmallMultiCompanion".
}
}}
\examples{
m <- matrix(c(1,2,4,10), nrow = 2)
m <- matrix(c(1,2,4,10), nrow = 2)
m <- matrix(c(5, 12, 3, 4), nrow = 2)

JordanDecomposition(values = rep(0,2), vectors = m)
jd <- JordanDecomposition(values = c(0.9, 0.3), vectors = m)
as(jd, "matrix")
eigen(jd)
## the eigenvectors are scaled versions of m's columns:
eigen(jd)$vectors \%*\% diag(c(5 / eigen(jd)$vectors[1,1], -5))
## == m

## eigenvalues are not supplied, so set to  NA's here:
JordanDecomposition(vectors = m)

## eigenvectors are set to vectors of NA's here:
JordanDecomposition(values = rep(0,2), height = c(1,1))
}
\keyword{methods}
\keyword{algebra}
