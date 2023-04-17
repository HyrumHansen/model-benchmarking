n_obs <- 2000

gen_nonlinear <- function(x){

  lv1 <- x[1]*x[2]*sin(x[1] + x[2]) - x[3]^3/x[2] + 5*x[4]
  lv2 <- x[1]+x[4] - x[1]*x[2]

  if(x[1] > 50){
    lv2 = lv2 * sin(x[3] + x[4])
  }

  if(x[2] > 75){
    lv1 = lv1 * 4
  }

  result <- lv1 + lv2

  if(x[1]>85){
    result <- 10*sum(x) + 50*tan(sum(x))
  }

  return(result)
}

x <- seq(0.01, 100, length.out = n_obs)

x1 <- lapply(x, function(x) x + runif(1, -0.5, 0.5))
x2 <- lapply(x, function(x) x + runif(1, -1, 1))
x3 <- lapply(x, function(x) x + runif(1, -2, 2))
x4 <- lapply(x, function(x) x + runif(1, -5, 5))

x_vec <- cbind(x1, x2, x3, x4)
y <- rep(0, n_obs)

for(i in 1:n_obs){
    y[i] <- gen_nonlinear(unlist(x_vec[i,])) + runif(1, -500, 500)
}

true_x <- seq(0.01, 100, length.out = n_obs)
true_x <- cbind(true_x, true_x, true_x, true_x)
true_y <- rep(0, n_obs)

for(i in 1:n_obs){
  y[i] <- gen_nonlinear(unlist(true_x[i,]))
}

plot(true_x[,1], y, type="l", col="red", lwd=4,
     main = "True Underlying MEGA-Nonlinear Function", xlab = "x value")

