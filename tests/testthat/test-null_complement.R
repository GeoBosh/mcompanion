test_that("null_companion works ok.", {
    m1 <- diag(1, nrow = 3, ncol = 2)
    expect_equal(null_complement(m1), matrix(c(0,0,1), ncol = 1))
    
    expect_equal( dim(null_complement(c(1,1,0)    )), c(3,2) )
    expect_equal( dim(null_complement(c(1,1,0), m1)), c(3,1) )

    expect_equal(null_complement(rep(NA_real_, 3), m1),
                 matrix(NA_real_, nrow = 3, ncol = 1))

    expect_equal(null_complement(NA, m1), m1)
    expect_error(null_complement(NA), "One of 'm' and 'universe' must be non-NULL")

})



