make_vects <- function(){
  x <- list()
  for(i in 1:1000) {
    x[[i]] <- seq(i, i + 10, by = 1)
  }
  return(x)
}