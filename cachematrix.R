## Put comments here that give an overall description of what your
## functions do

## These two functions, makeCacheMatrix and cacheSolve, take an inverse of a
## matrix and cache it.

## The makeCacheMatrix function below creates a special matrix object that 
## can cache its inverse

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
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}