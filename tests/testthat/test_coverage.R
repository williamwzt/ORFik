context("Coverage Helpers")
library(ORFik)

ORF1 <- GRanges("1", IRanges(21, 49), "+")
ORF2 <- GRanges("1", IRanges(30, 49), "+")
grl <- GRangesList("tx1_1" = ORF1, "tx1_2" = ORF2)
tx <- resize(resize(grl[1], width = 50), width = 70, fix = "end")
names(tx) <- "tx1"
footprintsGood <- GRanges("1", IRanges(seq.int(21, 49, 3), width = 1), "+")
footprintsGood$size <- 29
footprintsBad <- GRanges()

test_that("coverageScorings works as intended", {
  # no reads hit
  coverage <- coveragePerTiling(grl, footprintsGood, is.sorted = TRUE,
                                as.data.table = TRUE)
  expect_is(coverage, "data.table")

  # fracPos
  dt <- coverageScorings(coverage, "fracPos")
  expect_equal(sum(dt$score), length(grl))

  # Sum
  dt <- coverageScorings(coverage, "sum")
  expect_equal(sum(dt$score), sum(countOverlaps(grl, footprintsGood)))

  # log2 sum
  dt <- coverageScorings(coverage, "log2sum")
  expect_equal(sum(dt$score[is.finite(dt$score)]),
               7)

  # Mean
  dt <- coverageScorings(coverage, "mean")
  expect_equal(sum(dt$score), 10)

  # Zscore
  dt <- coverageScorings(coverage, "zscore")
  expect_equal(round(sum(dt$score), 2), -0.11)

  # Transcript Normalized
  dt <- coverageScorings(coverage, "transcriptNormalized")
  expect_equal(round(sum(dt$score), 2), length(grl))

})

test_that("windowPerReadLength works as intended", {
  # per group coverage
  grltest <- windowPerReadLength(grl, tx, footprintsGood,
                                 scoring = "fracPos")
  expect_is(grltest, "data.table")
  expect_equal(nrow(grltest), 52)
  expect_equal(grltest$fraction[1], 29)
  expect_equal(c(min(grltest$position), max(grltest$position)), c(-5, 20))
  expect_equal(round(grltest$score[6], 3) , 0.143)
  # meta coverage
  grltest <- windowPerReadLength(grl, tx, footprintsGood)
  expect_is(grltest, "data.table")
  expect_equal(nrow(grltest), 26)
  expect_equal(round(grltest$score[6], 3) , 0.268)

  # - strand
  strand(grl) <- "-"
  strand(tx) <- "-"
  strand(footprintsGood) <- "-"
  grltest <- windowPerReadLength(grl, tx, footprintsGood,
                                 scoring = "fracPos")

})

test_that("windowPerReadLength works as intended strange cases", {
  # no reads hit
  grltest <- windowPerReadLength(grl, tx, footprintsBad,
                                 scoring = "fracPos")
  expect_is(grltest, "data.table")
  expect_equal(nrow(grltest), 0)
  # no grl
  grltest <- windowPerReadLength(GRangesList(), tx, footprintsGood)
  expect_is(grltest, "data.table")
  expect_equal(nrow(grltest), 0)
})

test_that("regionPerReadLength works as intended", {
  # Per frame
  grltest <- regionPerReadLength(grl, footprintsGood, scoring = "frameSumPerLG")
  expect_is(grltest, "data.table")
  expect_equal(nrow(grltest), 6)
  expect_equal(grltest$score[1], 10)
  expect_equal(grltest$score[4], 7)
})
