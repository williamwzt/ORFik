% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/experiment.R
\name{create.experiment}
\alias{create.experiment}
\title{Create a ORFik \code{\link{experiment}}}
\usage{
create.experiment(
  dir,
  exper,
  saveDir = "~/Bio_data/ORFik_experiments/",
  txdb = "",
  fa = "",
  organism = "",
  pairedEndBam = FALSE,
  viewTemplate = TRUE,
  types = c("bam", "bed", "wig"),
  libtype = "auto",
  stage = "auto",
  rep = "auto",
  condition = "auto",
  fraction = "auto"
)
}
\arguments{
\item{dir}{Which directory / directories to create experiment from}

\item{exper}{Short name of experiment, max 5 characters long}

\item{saveDir}{Directory to save experiment csv file, default:
"~/Bio_data/ORFik_experiments/" \cr Set to NULL if you don't want to save
it to disc.}

\item{txdb}{A path to gff/gtf file used for libraries}

\item{fa}{A path to fasta genome/sequences used for libraries, remember the
file must have a fasta index too.}

\item{organism}{character, default: "" (no organism set), scientific name
of organism. Homo sapiens, Danio rerio, Rattus norvegicus etc.
If you have a SRA metadata csv file, you can set this argument to
study$ScientificName[1], where study is the SRA metadata for all files
that was aligned.}

\item{pairedEndBam}{logical FALSE, else TRUE, or a logical list of
TRUE/FALSE per library you see will be included (run first without and check
what order the files will come in) 1 paired end file, then two single will
be c(T, F, F). If you have a SRA metadata csv file, you can set this argument to
study$LibraryLayout == "PAIRED", where study is the SRA metadata for all files
that was aligned.}

\item{viewTemplate}{run View() on template when finished, default (TRUE)}

\item{types}{Default (bam, bed, wig), which types of libraries to allow}

\item{libtype}{character, default "auto". Library types,
must be length 1 or equal length of number of libraries.
"auto" means ORFik will try to guess from file name.}

\item{stage}{character, default "auto". Developmental stage, tissue or
cell line, must be length 1 or equal length of number of libraries.
"auto" means ORFik will try to guess from file name.}

\item{rep}{character, default "auto". Replicate numbering,
must be length 1 or equal length of number of libraries.
"auto" means ORFik will try to guess from file name.}

\item{condition}{character, default "auto". Library conditions,
must be length 1 or equal length of number of libraries.
"auto" means ORFik will try to guess from file name.}

\item{fraction}{character, default "auto". Fractionation of library,
must be length 1 or equal length of number of libraries.
"auto" means ORFik will try to guess from file name.}
}
\value{
a data.frame, NOTE: this is not a ORFik experiment,
 only a template for it!
}
\description{
Create information on runs / samples from an experiment as a single R object.
By using files in a folder / folders. It will try to make an experiment table
with information per sample. There will be several columns you can fill in,
most of there it will try to auto-detect. Like if it is RNA-seq or Ribo-seq,
Wild type or mutant etc.
You will have to fill in the details that were not auto detected.
Easiest way to fill in the blanks are in a csv editor like libre Office
or excel. Remember that each row (sample) must have a unique combination
of values.
An extra column called "reverse" is made if there are paired data,
like +/- strand wig files.
}
\examples{
# 1. Pick directory
dir <- system.file("extdata", "", package = "ORFik")
# 2. Pick an experiment name
exper <- "ORFik"
# 3. Pick .gff/.gtf location
txdb <- system.file("extdata", "annotations.gtf", package = "ORFik")
# 4. Pick fasta genome of organism
fa <- system.file("extdata", "genome.fasta", package = "ORFik")
# 5. Set organism (optional)
org <- "Homo sapiens"

# Create temple not saved on disc yet:
template <- create.experiment(dir = dir, exper, txdb = txdb,
                              saveDir = NULL,
                              fa = fa, organism = org,
                              viewTemplate = FALSE)
## Now fix non-unique rows: either is libre office, microsoft excel, or in R
template$X5[6] <- "heart"
# read experiment (if you set correctly)
df <- read.experiment(template)
# Save with: save.experiment(df, file = "path/to/save/experiment.csv")

## Create and save experiment directly:
## Default location: "~/Bio_data/ORFik_experiments/"
#template <- create.experiment(dir = dir, exper, txdb = txdb,
#                               fa = fa, organism = org,
#                               viewTemplate = FALSE)
## Custom location
#template <- create.experiment(dir = dir, exper, txdb = txdb,
#                               saveDir = "~/MY/CUSTOME/LOCATION",
#                               fa = fa, organism = org,
#                               viewTemplate = FALSE)
}
\seealso{
Other ORFik_experiment: 
\code{\link{ORFik.template.experiment}()},
\code{\link{bamVarName}()},
\code{\link{experiment-class}},
\code{\link{filepath}()},
\code{\link{libraryTypes}()},
\code{\link{organism.df}()},
\code{\link{outputLibs}()},
\code{\link{read.experiment}()},
\code{\link{save.experiment}()},
\code{\link{validateExperiments}()}
}
\concept{ORFik_experiment}
