#!/usr/bin/env roundup

describe "spark: Generates sparklines for a set of data."

spark="./spark"

it_shows_help_with_no_argv() {
  $spark | grep USAGE
}

it_graphs_argv_data() {
  graph="$($spark 1,5,22,13,5)"

  test $graph = '▁▂█▅▂'
}

it_charts_pipe_data() {
  data="0,30,55,80,33,150"
  graph="$(echo $data | $spark)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_spaced_data() {
  data="0 30 55 80 33 150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_charts_way_spaced_data() {
  data="0 30               55 80 33     150"
  graph="$($spark $data)"

  test $graph = '▁▂▃▄▂█'
}

it_handles_decimals() {
  data="5.5,20"
  graph="$($spark $data)"

  test $graph = '▁█'
}

it_charts_100_lt_300() {
  data="1,2,3,4,100,5,10,20,50,300"
  graph="$($spark $data)"

  test $graph = '▁▁▁▁▃▁▁▁▂█'
}

it_charts_50_lt_100() {
  data="1,50,100"
  graph="$($spark $data)"

  test $graph = '▁▄█'
}

it_charts_4_lt_8() {
  data="2,4,8"
  graph="$($spark $data)"

  test $graph = '▁▃█'
}

it_charts_no_tier_0() {
  data="1,2,3,4,5"
  graph="$($spark $data)"

  test $graph = '▁▂▄▆█'
}

it_equalizes_at_midtier_on_same_data() {
  data="1,1,1,1"
  graph="$($spark $data)"

  test $graph = '▅▅▅▅'
}
