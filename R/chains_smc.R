## new file 2015-12-22

              # 2015-11-07 changed the check that chbot[ , 1] is zero, since
              #            mc.0chain.transf() takes care of (approx.) linear dependence.
              #
              #            also, when chbot[ ,1] was zero, chbot was not used for the results,
              #            not quite correct.
              # TODO: after this change 'tol0' is not used any more.
     # 2015-12-22  mc.0chain.dx moved here from mc01zero.R
## mc.0chain.dx should become redundant after testing (see eg smc_0chain_transformed).
mc.0chain.dx <- function(mo, mo.col, chF0top, F0bot, tol0 = 1e-12){ #arbitrary constant here!?
    nch <- length(chF0top)
    nbr <- mo - mo.col
    stopifnot(nbr > 0)

    wrk <- vector(nch, mode = "list")
    for(i in 1:nch){
        chbot <-  F0bot %*% chF0top[[i]]
        chlen <- ncol(chF0top[[i]])
                         # 2015-11-07 this gives the same result as tmp below
                         #            TODO: Delete tmp and the code computing it after testing
        wrk[[i]] <- rbind(cbind(0, chF0top[[i]]),
                          cbind(chbot, 0))

                  tmp <- matrix(0, nrow = mo, ncol = 1 + chlen)
                  tmp[1:mo.col, -1] <- chF0top[[i]]
                  if(chlen>1)
                      tmp[(mo.col+1):mo, 2:chlen] <- chbot[,-1]
                  tmp[, 1] <- c(numeric(mo.col), chbot[ , 1])
                  ## wrk[[i]] <- tmp

                  stopifnot(identical(wrk[[i]], tmp))

        if(all(chbot[ , 1] == 0))
            wrk[[i]] <- wrk[[i]][ , -1, drop = FALSE]
    }

    res <- reduce_chains_simple(wrk)

    res
}

.smc_struct_0chains <- function(mo, mo.col){# must have mo >= mo.col
    if(mo.col == mo)
        return(list())

    #else mo.col < mo
    dm <- diag(nrow = mo) # struct 0vectors are columns mo.col + 1, ..., mo
    lapply((mo.col+1):mo, function(i) dm[  , i, drop = FALSE])
}

                                   # 2015-12-22 generalises mc.0chain.dx but also adds the
                                   #     structural 0vectors, since in general this cannot be
                                   #     done completely independently.

                                   # F0 corresponds to M in my latest manuscripts.
smc_0chain_transformed <- function(mo, mo.col, chF0top, F0bot.chF0top = NULL, F0bot){
    stopifnot(mo - mo.col > 0)
    if(is.null(F0bot.chF0top))
        F0bot.chF0top <- lapply(chF0top, function(x) F0bot %*% x)

                     # no, easier to do it in the loop; think about speed later, if important.
                     #    len0 <- sapply(chF0top, function(x) NCOL(x))
                     #    jc <- Jordan_submatrix(0, len0, mo, mo.col - sum(len0))

    chlen.all <- sapply(chF0top, ncol)

    cur.start <- mo.col - sum(chlen.all) + 1 # first column corresponding to 0vector

    wrk <- vector(length(chF0top), mode = "list")
    for(i in seq(along = wrk)){
        chlen <- chlen.all[i]

        curtop <- rbind(matrix(0, cur.start - 1, chlen),
                        diag(chlen))

        chbot <- F0bot.chF0top[[i]]  #  F0bot %*% chF0top[[i]]

        wrk[[i]] <- rbind(cbind(0, curtop),
                          cbind(chbot, 0))

        if(all(chbot[ , 1] == 0))
            wrk[[i]] <- wrk[[i]][ , -1, drop = FALSE]

        cur.start <- cur.start + chlen
    }

    dm <- diag(nrow = mo)                    # struct 0vectors are columns mo.col + 1, ..., mo
    ch.struct <- lapply((mo.col+1):mo, function(i) dm[  , i, drop = FALSE])

    wrk <- c(wrk, ch.struct) # append the struct 0vectors

    res <- reduce_chains_simple(wrk)

    # Not possible to do the reverse transform of the top.
    # This chunk doesn't work since chF0top contains only the 0vectors, but the transf. needs
    # the rest.
    #
    # chF0top.mat <- do.call("cbind", chF0top)    # convert chF0top to matrix
    # col.top <- seq(length = mo.col)
    # res <- lapply(res, function(x){x[col.top, ] <- chF0top.mat %*% x[col.top, , drop = FALSE]
    #                                x})
    # # equivalently:
    # # for(i in seq(along = res)){
    # #     res[[i]][col.top, ] <- chF0top.mat %*% res[[i]][col.top, , drop = FALSE]
    # #
    # # }

    res
}


smc_chains <- function(smc){  # smc is "SmallMultiCompanion"
    eval <- smc@jdMtop@values    # rename 'eval'
    flag.non0 <- eval != 0
    tot.non0 <- sum(smc@jdMtop@heights[flag.non0])

    ## TODO: currently assuming non-zero values are before zeroes.
    ind.non0 <- seq(length=tot.non0)
    Xtop.non0 <- smc@jdMtop@vectors[ , ind.non0]
    J.non0 <- Jordan_matrix(eval[ind.non0], smc@jdMtop@heights[seq(ind.non0)])

    mo <- nrow(smc@Mtop) + nrow(smc@Mbot)
    mo.col <- nrow(smc@Mtop)

    ind0 <- chain_ind(which(!flag.non0), smc@jdMtop@heights)

    ## 0chains
    ch0 <- lapply(which(!flag.non0),
                  function(ind) smc@jdMtop@vectors[ , chain_ind(ind, smc@jdMtop@heights)
                                                    , drop = FALSE])

              # allch0 <- mc_0chains(dim, mo, mo.col, ch0, F0bot = smc@Mbot)
              # allch0 <- c(list(mo = mo, mo.col = mo.col), allch0, list(co = allch0$eigvec))

    if(length(ch0) == 0){# only structural 0chains
        ch0.lst <- .smc_struct_0chains(mo, mo.col)
    }else{
        ch0.transf <- smc_0chain_transformed(mo, mo.col, ch0, F0bot = smc@Mbot)

        col.top <- seq(length = mo.col)
        ch0.lst <- lapply(ch0.transf,
                          function(x){
                              x[col.top, ] <- smc@jdMtop@vectors %*% x[col.top, , drop = FALSE]
                              x})
    }

    allch0 <- list(mo = mo, mo.col = mo.col,
                   eigval = rep(0, length(ch0.lst)),
                   len.block = sapply(ch0.lst, ncol),
                   eigvec = do.call("cbind", ch0.lst),
                   co     = do.call("cbind", ch0.lst)
                   )

    ## non-0 chains
    Xbot.non0 <- if(length(ind.non0) > 0)
                     smc@Mbot %*% Xtop.non0 %*% solve(J.non0)
                 else
                      matrix(nrow = nrow(smc@Mbot), ncol = 0)

    eigvec.non0 <- rbind(Xtop.non0, Xbot.non0)

    allchnon0 <- list(mo = mo, mo.col = mo.col,
                      eigval = eval[flag.non0],
                      len.block = smc@jdMtop@heights[flag.non0],
                      eigvec = eigvec.non0,
                      co = eigvec.non0 )

    ## combine non-0 and 0 chains
    res <- mc_chain_merge(allchnon0, allch0)

    res
}

smc_eigen <- function(smc){
    chains <- smc_chains(smc)

    list(values = chains$eigval, vectors = chains$eigvec, len.block = chains$eigval)
}
