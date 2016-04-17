# Matrix inversion is computationally expensive.  In order to eliminate
# redundant evaluation, the functions in this module will allow the user to
# create a matrix that, upon calculation, caches its inverse and returns that
# inverse on subsequent queries until the original matrix changes (invalidating
# the cached matrix)

# makeCacheMatrix returns a list containing a matrix that is capable of caching
# its inverse in order to eliminate redundant and unnecessary computation.
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL   # cached value of inverse, if exists
  
  set <- function(y) {
    inv <<- NULL  # invalidate cached inverse
    x <<- y     # save matrix to this functions environment
  }
  
  get <- function() x  # return matrix
  
  setinv <- function(inverse) inv <<- inverse # cache the inverse
  
  getinv <- function() inv # return cached inverse, if any
  
  # return list of 4 functions
  list(set=set, get=get, setinv=setinv, getinv=getinv)
}


# cacheSolve will return the inverse of matrix contained within its
# first argument.  Upon first calculation, the 'solve' function is called to
# calculate the returned inverse and cache it; subsequent calls return the cached value.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getinv()
  
  if(!is.null(inv)) {
    # if cached inverse exists, return it
    message("getting cached data")
    return(inv)
  } else {
    # no cached inverse, 
    data <- x$get()          # extract the underlying data
    inv <- solve(data, ...)  # calculate its inverse
    x$set(inv)        # cache the inverse for re-use
    return(inv)                    	
  }
  
}