#!/usr/bin/env roundup

describe "spark: Generates sparklines for a set of data."

spark="./spark"

# Handles colorization of the "expected" graph for testing color output
_colorize(){
  local ticks="${1}"
  local colors=(${2//,/ })
  local output=""
  for i in "${!colors[@]}";do
    output+="$(tput setaf ${colors[$i]})${ticks:$i:1}"
  done
  output+="$(tput sgr0)"
  echo "${output}"
}

it_shows_help_with_no_argv(){
  $spark | grep Usage
}

it_graphs_argv_data(){
  graph="$($spark 1,5,22,13,5)"

  test "$graph" = '▁▂█▅▂'
}

it_charts_pipe_data(){
  data="0,30,55,80,33,150"
  graph="$(echo $data | $spark)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_spaced_data(){
  data="0 30 55 80 33 150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_way_spaced_data(){
  data="0 30               55 80 33     150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_handles_decimals(){
  data="5.5,20"
  graph="$($spark $data)"

  test "$graph" = '▁█'
}

it_charts_100_lt_300(){
  data="1,2,3,4,100,5,10,20,50,300"
  graph="$($spark $data)"

  test "$graph" = '▁▁▁▁▃▁▁▁▂█'
}

it_charts_50_lt_100(){
  data="1,50,100"
  graph="$($spark $data)"

  test "$graph" = '▁▄█'
}

it_charts_4_lt_8(){
  data="2,4,8"
  graph="$($spark $data)"

  test "$graph" = '▁▃█'
}

it_charts_no_tier_0(){
  data="1,2,3,4,5"
  graph="$($spark $data)"

  test "$graph" = '▁▂▄▆█'
}

it_equalizes_at_midtier_on_same_data(){
  data="1,1,1,1"
  graph="$($spark $data)"

  test "$graph" = '▅▅▅▅'
}

it_outputs_test_name(){
  data="1,2,3,4"
  graph="$($spark -n name $data)"

  test "$graph" = '[name][1/4] ▁▃▅█'
}

it_charts_red_gt_2(){
  data="1,2,3,4,5"
  graph="$(./spark -c red -t 3 $data)"
  expected="$(_colorize '▁▂▄▆█' '7,7,1,1,1')"

  test "$graph" = "$expected"
}

it_charts_red_lt_4(){
  data="1,2,3,4,5"
  graph="$(./spark -c red -t 3 -i $data)"
  expected="$(_colorize '▁▂▄▆█' '1,1,1,7,7')"

  test "$graph" = "$expected"
}

it_charts_custom_ansi_color_212_gt_2(){
  data="1,2,3,4,5"
  graph="$(./spark -c 212 -t 3 $data)"
  expected="$(_colorize '▁▂▄▆█' '7,7,212,212,212')"

  test "$graph" = "$expected"
}

it_charts_pride(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p pride $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '205,1,214,3,2,6,4,92')"

  test "$graph" = "$expected"
}

it_charts_earth(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p earth $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '12,94,100,34,22,240,244,246')"

  test "$graph" = "$expected"
}

it_charts_pipe_data_with_opts(){
  data="1,2,3,4,5,6,7,8"
  graph="$(echo "${data}" | ./spark -n "Piped Data" -c red -t 5 -p fire)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '1,1,1,33,1,1,1,1')"

}

it_charts_ice(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p ice $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '20,21,27,33,39,14,255,15')"

  test "$graph" = "$expected"
}

it_charts_fire(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p fire $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '228,227,226,220,214,208,202,196')"

  test "$graph" = "$expected"
}

it_charts_smoke(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p smoke $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '254,249,247,244,242,240,238,0')"

  test "$graph" = "$expected"
}

it_charts_custom_ansi_palette_colors(){
  data="1,2,3,4,5,6,7,8"
  graph="$(./spark -p 1,2,3,4,5,6,7,8 $data)"
  expected="$(_colorize '▁▂▃▄▅▆▇█' '1,2,3,4,5,6,7,8')"

  test "$graph" = "$expected"
}

# No lolcat test as that is an effort in frustration
