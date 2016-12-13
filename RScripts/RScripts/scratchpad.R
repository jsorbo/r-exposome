for (year in c(2010, 2011, 2012, 2013, 2014, 2015)) {
    print(paste("The year is", year))
}

for (year in 2010:2015) {
    print(paste("The year is", year))
}

for (i in 2010:2015) {
    print(paste("The year is", i))
}

for (i in 1:10) {
    if (!i %% 2) {
        next
    }
    print(i)
}
