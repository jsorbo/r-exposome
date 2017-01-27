# Using apply, sapply, lapply
# https://www.r-bloggers.com/using-apply-sapply-lapply-in-r/

m <- matrix(data=cbind(rnorm(30, 0), rnorm(30, 2), rnorm(30, 5)), nrow=30, ncol=3)
m

# rnorm will generate random numbers in a normal distribution

?rnorm

# apply will apply a function over margins of an array or matrix

?apply

# do it wrong - traverse row-wise

apply(m, 1, mean)

# correctly - column-wise

apply(m, 2, mean)

# pass my own function - how many negatives per column?
# this anon function uses subsetting to extract all elements
# in x that are less than 0, then length counts them.
# if a return value is not specified, r will automatically return
# the last evaluated value.
# x is a single column of the matrix.

apply(m, 2, function(x) length(x[x<0]))

# is x a 1-column matrix or just a vector?

apply(m, 2, function(x) is.matrix(x))

# here the func definition was not required...

apply(m, 2, is.matrix)

# verify that they are vectors

apply(m, 2, is.vector)

# sapply and lapply will apply a function over a list or vector

?sapply
?lapply

# sapply works on a list or vector

sapply(1:3, function(x) x^2)

# lapply returns a list rather than a vector

lapply(1:3, function(x) x^2)

# sapply with simplify=FALSE also returns a list

sapply(1:3, function(x) x^2, simplify=F)

# lapply with unlist returns a vector

unlist(lapply(1:3, function(x) x^2))

# make assumptions about structure of underlying data
# fine but not maintainable

sapply(1:3, function(x) mean(m[,x]))

# better: use "..." argument for passing extra arguments

sapply(1:3, function(x, y) mean(y[,x]), y=m)
