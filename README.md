# spark
## Sparklines

[Sparklines](http://en.wikipedia.org/wiki/Sparkline) are small in-line infographics
which sum up a data-series ([examples](http://commons.wikimedia.org/wiki/Category:Sparkline)).
They don't take up as much space as a full-blown graphic and so you can use them all over.
But classic [Edward Tufte](http://en.wikipedia.org/wiki/Edward_Tufte)-style
sparklines are hard to make - you either need to be an artist or know a library or
complicated tool.

Why not have simpler [Twitter](http://kottke.org/11/05/twitter-sparklines)-style sparklines,
drawn with some handy-dandy Unicode characters?

## Sparklines for your shell

See? Here's a graph of your productivity gains after using spark: ▁▂▃▅▇

### install

spark is a [shell script][bin], so drop it somewhere and make sure it's added
to your `$PATH`. It's helpful if you have a super-neat collection of dotfiles,
[like mine][dotfiles].

### usage

Just run `spark` and pass it a list of numbers (comma-delimited, spaces,
whatever you'd like). It's designed to be used in conjunction with other
scripts that can output in that format.

    > spark 0 30 55 80 33 150
    ▁▂▃▅▂▇

Invoke help with `spark -h`.

### cooler usage

There's a lot of stuff you can do.

Number of commits to the github/github Git repository, by author:

```sh
› git shortlog -s |
      cut -f1 |
      tr "\n" ',' |
      sed 's/ //g' |
      spark
  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▂▁▁▅▁▂▁▁▁▂▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁
```

Magnitude of earthquakes over 1.0 in the last 24 hours:

```sh
› curl http://earthquake.usgs.gov/earthquakes/catalogs/eqs1day-M1.txt --silent | 
  sed '1d' |
  cut -d, -f9 |
  tr "\n" ',' |
  sed 's/ //g' |
  spark
  ▅▆▂▃▂▂▂▅▂▂▅▇▂▂▂▃▆▆▆▅▃▂▂▂▁▂▂▆▁▃▂▂▂▂▃▂▆▂▂▂▁▂▂▃▂▂▃▂▂▃▂▂▁▂▂▅▂▂▆▆▅▃▆
```

Code visualization. The number of characters of `spark` itself, by line, ignoring empty lines:

```sh
› awk '{ print length($0) }' spark |
  grep -Ev 0 |
  tr "\n" ',' |
  spark
  ▁▁▁▁▅▁▇▁▁▅▁▁▁▁▁▂▂▁▃▃▁▁▃▁▃▁▂▁▁▂▂▅▂▃▂▃▃▁▆▃▃▃▁▇▁▁▂▂▂▇▅▁▂▂▁▇▁▃▁▇▁▂▁▇▁▁▆▂▁▇▁▂▁▁▂▅▁▂▁▆▇▇▂▁▂▁▁▁▂▂▁▅▁▂▁▁▃▁▃▁▁▁▃▂▂▂▁▁▅▂▁▁▁▁▂▂▁▁▁▂▂
```

Since it's just a shell script, you could pop it in your prompt, too:

```
ruby-1.8.7-p334 in spark/ on master with history: ▂▅▇▂
›
```

### wicked cool usage

Sounds like a wiki is a great place to collect all of your 
[wicked cool usage][wiki] for spark.

### todo

so hint hint hint if you're looking for something to hack on.

- Speedup. It's a little more sluggish than it should be since we're doing a
  few unnecessary loops.
- I'd like to constrain character widths with a `-w` switch.
- POSIX-compliant. I cheated with some bash functions, but I'd like to get down
  to basics and just do something ultimately portable for everyone.

## ▇▁ ⟦⟧ ▇▁

This is a [@holman][holman] joint.

[dotfiles]: https://github.com/holman/dotfiles 
[bin]:      https://github.com/holman/spark/blob/master/spark
[wiki]:     https://github.com/holman/spark/wiki/Wicked-Cool-Usage
[holman]:   https://twitter.com/holman
