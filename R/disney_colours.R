
# Palette Colours from :
#   http://elijahmeeks.com/#content/blog/2015_08_17_palettes
# Palette made ffg blog post:
#   https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

#' The list of disney colours
disney_colours <- c(
  `cind1`       = "#96abb1",
  `cind2`       = "#313746",
  `cind3`       = "#b0909d",
  `cind4`       = "#687a97",
  `cind5`       = "#292014",
  `monet1`      = "#08221c",
  `monet2`      = "#113719",
  `monet3`      = "#36611b",
  `monet4`      = "#72972f",
  `monet5`      = "#a4b77d",
  `monet6`      = "#cdc597",
  `smallworld1` = "#00a2ce",
  `smallworld2` = "#b3331d",
  `smallworld3` = "#b6a756",
  `smallworld4` = "#122753",
  `smallworld5` = "#b86117",
  `smallworld6` = "#4d430c",
  `alice1`      = "#827abf",
  `alice2`      = "#f62150",
  `alice3`      = "#6f89b6",
  `alice4`      = "#f5e0b7",
  `alice5`      = "#5b1e37",
  `alice6`      = "#b9e3c5",
  `pan1`        = "#27552d",
  `pan2`        = "#e46538",
  `pan3`        = "#96bb77",
  `pan4`        = "#e5e36e",
  `pan5`        = "#e6a19f",
  `pan6`        = "#159eb7",
  `yourage1`    = "#3b4274",
  `yourage2`    = "#d2130a",
  `yourage3`    = "#c8a88a",
  `yourage4`    = "#857d7b",
  `yourage5`    = "#592e2a",
  `yourage6`    = "#e39587"
)

#' Function to extract colours as hex codes
#'
#' @param ... Character names of disney_colours
#'
disney_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols)) {
    return(disney_colours)
  }

  disney_colours[cols]
}

#' Function to create palettes
disney_palettes <- list(
  `main` = disney_cols(),

  `cinderella` = disney_cols(
    "cind1", "cind2", "cind3",
    "cind4", "cind5"
  ),

  `monet` = disney_cols(
    "monet1", "monet2", "monet3",
    "monet4", "monet5", "monet6"
  ),

  `small_world` = disney_cols(
    "smallworld1", "smallworld2",
    "smallworld3", "smallworld4",
    "smallworld5", "smallworld6"
  ),

  `alice` = disney_cols(
    "alice1", "alice2",
    "alice3", "alice4",
    "alice5", "alice6"
  ),

  `pan` = disney_cols(
    "pan1", "pan2",
    "pan3", "pan4",
    "pan5", "pan6"
  ),

  `when_i_was_your_age` = disney_cols(
    "yourage1", "yourage2",
    "yourage3", "yourage4",
    "yourage5", "yourage6"
  )
)

#' Return function to interpolate a disney colour palette
#'
#' @param palette Character name of palette in disney_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
disney_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- disney_palettes[[palette]]

  if (is.null(pal)) {
    stop(str_glue("Cannot find palette! Palette names are: cinderella, monet, small_world, alice,
                  pan, when_i_was_your_age, main."))
  }

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' Colour scale constructor for some disney-ish colours
#'
#' This is the default colour scale for categorical variables for the disney-like palette.
#' It does not generate colour-blind safe palettes.
#' These are the palettes to choose from:
#' \itemize{
#'    \item \code{cinderella}
#'    \item \code{monet}
#'    \item \code{small_world}
#'    \item \code{alice}
#'    \item \code{pan}
#'    \item \code{when_i_was_your_age}
#'    \item \code{main}
#' } \cr
#' Palette Colours inspired by: \cr
#'     http://elijahmeeks.com/#content/blog/2015_08_17_palettes \cr \cr
#' Palette made ffg blog post: \cr
#'     https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2 \cr
#'
#' @param palette Character name of palette in disney_palettes
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @return Colour scale of disney-like palette
#'
#' @examples
#' # Colour using the small_world palette
#' ggplot(mtcars, aes(hp, mpg, colour = cyl)) +
#'   geom_point(size = 4, alpha = .8) +
#'   scale_colour_disney(
#'     discrete = FALSE,
#'     palette = "small_world",
#'     guide = "none"
#'   ) +
#'   facet_wrap(~cyl) +
#'   theme_tq()
#'
#' # Colour using the `alice` palette, and where cyl is discrete
#' ggplot(mtcars, aes(hp, mpg, colour = as.factor(cyl))) +
#'   geom_point(size = 4, alpha = .8) +
#'   scale_colour_disney(
#'     discrete = TRUE,
#'     palette = "alice",
#'     guide = "none"
#'   ) +
#'   facet_wrap(~cyl) +
#'   theme_tq()
#' @export
scale_colour_disney <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- disney_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("disney_", palette), palette = pal, ...)
  } else {
    scale_colour_gradientn(colours = pal(256), ...)
  }
}

#' Color scale constructor for some disney-ish colors
#'
#' This is the default colour scale for categorical variables for the disney-like palette.
#' It does not generate colour-blind safe palettes.
#' These are the palettes to choose from:
#' \itemize{
#'    \item \code{cinderella}
#'    \item \code{monet}
#'    \item \code{small_world}
#'    \item \code{alice}
#'    \item \code{pan}
#'    \item \code{when_i_was_your_age}
#'    \item \code{main}
#' } \cr
#' Palette Colours inspired by: \cr
#'     http://elijahmeeks.com/#content/blog/2015_08_17_palettes \cr \cr
#' Palette made ffg blog post: \cr
#'     https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2 \cr
#'
#' @param palette Character name of palette in disney_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @return Colour scale of disney-like palette
#'
#' @examples
#' # Color by discrete variable using default palette
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
#'   geom_point(size = 4) +
#'   scale_color_disney() +
#'   theme_tq()
#' @export
scale_color_disney <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- disney_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("disney_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for some disney-ish colours
#'
#' This is the default fill scale for the disney-like palette.
#' It does not generate colour-blind safe palettes.
#' These are the palettes to choose from:
#' \itemize{
#'    \item \code{cinderella}
#'    \item \code{monet}
#'    \item \code{small_world}
#'    \item \code{alice}
#'    \item \code{pan}
#'    \item \code{when_i_was_your_age}
#'    \item \code{main}
#' } \cr
#' Palette Colours inspired by: \cr
#'     http://elijahmeeks.com/#content/blog/2015_08_17_palettes \cr \cr
#' Palette made ffg blog post: \cr
#'     https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2 \cr
#'
#' @param palette Character name of palette in disney_palettes
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @return Fill scale of disney-like palette
#'
#' @examples
#' # Fill by discrete variable with different palette + remove legend (guide)
#' ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
#'   geom_bar() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#'   scale_fill_disney(palette = "main", guide = "none")
#' @export
scale_fill_disney <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- disney_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("disney_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
