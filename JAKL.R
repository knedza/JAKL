library(tidyverse)


full <- read.csv("https://raw.githubusercontent.com/knedza/JAKL/master/maps-synthetic-data-v1.1.csv")

variable.names(full)

interesting <- full %>% select(
  'sex',
  'comp_bed_9',
  'comp_house',
  'comp_int_bed_16',
  'comp_noint_bed_16',
  'comp_week',
  'comp_wend',
  'comp_games',
  'dep_band_10',
  'dep_band_13',
  'dep_band_07',
  'dep_band_15',
  'dep_score',
  'dep_thoughts',
  'has_dep_diag',
  'prim_diag',
  'secd_diag',
  'creat_14',
  'phone_14_week',
  'phone_14_wend',
  'alon_week',
  'alon_wend',
  'draw_week',
  'draw_wend',
  'musi_week',
  'musi_wend',
  'out_sum_week',
  'out_sum_wend',
  'out_win_week',
  'out_win_wend',
  'play_week',
  'play_wend',
  'read_week',
  'read_wend',
  'talk_mob_week',
  'talk_mob_wend',
  'talk_phon_week',
  'talk_phon_wend',
  'text_wend',
  'tran_week',
  'tran_wend',
  'tv_week',
  'tv_wend',
  'work_week',
  'work_wend',
  'mat_dep',
  'text_week'
)

write.csv(interesting, 'jakl.csv')
