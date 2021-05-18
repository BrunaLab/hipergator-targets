fit_bam <- function(dat) {
  bam(y ~ s(x0, bs = "cr") +
        s(x1, bs = "cr") +
        s(x2, bs = "cr", k = 12) +
        s(x3, bs = "cr"),
      data = dat)
}