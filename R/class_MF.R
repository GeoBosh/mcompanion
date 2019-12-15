setClass("MultiFilter", # 2014-11-23 slots was: "representation" which is obsolete from R-3.0.0
         slots = list(
             mc = "MultiCompanion",
             coef = "matrix",
             order = "numeric",   #integer?
             sign = "numeric"
             ## , type = "character"   # "pc", "v", "vs"
             )
         ##, contains = c("ddenseMatrix", "generalMatrix")
         ##, prototype=list(m=matrix(NA,nrow=4,ncol=9) )
         )

setMethod("initialize", "MultiFilter",
          function(.Object, coef, mc, order, sign = 1) {
              if(missing(coef)){
                  coef <- mc_factors(mc,what="mat")
                                       # reverse the order of the factors for the filter form.
                  coef <- coef[nrow(coef):1,1:ncol(coef),drop=FALSE]
              }else if(missing(mc)){
                  xtop <- mc_from_filter(coef)
                                        # 2013-10-10 zapazvam coefficientite na filtara,
                                        #   t.e. companion factors. Obrastam reda
                  misc <- list(mC.factorsmat = coef[nrow(coef):1, ])
                  mc <- new("MultiCompanion", xtop = xtop, mo.col = "detect", misc=misc)
              }

              if(missing(order)){           # todo: with apply
                  order <- numeric(nrow(coef))
                  for(i in 1:length(order)){
                      order[i] <- max(which(coef[i,] != 0))
                  }
              }

              .Object@mc <- mc
              .Object@coef <- coef
              .Object@sign <- sign
              .Object@order <- order
              .Object
          }
          )

# "["
                                        # is TRUE for drop better (as with built-in indexing)?
# "what" may be one of "kc", "kk", "ck", "cc", k stands for "keep signs" and c for "change".
# form may be "pc" (per. correlated), "vs" (vector of seasons), or "v" (standard var).

# aditional arg "truncate"? - otdelen method, j tryabva da e missing za da ima smisal truncate
# oste, "form" tryabva da e "pc"

# dali da napravya da dopalva s nuli ako j e po-golyamo ot order? mozhe bi argument za tova?
setMethod("[", signature(x = "MultiFilter"),
          function(x, i, j, k, lag0 = FALSE, what = "kc", form = "pc", drop = FALSE){
              d <- mf_period(x)
              if(form == "pc"){
                  ## simply  calling   wrk <- x@coef[i=i,j=j,drop=drop]
                  ## does not work when i or j is missing.
                  ## It may have something  to do with .local, created by setMethod.
                  ## Also,  x@coef[j=j,drop=drop], etc  would not work properly.
                  wrk <- if(missing(i) && missing(j))
                             x@coef[drop = drop]
                         else if(missing(i))
                             x@coef[ , j = j, drop = drop]
                         else if(missing(j))
                             x@coef[i = i, , drop = drop]
                         else
                             x@coef[i = i, j = j, drop = drop]
                  if(x@sign < 0)
                      wrk <- -wrk

                  if(lag0){       # include 0 lag term
                      if(substr(what, 2, 2) == "c")
                          wrk <- -wrk
                      tmpone <- if(substr(what, 1, 1) == "k")
                                    1
                                else
                                    -1
                      wrk0 <- rep(tmpone, nrow(wrk))   # relies on drop==FALSE  !!!
                      wrk <- cbind(wrk0, wrk)
                  }
              }else if(form %in% c("vs","v")){ # TODO: izglezhda, che tova ne e updatevano
                  if(form == "vs")               # sled promyanata vav mf_VSform (I, U, L) !!!
                      vs <- mf_VSform(x)  #add argument "top" to pass down?
                  else
                      vs <- mf_VSform(x, form = "I")   #add argument "top" to pass down?

                  if(!missing(k)){
                      if(0 %in% k)
                          lag0 <- TRUE
                      else if(lag0)
                          k <- c(0, k)
                      if(0 %in% k)
                          k <- k + 1 # !!! when lag0 is TRUE, the first element is at index 0.
                                     # do not use k for anything else!!!
                  }
                  wrk <- vs$Phi
                  if(lag0){       # include 0 lag term
                      if(substr(what, 2, 2) == "c")
                          wrk <- -wrk
                      tmpone <- vs$Phi0
                      if(substr(what, 1, 1) != "k")
                          tmpone <- -tmpone
                      wrk0 <- tmpone
                      wrk <- cbind(wrk0, wrk)
                  }
                  wrk <- array(wrk, dim = c(d, d, length(wrk) / d^2))
                  ## do subsetting
                  if(!missing(k))
                      wrk <- wrk[ , , k, drop = FALSE]

                  wrk <- if(missing(i) && missing(j))
                             wrk
                         else if(missing(i))
                             wrk[ , j, , drop = FALSE]
                         else if(missing(j))
                             wrk[i, , , drop = FALSE]
                         else
                             wrk[i, j, , drop = FALSE]
                  if(all(dim(wrk) == c(1, 1, 1)))  # only one element
                      wrk <- wrk[ , , ]   # make it scalar
                  else{
                      tmp <- dim(wrk)
                      dim(wrk) <- c(tmp[1], tmp[2] * tmp[3])
                  }
                  if(drop)
                      wrk <- wrk[ , ]
              }else{
                  stop("Feature not yet implemented.")
              }
              res <- wrk

              res
          })

mf_period <- function(x){
    length(x@order)
}

.mF.invperm <- function(x){
    p <- as(x,"pMatrix")
    pt <- t(p)
    pt@perm
}

mf_order <- function(x, i = "max", form = "pc", perm){
    res <- switch(form,
                  pc = { if(is.numeric(i))
                             x@order[i]
                         else if(i=="all")
                             x@order
                         else          # i=="max"
                             max(x@order)
                     },
                  v  = ,               # obsolete (old terminology), use  "I" instead
                  vs = ,               # obsolete (old terminology), use  "U" instead
                  I  = ,  # todo: I is currently the same as U but it needs separate treatment
                  U  =
                      { if(missing(perm))
                            perm <- mf_period(x):1 # for "U" the default is last season on top
                        wrk <- x@order[perm] - (mf_period(x) - 1):0
                        wrk <- ifelse(wrk <= 0, 0, ceiling(wrk/mf_period(x)))

                        wrk <- wrk[.mF.invperm(perm)] # permute back

                        if(is.numeric(i)) #  does not make much sense but provide it.
                            wrk[i]
                        else if(i=="all")
                            wrk
                        else          # i=="max"
                            max(wrk)
                    },
                  L  =
                      { if(missing(perm))
                            perm <- 1:mf_period(x)  # for "L" the default is 1st season on top
                        wrk <- x@order[perm] - 0:(mf_period(x) - 1)
                        wrk <- ifelse(wrk <= 0, 0, ceiling(wrk/mf_period(x)))

                        wrk <- wrk[.mF.invperm(perm)] # permute back

                        if(is.numeric(i)) #  does not make much sense but provide it.
                            wrk[i]
                        else if(i=="all")
                            wrk
                        else          # i=="max"
                            max(wrk)
                    },
                  ## default
                  stop("argument \"form\" must be one of \"pc\", \"I\", \"U\", or \"L\".")
                  )
    res
}

mf_poles <- function(x, blocks = FALSE){
    wrk <- mc_eigen(x@mc)
    if(blocks)
        cbind(wrk$values, wrk$len.block)
    else
        rep(wrk$values, times = wrk$len.block)
}

mf_VSform <- function(x, first = 1, form = "U", perm){
    d <- mf_period(x)                        # First prepare the U form

    top <- if(first == 1)
               d
           else
               first - 1

    s <- d:1
    while(s[1] != top)               # rotate
        s <- c(s[d], s[-d])

    p <- mf_order(x, i = "all")           # orders of individual seasons (vector)
    P <- mf_order(x, form = "vs", perm = s)         # order of the VS representation (scalar)
    m <- P * d
    Phi0 <- diag(d)                    # VS_0
    Phi <- matrix(0, nrow=d, ncol=m)     # remaining coef for VS
    phi <- x[]                   # pc coef; note: this is a recursive call when
                                 # mf_VSform is called  from  [..form="vs"].
                                 # but x[] calls "[" with form="pc", so no further  recursion.
    q <- p[s]
    for(i in seq_len(d - 1)){
        jmax <- min(q[i], d - i)
        if(jmax > 0)
            Phi0[i, i+ 1:jmax] <- -phi[s[i], 1:jmax]
        if(jmax < q[i])
            Phi[i, 1:(q[i]-jmax)] <- phi[s[i], (jmax+1):q[i]]
    }
    Phi[d, 1:q[d]] <- phi[s[d], 1:q[d]] # bottom row

    vs <- list(Phi0 = Phi0, Phi = Phi)                        # the U form

    res <- switch(form,                                   # now modify as required
                  U = vs,
                  L = { perm0 <- as(d:1,"pMatrix")
                        tperm0 <- perm0  #this particular permu. coincides with its inverse
                        list(Phi0 = perm0 %*% vs$Phi0 %*% tperm0,
                             Phi  = rblockmult(perm0 %*% vs$Phi, tperm0)
                             )
                    },
                  I = { list(Phi0 = diag(nrow(vs$Phi0)),
                             Phi  = solve(vs$Phi0,vs$Phi),
                             Phi0inv = solve(vs$Phi0)
                             )
                    },
                  stop("argument \"form\" must be one of \"I\", \"U\", or \"L\".")
                  )

    if(!missing(perm)){                  # Finally, permute the result if `perm' is given
        perm  <- as(perm, "pMatrix")
        perm0 <- as(d:1, "pMatrix")
        permP <- switch(form,
                        U = perm %*% perm0,  # tay kato redat e d:1 v momenta
                        L = perm,            # tay kato veche e v red 1:d
                        I = perm %*% perm0,  # tay kato redat e d:1 v momenta
                        stop("argument \"form\" must be one of \"I\", \"U\", or \"L\".")
                        )
        tpermP <- t(permP)

        res$Phi0 <- permP %*% res$Phi0 %*% tpermP
        res$Phi  <- rblockmult(permP %*% res$Phi, tpermP)
        if(!is.null(res$Phi0inv)) # 2015-02-11 corrected, was wrong for form = "I"
                                  #       was: res$Phi0inv <- solve(res$Phi0)
            res$Phi0inv <- permP %*% res$Phi0inv %*% tpermP
    }

    res
}

setMethod("mcStable", signature( x = "MultiFilter" ),
          function(x){
              wrk <- mf_poles(x)   # may be done more  efficiently.
              all(abs(wrk) < 1)
          }
          )

# 2014-05-21; last modified: 2015-03-26                               # TODO: , trim = TRUE
VAR2pcfilter <- function(phi, ..., Sigma, Phi0, Phi0inv, D, what = "coef", perm){
    perm.flag <- missing(perm)
    Phi0.flag <- missing(Phi0)
    Phi0inv.flag <- missing(Phi0inv)
    Sigma.flag <- missing(Sigma)

    co <- cbind(phi, ...)

    if(!perm.flag){
        if(Sigma.flag){
            if(Phi0inv.flag){
                Phi0inv <- solve(Phi0)
                e.var <- D
            }
            Sigma <- Phi0inv %*% diag(D) %*% t(Phi0inv)
        }

        user.perm <- nrow(co) + 1 - perm
        wrk <- permute_synch(list(co,Sigma), user.perm)
        co <- wrk[[1]]
        Sigma <- wrk[[2]]
        Sigma.flag <- FALSE
    }else{
        perm <- nrow(co):1
    }

    if(!Sigma.flag){
        wrk <- .udu(Sigma)
        Phi0inv <- wrk$U
        Phi0 <- solve(wrk$U)
        e.var <- wrk$d
    }else if(!Phi0inv.flag){
        Phi0 <- solve(Phi0inv)
        e.var <- D
    }else if(!Phi0.flag){
        Phi0inv <- solve(Phi0)
        e.var <- D
    }else{
        stop("One of Sigma, Phi0, Phi0inv must be specified.")
    }

    m <- Phi0 %*% co

    pcfilter <- matrix(0, nrow = nrow(Phi0), ncol = ncol(Phi0) - 1 + ncol(co))
    for(i in 1:nrow(Phi0)){
         perco <- c( - Phi0[i , -(1:i)], m[i, ])
         pcfilter[i, seq_along(perco)] <- perco
    }
    pcfilter <- pcfilter[nrow(Phi0):1, ] # put first season on top

    ## 2015-03-26 making the output more consistent
    if(what == "coef")
        pcfilter
    else if(what == "coef.and.var")
        list(pcfilter = pcfilter,
             var = e.var[nrow(Phi0):1] # 2015-03-26: now permute to correspond to the order in
             )                         #            pcfilter
    else
        list(pcfilter = pcfilter,
             var = e.var[nrow(Phi0):1],
             Uform = list(              # 2015-03-26 note that the permutation of the
                 Sigma = e.var,         #         rows in pcfilter is different from the rest.
                 U0 = Phi0,             # U0, U correspond to A0, A in Boshnakov/Iqelan(2009)
                 U = m,
                 U0inv = Phi0inv,
                 perm = perm
             ))
}
