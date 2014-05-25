## These two functions, makeCacheMatrix and cacheSolve, work together to
## take an inverse of a matrix, cache the inversed matrix, and retrieve 
## the inversed matrix.

## The makeCacheMatrix function below creates a special matrix object that 
## can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x # Returns original matrix above
    setinverse <- function(solve) m <<- solve # calcutaes the inverse of the matrix
    getinverse <- function() m # retrieves the inverse of the matrix
    list(set = set, # a list of the functions
         get = get, 
         setinverse = setinverse, 
         getinverse = getinverse)
}

## The cacheSolve function computes the inverse of the special "matrix" 
## returned by makeCacheMatrix above. If the inverse has already been calculated
## (and the matrix has not changed), then the cachesolve should retrieve the
## inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        ## function is solve(x)
    m <- x$getinverse() # sets the inverse matrix as object 'm'
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get() # the original matrix
    m <- solve(data, ...) # the inverse of the matrix
    x$setinverse(m) # calculated the inverse of the matrix
    m # returns the inverse of the matrix
}