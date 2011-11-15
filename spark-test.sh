#!/usr/bin/env roundup

describe "spark: Generates sparklines for a set of data."

spark="./spark"

it_graphs_argv_data() {
  graph="$($spark 1,5,22,13,5)"

  test $graph = '▁▂▇▅▂'
}

it_charts_pipe_data() {
  data="0,30,55,80,33,150"
  graph="$(echo $data | $spark)"

  test $graph = '▁▂▃▄▂▇'
}
