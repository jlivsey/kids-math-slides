# This script create a power point presentation with a single math problem
# on each slide and the solution on the next slide.
# User can specify the problem type and the max value allowed to set the level.
# All problem are of the form x + y, x - y, or x * y

library(officer)

probType <- "*" # "+", "-", or "x"

max_X <- 15
max_Y <- 9
numProblems <- 25
textSize <- 90

# Initialize empty powerpoint document
doc <- read_pptx()

# Loop over all problem and create 2 slides for each problem
numSlides <- numProblems * 2
for (i in seq(1, numSlides, 2)) {
  
  # Draw random number for problem eg) x + y
  x <- sample(1:max_X, 1)
  limit <- min(maxY, x)
  y <- sample(1:limit, 1)
  
  # Find solution based on probType
  if (probType == "+") {
    z <- x + y
  } else if (probType == "-") {
    z <- x - y
  } else if (probType == "x") {
    z <- x * y
  } else{
    stop("probType specified is not valid")
  }
  
  # Setup slide text
  probString <- paste(x, probType, y, "=", sep = " ")
  solString  <- paste(x, probType, y, "=", z, sep = " ")
  
  # Format slide text for pretty printing
  probText <- fpar(ftext(probString, fp_text("black", textSize)))
  solText  <- fpar(ftext(solString, fp_text("black", textSize)))
  
  # Create slide with problem
  doc <- add_slide(doc)
  doc <- on_slide(doc, index = i)
  doc <- ph_with(doc, probText, ph_location_type("body"))
  
  # Create slide with solution
  doc <- add_slide(doc)
  doc <- on_slide(doc, index = i + 1)
  doc <- ph_with(doc, solText, ph_location_type("body"))
  
}

print(doc, "./problems.pptx")
