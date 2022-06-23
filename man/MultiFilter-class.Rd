\name{MultiFilter-class}
\docType{class}
\alias{MultiFilter-class}
\alias{[,MultiFilter,ANY,ANY,ANY-method}
\alias{initialize,MultiFilter-method}
\alias{mcStable,MultiFilter-method}

\title{Class "MultiFilter" }
\description{
  Objects and methods  for filters with more than one set of
  coefficients.
}
\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{new("MultiFilter", coef, mc, order, sign)}.

  Objects from this class represent periodic filters. A
  \eqn{d}{d}-periodic filter relates an input series
  \eqn{\varepsilon_{t}}{e[t]} to an output series
  \eqn{y_t}{y[t]} by the following formula:
  \deqn{ y_t
    =   \sum_{i=1}^{p_t} \phi  _t(i)y          _{t-i}
      % + \sum_{i=1}^{q_t} \theta_t(i)\varepsilon_{t-i}
      + \varepsilon_t
      ,
    }{   y(t)
    =   \sum_\{i=1\}^\{p_t\} phi(t,i) y(t-i)
      % + \sum_\{i=1\}^\{q_t\} theta(t,i)e(t-i)
      + e(t)
      ,
    }
  where the coefficients \eqn{\phi_t(i)}{phi(t,i)} are \eqn{d}-periodic in
  \eqn{t}, i.e. \eqn{\phi_{t+d}(i)=\phi_t(i)}{phi(t+d,i)=phi(t,i)} and
  \eqn{p_{t+d} = p_{t}}{p[t+d]=p[t]}.

  The periodicity means that it is sufficient to store the coefficients
  in a \eqn{d \times p}{d x p} matrix, where
  \eqn{p=\max(p_1,\dots,p_t)}{p=max{p[1],\dots,p[t]}}.
  Slot \code{coef} contains such a matrix.

  The filter may be specified either by its coefficients or by its
  multi-companion form.
}
\section{Slots}{
  \describe{
    \item{\code{mc}:}{the multi-companion form of the filter, an object
      of class \code{"MultiCompanion"}
    }
    \item{\code{coef}:}{the coefficients of the filter, an object of
      class \code{"matrix"}, whose \eqn{s}{-s}th row contains the
      coefficients for \eqn{t=k \times d +s}{t=k d + s}.
    }
    \item{\code{order}:}{the periodic order of the filter,
      a numeric vector giving the orders of the individual seasons.
    }
    \item{\code{sign}:}{1 or -1. The default value, 1, corresponds to
      the formula given in section "Objects from the Class". It can also
      be -1, if the sum on the right-hand side of that formula is
      preceded by a minus (usual convention in signal processing).
    }
  }
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "MultiFilter", i = "ANY", j = "ANY",
	drop = "ANY")}:
      take subset of the coefficients of the filter in various forms.

      To do: the function needs more work! Document the function and the
      additional arguments!
    }
    \item{initialize}{\code{signature(.Object = "MultiFilter")}:
      This function is called implicitly by \code{new}, see the
      signature for \code{new} above.
      One of \code{mc} and  \code{coef} must be supplied, the other
      arguments are optional.

      If \code{mc} is missing it is computed from \code{coef}.
      In this case, component \code{mC.factorsmat} of slot \code{misc}
      of \code{mc} is set to the companion factorisation of \code{mc}
      (essentially the reversed rows of \code{coef}).

      If \code{coef} is missing it is computed from \code{mc}, see
      \code{\link{mc_factors}}.
    }
    \item{mcStable}{\code{signature(x = "MultiFilter")}:
      Check if the filter is stable.
    }

    See also the documentation for the following functions which are
    effectively methods for class "MuliFilter" but are not defined as
    formal methods:

    \code{mf_period}, \code{mf_order}, \code{mf_poles},
    \code{mf_VSform}.
  }
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2009gen}{mcompanion}
}

\author{Georgi N. Boshnakov}
%\note{ ~~further notes~~ }
% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{% \code{\link{~~fun~~}}
  \code{\linkS4class{MultiCompanion}},
  \code{\link{mf_period}}, \code{\link{mf_order}},
  \code{\link{mf_poles}},
  \code{\link{mf_VSform}}.
}
\examples{
showClass("MultiFilter")

m <- mCompanion("sim",dim=3,mo=2)   # simulate a 3x3 2-comp. matrix
flt <- new("MultiFilter", mc = m )
flt[]
mf_period(flt)
mf_poles(flt)
abs(mf_poles(flt))

mf_VSform(flt,form="U")
mf_VSform(flt,form="L")
mf_VSform(flt,form="I")


# try arguments "coef" and "mc", for comparison
rfi <- sim_pcfilter(2,3) # period=2, order=c(3,3)
# per. filter from a multi-companion matrix
flt1 <- new("MultiFilter",mc=  mCompanion(zapsmall(rfi$mat)) )
flt1[]
mf_period(flt1)
mf_poles(flt1)
abs(mf_poles(flt1))

mf_VSform(flt1,form="U")
mf_VSform(flt1,form="L")
mf_VSform(flt1,form="I")

# per. filter from coefficients, should be the same (numerically)
flt2 <- new("MultiFilter",coef=rfi$pcfilter)
flt2[]
mf_period(flt2)
mf_poles(flt2)
abs(mf_poles(flt2))

mf_VSform(flt2,form="U")
mf_VSform(flt2,form="L")
mf_VSform(flt2,form="I")

}
\keyword{classes}
