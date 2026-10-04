library(tidyverse)
install.packages("magick")
library(magick)
library(ggplot2)

# Define the colours using alphabets
pal <- c(
  K = "#000000",  # black outline
  B = "#5A3418",  # dark brown outline
  M = "#8B5A2B",  # inner ear brown
  W = "#FFFFFF",  # white fur
  C = "#EFE6E0",  # light grey-cream shading
  A = "#E5A982",  # orange spots
  S = "#D98A9A",  # pink
  R = "#C26B6B",  # rose
  E = "#2B2B45"   # eyes
)

# Create the matrix based on the image created (ref: https://in.pinterest.com/pin/7036943162631003/). 
# Colours and some other details have been custom
rows <- c(
  "...B......B",
  "..BOB....BOB",
  "..BSOB..BOOOB",
  "..BWMMBBOOSOB",
  "..BMTOOOOWWOB",
  "..BOOQTOOOWOB",
  "..BOTLTOOOOOB",
  ".BOELLLEOOOOOB",
  ".BOELLLEOOOOOOB..BB",
  "KTSSLLLLSSWTOB..BWWB",
  ".KLLTLTLLLLRK...BWLLB",
  "..KLLLLLLRROOK...BLQK",
  "...KKTLTTOOOMMK..BTLK",
  "...KLLLLTOOOOOK..BTTK",
  "...KTTLLLTOOOMMK.BTTK",
  "....BLLLLTOOOOOMKOQK",
  "....BMLLLLROOOOOMOOK",
  "....KTMLLLROOOOOMOK",
  "....KTKTLBOQOOOOMK",
  "....KTKTLBTWTQOK",
  ".....KKKKKKKKKK"
)


w    <- max(nchar(rows))
grid <- do.call(rbind, strsplit(formatC(rows, width = -w, flag = "-"), ""))

cat_df <- data.frame(
  x   = rep(seq_len(ncol(grid)), each = nrow(grid)),
  y   = rep(seq_len(nrow(grid)), times = ncol(grid)),
  hex = unname(pal[as.vector(grid)])   # "." and spaces become NA
)
cat_df <- na.omit(cat_df)
#Drops every row containing an NA. 
#Remove the empty pixels, so they are not drawn and the background shows through.

ggplot(cat_df, aes(x, y, fill = hex)) +
  geom_tile() +
  scale_fill_identity() +
  scale_y_reverse() +
  coord_equal() +
  theme_void()

