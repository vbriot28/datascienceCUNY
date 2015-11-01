# R Bridge Session - Week# 1 Assignment - Valerie Briot

# Question 1:
# Write a loop that calculate 12 factorial
i <- 12
factorial.result <- 1
while (i>0)
{
+     factorial.result <- factorial.result * i
+     i <- i-1
 }
# Show result of calculation
 factorial.result
 
# Show result using build in R function for factorial
 factorial(12)

# Question# 2: 
# Show how to create a numeric vector that contains the sequence from 20 to 50 by 5
nvect <- 20:50
nvect

# Use sequence to take every 5 elements of vector nvect
nvect2 <- nvect[seq(1, length(nvect), 5)]

# show result
nvect2

# Question# 3:
# Show how to take a trio of input numbers a, b, and c and implement the quadratic equation

quadratic.equation <- function(v,x)
+ {
+     return(v[1]*x^2 + v[2]*x + v[3])
 }
# assign v to be of the form v <- c(a,b,c), x is variable in equation
x <- 2
v <- c(2,3,5)
quadratic.equation(v,x)

# Finding roots of Quadratics equations
# assign v to be of the form v <- c(a,b,c)
quadratic.roots <- function(v)
{
    if(!any(v==0))
    {
        vdet <- v[2]^2 -4*v[1]*v[3]
        vrootr <- -v[2]/2*v[1]
        vrooti <- sqrt(abs(vdet))/2*v[1]
            if( vdet >= 0)
            {
                print(cat("roots are: ", vrootr + vrooti, "and ", vrootr - vrooti))
            }else
              {
                  print(cat("roots are: ", vrootr, "+", vrooti,"i and ", vrootr, "-", vrooti, "i"))
              }
    }   
}

# find roots for v1 <- c(1,-4,3)
v1 <- c(1,-4,3)
quadratic.roots(v)

# Answer was: "roots are:  3 and  1NULL"
# Note: I do not understand the NULL at the end, is it a default return?

# Alternative: use polyroot function in R (need to reverse vector)
v2 <- rev(v1)
polyroot(v2)

# Answer was: "1+0i 3+0i"



