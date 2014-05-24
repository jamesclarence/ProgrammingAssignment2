## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
}

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}


# Matrix inversion is usually a costly computation and their may be some 
# benefit to caching the inverse of a matrix rather than compute it repeatedly 
# (there are also alternatives to matrix inversion that we will not discuss here). 
# Your assignment is to write a pair of functions that cache the inverse of a 
# matrix.

# Write the following functions:
    
# makeCacheMatrix: This function creates a special "matrix" object that can 
# cache its inverse.

# cacheSolve: This function computes the inverse of the special "matrix" 
# returned by makeCacheMatrix above. If the inverse has already been calculated
# (and the matrix has not changed), then the cachesolve should retrieve the
# inverse from the cache.

# Computing the inverse of a square matrix can be done with the solve function
# in R. For example, if X is a square invertible matrix, then solve(X) returns
# its inverse.

# For this assignment, assume that the matrix supplied is always invertible.


## Part 1: The meaning of <<-
# In R, we use <- to create (or overwrite) a variable.
# An important thing to understand is that the variable only
# exists within the context in which it is created.
# We can think of this R session as a "parent" context.

aNewContext <- function() {
       # Let's create a variable called myMessage
        myMessage <- "Hello, world!"
        myMessage
    }

# aNewContext is a function that exists in the "parent"
# context. We can think of aNewContext as a "child" of
# the current R session.

# But if we try to access myMessage in the "parent" context,
# we run into a problem, because myMessage no longer exists...

# We can access other "children" from within a "child" context:

things <- 999
sing <- function(thing) {
    sprintf("%d bottles of beer on the %s!", things, thing)
}
sing("wall")

# But if we try to change the value of other "children" from within
# a "child" context, we run into a problem:

# What went wrong? The line "things <- things - 1" actually created a
# new variable called things and set it to the old variable (which
# also happens to be called things) minus 1.
# And then, we didn't do anything with the new variable and it ceased
# to exist as soon as we left the function decreaseThings.
# Enter the <<- operator to refer to variables
# that already exist in some "parent" context...

decreaseThingsProperly <- function() things <<- things -1

# Here's another example...
x <-5
changeX <-function(newXValue) x <- newXValue
changeX(100)

reallyChangeX <- function(newXValue) x <<- newXValue
reallyChangeX(100)

## Part 2
# Functions can take functions as arguments and 
# functions can return functions in R.
# An example of a function that takes a function as an argument

hof <- function(f, x) cat(
          sprintf("The value of y at x = %s is %s.\n", x, f(x)))

# We can pass our own functions:
myFunction <- function(x) 100 * x
hof(myFunction, -5)

# We can pass functions anonymously:
hof(function(x) 2 * x, 10)

# An example of a function that returns a function
nTimes <- function(n) function(x) n * x
threeTimes = nTimes(3) # threeTimes is now a function of x that returns 3 * x
fourTimes = nTimes(4)  # fourTimes returns 4 * x
fiveTimes = nTimes(5)  # etc.
threeTimes(5) # 3 is n -- 3*x, x=5

# We can even write expressions like the following in R:
nTimes(10)(5) # nTimes(10) returns a function, 
              # then we pass 5 to that function -- Ans = 50

# Lists of functions are often useful for grouping functions in a
# single object, and can be used to creating objects analagous to
# in some other languages. 
funcList = list(threeTimes, fourTimes, fiveTimes)
funcList[[1]](5)
# [1] 15
funcList[[2]](5)
# [1] 20
funcList[[3]](5)
# [1] 25
# (Though it's probably easier to read if we name the list members...)
funcListBetter = list(
        threeTimes = threeTimes, 
        fourTimes = fourTimes, 
        fiveTimes = fiveTimes
        )
funcListBetter$threeTimes(5)
# [1] 15
funcListBetter$fourTimes(5)
# [1] 20
funcListBetter$fiveTimes(5)
# [1] 25

## Part 3:"Classes" as functions that return lists of "methods"
## and "properties"

# The elements in the list can be seen as class methods.
# Let's create a very simple "class" to represent a dog.
# A dog won't do much: bark when we tell it to, and 
# we can train it to bark a different number of times
# by swatting it with a newspaper...
    
Dog <- function(name = "Fido", barkType = "Woof!") {
    # Let's set up a "property" that contains a random number of 
    # times the dog will bark when asked to...
    noOfBarks <- numeric(1)
    updateBarkNumber <- function() noOfBarks <<- sample(1:10, 1)
    updateBarkNumber()
    
    # Let's create a "method" that may change the property noOfBarks...
    f <- function() {
        cat(c("YIP!\n", "Grr!\n", "YELP!\n", "Ouch!")[sample(1:4, 1)])
        updateBarkNumber()
        }
    
    # And a "method" to get the dog to bark...
    g <- function() for (i in 1:noOfBarks) cat(sprintf("%s ", barkType))
    
    # The "properties" and "methods" that we'd like to be "public"
    # are simply elements of a list that the function Dog returns; let's
    # create the list and give the elements appropriate names...
    list(name = name, swatWithNewspaper = f, bark = g)
}

# Now let's create some "instances" of Dog...
fido <- Dog()
snookums <- Dog(name = "Snookums", barkType = "Yap!")
fido$name # [1] "Fido"
fido$bark() # Woof! Woof! Woof! Woof! Woof! Woof! Woof! Woof! Woof!


