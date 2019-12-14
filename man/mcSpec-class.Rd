\name{mcSpec-class}
\Rdversion{1.1}
\docType{class}
\alias{mcSpec-class}
\title{A class for spectral specifications of multi-companion matrices}
\description{A class for spectral specifications of multi-companion matrices.}
\section{Objects from the Class}{
  Objects can be created by calls of one of the following equivalent
  forms:
  \itemize{
    \item
    \code{mcSpec(dim, mo, root1, iorder, siorder, order, evtypes, ...)},

    \item
    \code{new("mcSpec", dim, mo, root1, iorder, siorder, order, evtypes, ...)}.
  }
  %%  ~~ describe objects here ~~

  An object of class "mcSpec" holds a spectral specification of a square
  multi-companion matrix. The specification may be only partial. In that
  case unspecified components are set to \code{NA}.

  Eigenvalues are represented by their modulus and complex argument. The
  argument is in cycles per unit time. So, a negative real number has
  argument 0.5.

  The complex eigenvalues come in pairs and only one needs to be
  specified. If an eigenvalue is not simple, it should not be
  repeated. Rather, the size of the corresponding Jordan
  block should be specified.

  The types of the eigenvalues may be "r" (real) or "cp" (complex
  pair).

  See \code{\link{mcSpec}} for full details about the initialization
  function for class \code{mcSpec}.
}
\section{Slots}{
  \describe{
    \item{\code{dim}:}{dimension of the matrix, a positive integer.}
    \item{\code{mo}:}{multi-companion order, a positive integer.}
    \item{\code{ev.type}:}{Types of eigenvalues, "r" or "cp", a
      character vector.
    }
    \item{\code{co.type}:}{Types of the \code{co} parameters, a
      character vector.
    }
    \item{\code{order}:}{orders of the factors, the default is
      \code{rep(dim,mo)}.
    }
    \item{\code{n.root}:}{number of nonzero roots.}
    \item{\code{ev.abs}:}{absolute values (moduli) of the roots.}
    \item{\code{ev.arg}:}{complex arguments of the roots (cycles per
      unit time). In particular, zero for positive reals, 0.5 for
      negative reals. (\strong{TODO:} check that functions that use this
      specification know that!)
    }
    \item{\code{block.length}:}{sizes of Jordan blocks corresponding to
      the eigenvalues, a vector of positive integers. By default the
      eigenvalues are simple.
    }
    \item{\code{co.abs}:}{moduli of the \code{co} parameters, a matrix.}

    \item{\code{co.arg}:}{arguments of the \code{co} parameters, a
      matrix.
    }
    \item{\code{mo.col}:}{
      Object of class \code{"numeric"}.
    }
    \item{\code{F0bot}:}{
      Object of class \code{"optionalMatrix"}.
    }
  }
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "mcSpec")}:
        see \code{\link{mcSpec}}.
    }
  }
}
\author{Georgi N. Boshnakov}
\note{

  The initialization function for \code{mcSpec} class is incomplete, in
  the sense that it does not cover all cases.

}

\seealso{
  \code{\link{mcSpec}}
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
}
\examples{
mcSpec(dim = 5, mo = 4, root1 = c(1,1), order = rep(3,4))
mcSpec(dim = 5, mo = 4, root1 = c(1,1,1), order = rep(5,4))
mcSpec(dim = 5, mo = 4, root1 = c(1,1,1,1), order = rep(5,4))
}
\keyword{classes}
