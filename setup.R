library(tinyhelpers) # [github::aswansyahputra/tinyhelpers] v0.0.0.9000

# Generate configuration file for Shiny app deployment at Hugging Face Space
generate_hfspace_shiny_dockerfile(
  cran_pkgs_name = c(
    "shiny",
    "ggplot2",
    "bslib"
  ),
  gh_pkgs_repo = "rstudio/gridlayout"
)


# Generate static webpage containing aforementioned app
generate_hfspace_shiny_iframe(
  username = "aswansyahputra",
  space = "demowizard"
)
