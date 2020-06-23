devtools::install_github("davidallen02/pamngr")
library(magrittr)

dat <- pamngr::join_sheets(sheets = c("mpmiglca",
                                      "mpmiezca",
                                      "mpmieuca",
                                      "mpmiemca",
                                      "mpmijpca",
                                      "mpmiinca",
                                      "mpmicnca",
                                      "mpmiauca",
                                      "mpmigbca",
                                      "mpmiesca",
                                      "mpmiruca",
                                      "mpmiitca",
                                      "mpmiieca",
                                      "mpmideca",
                                      "mpmifrca",
                                      "mpmiusca",
                                      "mpmibrca")) %>% 
  dplyr::slice_max(dates, n = 15) %>%
  dplyr::arrange(dates)

dates <- dat %>% dplyr::select(dates) %>% dplyr::pull() %>% format("%b %Y")

tbl <- dat %>% 
  dplyr::select(-dates) %>% 
  t() %>% 
  data.frame() %>%
  set_colnames(dates) %>%
  tibble::rownames_to_column(var = "area") %>%
  gt::gt() %>%
  gt::tab_header(title = "Markit Composite PMIs") %>%
  gt::data_color(
    columns = dates,
    colors = scales::col_numeric(
      palette = as.character(
        paletteer::paletteer_c("ggthemes::Classic Red-White-Green", 20)
      ),
      domain = c(30, 80)
    )
  ) %>%
  gt::gtsave(file = "composite-pmi.png", vwidth = 1500)
  


