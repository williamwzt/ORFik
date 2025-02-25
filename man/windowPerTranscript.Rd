% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coverage_helpers.R
\name{windowPerTranscript}
\alias{windowPerTranscript}
\title{Get a binned coverage window per transcript}
\usage{
windowPerTranscript(
  txdb,
  reads,
  splitIn3 = TRUE,
  windowSize = 100,
  fraction = "1",
  weight = "score",
  BPPARAM = bpparam()
)
}
\arguments{
\item{txdb}{a TxDb object or a path to gtf/gff/db file.}

\item{reads}{GRanges or GAlignment of reads}

\item{splitIn3}{a logical(TRUE), split window in 3 (leader, cds, trailer)}

\item{windowSize}{an integer (100), size of windows (columns)}

\item{fraction}{a character (1), info on reads (which read length,
or which type (RNA seq)) (row names)}

\item{weight}{(default: 'score'), if defined a character name
of valid meta column in subject. GRanges("chr1", 1, "+", score = 5),
would mean score column tells that this alignment region was found 5 times.
ORFik .bedo files, contains a score column like this.
As do CAGEr CAGE files and many other package formats.
You can also assign a score column manually.}

\item{BPPARAM}{how many cores/threads to use? default: bpparam()}
}
\value{
a data.table with columns position, score
}
\description{
Per transcript (or other regions), bin them all to windowSize (default 100),
and make a data.table, rows are positions, useful for plotting with ORFik
and ggplot2.
}
\details{
NOTE: All ranges with smaller width than windowSize, will of course be
removed. What is the 100th position on a 1 width object ?
}
