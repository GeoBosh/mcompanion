## "JordanDecomposition" is a virtual class but there is a generic function
## JordanDecomposition() which creates suitable Jordan decomposition objects from some
## derived non-virtual class.

setClass("JordanDecomposition", contains = "VIRTUAL")

## The basic non-virtual Jordan decomposition class
setClass("JordanDecompositionDefault",
         slots = c(values = "number", heights = "integer", vectors = "matrix"),
         contains = "JordanDecomposition"
         )

# not set as a validity function for the class since can't control when it is called.
.validJD <- function(object){
    if(   length(object@values) == length(object@heights)
       && ncol(object@vectors) == sum(object@heights))
        return(TRUE)

    err <- character(0)
    if(length(object@values) != length(object@heights))
        err <- c(err, "'values' and 'heights' must have equal lengths")
    if(ncol(object@vectors) != sum(object@heights))
        err <- c(err, "the number of vectors must equal sum(heights)")
    err
}




setMethod("initialize",
          "JordanDecompositionDefault",
          function(.Object, heights, ...){
              .Object <- callNextMethod(.Object, ...)
              if(missing(heights))
                  .Object@heights <- rep(1L, length(.Object@values))
              else{
                  .Object@heights <- as.integer(heights)
              }

              status <- .validJD(.Object)
              if(is.character(status))
                  stop(paste0(status, collapse="\n"))
              .Object
          }
          )


setAs("JordanDecompositionDefault", "matrix",
      function(from){
          j <- Jordan_matrix(from@values, from@heights)
          from_Jordan(from@vectors, j)
      }
      )

as.matrix.JordanDecompositionDefault <-
    function(x, ...){
        as(x, "matrix")
    }

## Generator function for Jordan decomposition objects

JordanDecomposition <- function(values, vectors, heights, ...){
    stop("No default method yet.")
}

setGeneric("JordanDecomposition")

setMethod("JordanDecomposition", c(values = "number", vectors = "matrix"),
          function(values, vectors, heights){
              new("JordanDecompositionDefault",
                  values = values, vectors = vectors, heights = heights)
          }
          )

setMethod("JordanDecomposition", c(values = "missing", vectors = "matrix"),
          function(values, vectors, heights){
              new("JordanDecompositionDefault",
                  values = rep(NA_real_, ncol(vectors)),
                  vectors = vectors, heights = heights)
          }
          )

setMethod("JordanDecomposition", c(values = "number", vectors = "missing"),
          function(values, vectors, heights){
              nc <- sum(heights)
              vectors <- matrix(NA_real_, nrow = nc, ncol = nc )
              new("JordanDecompositionDefault",
                  values = values, vectors = vectors, heights = heights)
          }
          )

setMethod("JordanDecomposition", c(values = "missing", vectors = "missing"),
          function(values, vectors, heights){
              if(missing(heights))
                  new("JordanDecompositionDefault")
              else{
                  n <- length(heights)
                  values <- rep(NA_real_, n)
                  vectors <- matrix(NA_real_, n, n)
                  new("JordanDecompositionDefault",
                      values = values, vectors = vectors, heights = heights)
              }
          }
          )


## methods for which values provides all the information or i sthe matrix to be decomposed.

setMethod("JordanDecomposition", c(values = "list", vectors = "missing"),
          function(values, names){
              if(missing(names)){ # note: assignment to 'values' must be after the others!
                  heights <- values[["heights"]]
                  vectors <- values[["vectors"]]
                  values <-  values[["values"]]
              }else{
                  heights <- values[[names["heights"]]]
                  vectors <- values[[names["vectors"]]]
                  values <-  values[[names["values" ]]]
              }
              new("JordanDecompositionDefault",
                  values = values, vectors = vectors, heights = heights)
          }
          )

setMethod("JordanDecomposition", c(values = "JordanDecomposition", vectors = "missing"),
          function(values){
              values
          }
          )
