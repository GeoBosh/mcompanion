setClass("SmallMultiCompanion",
         slots = c(jdMtop = "JordanDecomposition", # Xbot = "numberMatrix",
                   Mtop = "matrix", Mbot = "matrix", MbotXtop = "matrix"
                   )
         )

setMethod("initialize",
          "SmallMultiCompanion",
          function(.Object, Mtop, Mbot, jdMtop, MbotXtop) {
              if(missing(jdMtop)) {
                  ev <- eigen(Mtop)  ## TODO: process the possibility for ev's with height > 1
                                     ##       Maybe simply give an error in that case?
                  jdMtop <- new("JordanDecompositionDefault",
                                values = ev$values, vectors = ev$vectors,
                                heights = rep(1L, length(ev$values))
                                )
              } else if(is.list(jdMtop)) { ## compatibility
                  values  <- jdMtop$eigval
                  heights <- jdMtop$len.block
                  vectors <- jdMtop$eigvec
                  jdMtop <- new("JordanDecompositionDefault",
                                values = values, vectors = vectors, heights = heights)
              }

              if(missing(Mtop))
                  Mtop <- as.matrix(jdMtop)

              Xtop <- jdMtop@vectors
              if(missing(MbotXtop))    # one of MbotXtop or Mbot must be provided
                  MbotXtop <- Mbot %*% Xtop
              else
                  Mbot <- MbotXtop %*% solve( as.matrix(Xtop)) # TODO: compute this more carefully.

              .Object@Mtop   <- Mtop
              .Object@Mbot   <- Mbot
              .Object@jdMtop <- jdMtop
              .Object@MbotXtop  <- MbotXtop
              .Object
          }
          )

setAs("SmallMultiCompanion", "matrix",
      function(from){
          mat <- rbind(from@Mtop, from@Mbot)
          cbind(mat, matrix(0, nrow = nrow(mat), ncol = nrow(mat) - ncol(mat)))
      }
      )


as.matrix.SmallMultiCompanion <-
    function(x, ...){
        as(x, "matrix")
    }

setMethod("JordanDecomposition", c(values = "SmallMultiCompanion", vectors = "missing"),
          function(values){
              chains <- smc_chains(values)
              new("JordanDecompositionDefault",
                  values = chains$eigval, vectors = chains$eigvec, heights = chains$len.block)
          }
          )
