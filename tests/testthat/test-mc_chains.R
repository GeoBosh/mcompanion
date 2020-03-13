

test_that("mc_chain_XXX are correct", {
    # expect_equal_to_reference(smc1.co, "smc1_co")


    ## mc_chain_merge, mc_chain_to_list, mc_chain_subset
    ## mc_chain_extend() - this is major, uses the other functions

    ## examples from mc_chain_extend.Rd
    ev <- make_mcchains(eigval = c(1, 0.5), co = cbind(c(1,1), c(1, -1)), dim = 4,
              mo.col = 2,
              len.block = c(1, 1))
ev
## extend evecs in ev to the requested dim and complete with chains for eval 0.
mc_chain_extend(ev = ev, newdim = 6)
mc_chain_extend(ev = ev, newdim = 7)

mc_chain_to_list(ev)

expect_identical(mc_chain_merge(ev, list()), ev)
expect_identical(mc_chain_merge(list(), ev), ev)

    make_mcchains(eigval = c(1, 0.5), co = cbind(c(1,1), c(1, -1)), dim = 4,
              mo.col = 2 )


})


test_that("Jordan utilities are ok", {

    ## examples from Jordan.Rd
## single Jordan blocks
Jordan_matrix(4, 2) 
Jordan_matrix(5, 3)
Jordan_matrix(6, 1)
## a matrix with the above 3 blocks
Jordan_matrix(c(4, 5, 6), c(2, 3, 1))

## a matrix with a 2x2 Jordan block for eval 1 and two simple 0 eval's
m <- make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(0,1,0,0)),
                     dim = 4, len.block = c(2))
m.X <- cbind(c(1,1,1,1), c(0,1,0,0), c(0,0,1,0), c(0,0,0,1))
m.J <- cbind(c(1,0,0,0), c(1,1,0,0), rep(0,4), rep(0,4))

from_Jordan(m.X, m.J)          # == m
#m.X %*% m.J %*% solve(m.X) # == m
#all(m == from_Jordan(m.X, m.J)) && all(m == m.X %*% m.J %*% solve(m.X))
## TRUE

## which column(s) in m.X correspond to 1st Jordan block?
chain_ind(1, c(2,1,1)) # c(1, 2) since 2x2 Jordan block
    
## which column(s) in m.X correspond to 2nd Jordan block?
chain_ind(2, c(2,1,1)) # 3, simple eval

## which column(s) in m.X correspond to 1st and 2nd Jordan blocks?
chain_ind(c(1, 2), c(2,1,1)) # c(1,2,3)
## non-contiguous subset are ok:
chain_ind(c(1, 3), c(2,1,1)) # c(1,2,4)

## split the chains into a list of matrices
chains_to_list(m.X, c(2,1,1))
    
chains_to_list(m.X, numeric(0))

})
