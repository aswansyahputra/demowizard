FROM rocker/r2u:22.04
WORKDIR /code
RUN install2.r --error --skipinstalled --ncpus -1 shiny ggplot2 bslib
RUN installGithub.r rstudio/httpuv rstudio/gridlayout
COPY . .
EXPOSE 7680
CMD R -e 'shiny::runApp(host = "0.0.0.0", port = 7860)'
