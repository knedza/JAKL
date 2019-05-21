## MAPS project 
## May 2019
## JAKL team, University of Plymouth
## CC - BY 3.0

library(tidyverse)

# get data from our repository
full <- read.csv("https://raw.githubusercontent.com/knedza/JAKL/master/maps-synthetic-data-v1.1.csv")

variable.names(full)

# keep the variables we identified as useful
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

attach(interesting)

# what is the granularity of our main vars
table(comp_week,comp_wend)
table(comp_week)
table(comp_wend)

table(dep_score)
table(dep_thoughts)
table(has_dep_diag)
table(prim_diag)
table(secd_diag)

# at the end, save the interesting data locally so it can be uploaded
# write.csv(interesting, 'jakl.csv')

