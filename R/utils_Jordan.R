.to_chains <- function(x, len.block){                                         # 2015-11-03 new
    pos <- c(0, cumsum(len.block)) # pos[i] + 1 is the index of the i-th eigvec
    lapply(1:length(len.block), function(i) x[ pos[i] + 1:len.block[i] ] )
}

.ev_ind <- function(x, len.block){
    pos <- c(0, cumsum(len.block)[-length(len.block)] )
    pos + 1  # pos[i] + 1 is the index of the i-th eigvec
}

Jordan_matrix <- function(eigval, len.block){
    if(missing(len.block))       # dali da obrabotvam otdelno sluchaya na skalaren eigval?
        return(diag(eigval))

    stopifnot(length(len.block) == length(eigval),  # matching lengths
              all(len.block > 0)                    # positive dimensions of jordan blocks
              )

    n <- sum(len.block) # dimension of the matrix

    res <- diag(rep(eigval, times = len.block), nrow = n, ncol = n)
    r <- cumsum(c(1, len.block))
    for(i in seq_along(eigval)){   # 2015-10-23 was: 1:length(eigval)
        if(len.block[i] > 1){
            rows <- r[i] + 0:(len.block[i] - 2)
            indmat <- matrix(c(rows, rows + 1), ncol = 2)
            res[indmat] <- 1
        }
    }
    res
}

Jordan_submatrix <- function(eigval, len.block, nrow, from.row = 1){
    jmat <- Jordan_matrix(eigval, len.block)
    to.row <- from.row + nrow(jmat) - 1
    stopifnot(from.row > 0, to.row <= nrow)

    res <- matrix(0, nrow, ncol(jmat))

    res[from.row:to.row, ] <- jmat

    res
}

from_Jordan <- function(x, jmat, ...){ # 2015-10-23 renamed and added arg. "..."
                           # F=res = XJX^(-1) => FX = XJ => X'F'=(XJ)' => F' = solve(X',(XJ)')
                           # res <- x %*% jmat %*% solve(x)
    res <- t(  solve( t(x), t(x %*% jmat        ) )  )

                                # Some tests of the difference between the two variants for F.
                                # print(res)
                                # print(zapsmall(Re(res)))
                                # print(x %*% diag(eigval) %*% solve(x))
                                #
                                # tmp <- res - x %*% diag(eigval) %*% solve(x)
                                # print(Mod(tmp)/Mod(res))
    res
}

j2mat <- function(x){  # seems unused; TODO: remove or rename
    j <- Jordan_matrix(x$eigval, x$len.block)
    from_Jordan(x$eigvec, j)
}

chain_ind <- function(chainno, len.block){                            # popravena na 18/04/2007
    tmp <- c(0, cumsum(len.block))
    indx <- numeric(0)
    for( i in chainno)
        indx <- c(indx, tmp[i] + 1:len.block[i])
    indx
}

chains_to_list <- function(vectors, heights){
    m <- length(heights)
    if(m == 0)
        return(list())

    prev <- c(0, cumsum(heights))
    res <- vector(m, mode="list")
    for( i in 1:m)
        res[[i]] <- vectors[ , prev[i]+ 1:heights[i], drop=FALSE ]

    res
}

               # 2015-12-26 renamed from mc.0chain.transf() - the algorithm is not specific
               #            to the zero-eigenvalues and to mc-chains. It assumes however that
               #            only the eigenvectors may be linearly dependent. The word
               #            "simple" in the name reflects this.
               # TODO: make a version, say reduce_chains(), which reduces also the
               #       generalised e.v.'s
                                                # 2015-11-07 complete overhaul and bug fixing.
reduce_chains_simple <- function(chains, sort = TRUE){        # 09/05/2007 - palna prerabotka.
    ev <- matrix(0, nrow = nrow(chains[[1]]), ncol = 0) # chains must have at least 1  element
    res <- list()
    while(length(chains) > 0){
        if(sort){                       # sort the chains in descending order of their lengths
            indx <- order(sapply(chains,NCOL), decreasing=TRUE)
            chains <- chains[indx, drop = FALSE]
            sort <- FALSE # once sorted, no need for further sort unless a chain is inserted
        }                 # back in 'chains'
        chnew <- chains[[1]]
        chains <- chains[-1]

        if(all(chnew[ , 1] == 0)){  # TODO: more refined test?
            if( NCOL(chnew) == 1 )
                next
            else
                chnew <- chnew[ , -1, drop = FALSE]
        }else if( ncol(ev) > 0 ){
                        ## qr of the transposed matrix is needed since if V is the matrix of
                        ## eigenvectors and V^T=QR, then Q^TV^T = R and each row of Q^TV^T is
                        ## a linear combination of the eigenvectors.  Each row of Q^T (or
                        ## column of Q) gives the coefficients of the corresponding linear
                        ## combination. Hence the change below. (but check!!!)
                        ## changed on 2/8/2007 tmp <- qr(cbind(ev,chnew[,1]))
            tmp <- qr(t(cbind(ev, chnew[,1])))                    # evcur <- chnew[,1]
            if(tmp$rank <= ncol(ev)){                      # evcur is linearly dependent on ev
                if( NCOL(chnew) == 1 ) # the chain consists of 1 ev, drop it,
                    next               #           lin.dep. on previous ev's

                chnew <- chnew[ , -1, drop = FALSE]                     # drop the ev
                r <-  qr.Q(tmp, complete = TRUE)[ , tmp$rank+1] # dobre li e complete=TRUE ???
                                        # 2015-11-07 TODO: maybe the last column when
                                        #                 complete=FALSE gives the same result
                nev <- ncol(ev)
                          ## 2015-11-07 TODO: shouldn't this be nev:1 and not (nev-1):1 ?!
                          ##                  even more clearly, nev is equal to the number of
                          ##                  rows of Q (check), so, the length of r is nev+1.
                          ## Attention: if this note is correct, we should have
                          ##       chnew <- r[nev+1] * chnew
                          #chnew <- r[nev] * chnew
                          #for(j in (nev-1):1)
                chnew <- r[nev+1] * chnew               # rotate chnew to make it proper chain
                for(j in (nev):1)
                    chnew <- chnew + r[j] * res[[j]][ , 2:(ncol(chnew)+1), drop = FALSE]

                if(ncol(chnew) < ncol(chains[[1]]) ){ # insert the current chain back
                    chains <- c(list(chnew), chains)
                    sort <- TRUE                      # needs sorting again...
                    next    # chnew has smaller number of columns, hence no infinite loop here
                }
            }
        }
        res <- c(res, list(chnew))
        ev <- cbind(ev, chnew[ , 1])
    }

    res
}
