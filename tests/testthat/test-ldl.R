
test_that(".ldl() and .udu() work.", { ## can beused also as examples
    m <- matrix(c(5,1,1,3),2,2)
    m.ldl <- mcompanion:::.ldl(m)
    m.udu <- mcompanion:::.udu(m)
    ml <- m.ldl$L %*% diag(m.ldl$d) %*% t(m.ldl$L)
    mu <- m.udu$U %*% diag(m.udu$d) %*% t(m.udu$U)
    expect_equal(ml, m)
    expect_equal(mu, m)
    expect_equal(mu, ml)

    x <- matrix(c(1:5, (1:5)^2), 5, 2)
    x <- cbind(x, x[, 1] + 3*x[, 2]) #3rd column is linear combination columns 1-2
    colnames(x) <- letters[20:22]

    m <- crossprod(x)
    expect_equal(qr(m)$rank, 2)  # is 2, as it should be

    ## TODO: make these smarter.
    ##
    ## These are volatile, so commenting out.  though the only problem currently seems to be
    ## on Atlas ("Additional issues" on CRAN):
    ##       
    ##   * checking tests ...
    ##     Running ‘testthat.R’
    ##    ERROR
    ##   Running the tests in ‘tests/testthat.R’ failed.
    ##   Complete output:
    ##     > library(testthat)
    ##     > library(mcompanion)
    ##     > 
    ##     > test_check("mcompanion")
    ##     ── 1. Failure: .ldl() and .udu() work. (@test-ldl.R#20)  ───────────────────────
    ##     `chol(m)` did not throw an error.
    ##     
    ##     ── 2. Failure: .ldl() and .udu() work. (@test-ldl.R#21)  ───────────────────────
    ##     `mcompanion:::.ldl(m)` did not throw an error.
    ##     
    ##     ── 3. Error: .ldl() and .udu() work. (@test-ldl.R#23)  ─────────────────────────
    ##     the leading minor of order 3 is not positive definite
    ##     Backtrace:
    ##      1. mcompanion:::.udu(m)
    ##      2. mcompanion:::.ldl(S)
    ##      5. base::chol.default(x)
    ##     
    ##     ══ testthat results  ═══════════════════════════════════════════════════════════
    ##     [ OK: 96 | SKIPPED: 4 | WARNINGS: 0 | FAILED: 3 ]
    ##     1. Failure: .ldl() and .udu() work. (@test-ldl.R#20) 
    ##     2. Failure: .ldl() and .udu() work. (@test-ldl.R#21) 
    ##     3. Error: .ldl() and .udu() work. (@test-ldl.R#23) 
    ##     
    ##     Error: testthat unit tests failed
    ##     Execution halted
    ## 
    ## msg3_notpd <- "the leading minor of order 3 is not positive definite"
    ## 
    ## expect_error(chol(m), msg3_notpd)
    ## expect_error(mcompanion:::.ldl(m), msg3_notpd)
    ## 
    ## m.udu <- mcompanion:::.udu(m)
    ## mu <- m.udu$U %*% diag(m.udu$d) %*% t(m.udu$U)
    ## expect_false(all(mu == m))
    ## expect_lt(max(abs(mu - m)), 1e-11)

    msg_rank <- "the matrix is either rank-deficient or indefinite"
    expect_warning(mcho <- chol(m, pivot = TRUE), msg_rank)
    expect_equal(attr(mcho, "pivot"), c(3L,1L,2L))
    expect_equal(attr(mcho, "rank"),2)
    oo <- order(attr(mcho, "pivot"))
    expect_lt(max(abs(t(mcho[ , oo]) %*% mcho[ , oo] - m)), 1e-11)
         #   t u            v
         # t 0 0 0.000000e+00
         # u 0 0 0.000000e+00
         # v 0 0 1.818989e-12
    expect_true(all((t(mcho[ , oo]) %*% mcho[ , oo] - m)[1:5] == 0))

    ##
    x <- structure(c(5, 1, 1, 3), .Dim = c(2L, 2L))
    xldl <- .ldl(x)
    x.fromldl <- xldl$L %*% diag(xldl$d) %*% t(xldl$L)
    ## it is too much to expect restored object to be exactly the same as x:
    expect_false(all(x == x.fromldl))
    ## but the differences are very small:
    expect_equal(x[1,2], x.fromldl[1,2])
    expect_equal(x[2,1], x.fromldl[2,1])
    expect_lt(abs(x[1,1] - x.fromldl[1,1]), 1e-15)
    expect_lt(abs(x[2,2] - x.fromldl[2,2]), 1e-15)
})

test_that("permute_var() and permute_synch() work.", {
    Cl <- cor(longley) # example for 'cor'
    nc <- ncol(Cl)
    v <- 1:nc
    names(v) <- colnames(Cl)
    all(permute_var(Cl) == Cl[ncol(Cl):1, ncol(Cl):1])
    p1 <- sample(nc)
    all(permute_var(Cl, p1) == Cl[p1, p1])
    expect_true(all(replicate(10,
                              {p <- sample(nc)
                               all(permute_var(Cl, p) == Cl[p, p])
                           })))

    Cla <- permute_synch(list(Cl, v))
    Clb <- permute_synch(list(v, Cl))
    expect_identical(Cla[[1]], Clb[[2]])
    expect_identical(Cla[[2]], Clb[[1]])

})
