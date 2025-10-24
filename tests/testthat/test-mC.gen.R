
test_that("make_mc(g)ev work properly", {
    expect_that(make_mcev(0, c(1,2,3,4), dim = 7)
                , is_identical_to(c(0,0,0,1,2,3,4)) )

    expect_that(make_mcev(0, c(1,2,3,4), dim = 7, what.co = "top")
                , throws_error() )

    expect_that(make_mcgev(0, c(1,2,3,4), v = c(0,0,0,1,2,3,4), what.co = "top")
                , throws_error() )

    expect_that(make_mcgev(0, c(1,2,3,4), v = c(0,0,0,1,2,3,4))
                , is_identical_to(c(2,3,4, 1,2,3,4)) )


    ## examples from mc_factorize.Rd
    mat2 <- make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(0,1,0,0)),
                          dim = 4, len.block = c(2))
    mat2
    eigen(mat2)
    mc_leftc(mat2, mo = 4, mo.col = 2)
    expect_error(mc_leftc(mat2, mo = 4), "singular matrix 'a' in solve")
    
    mCompanion(mat2)
    mCompanion(mat2, mo = 4, mo.col = 2)
    mc_leftc(mCompanion(mat2), mo = 4, mo.col = 2)
    mc_eigen(mCompanion(mat2), mo = 4, mo.col = 2)
    mc_eigen(mCompanion(mat2, mo = 4, mo.col = 2), mo = 4, mo.col = 2)

})
