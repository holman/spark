# spark
### sparklines for your shell

See? Here's a graph of your productivity gains after using spark: ▁▂▃▅▇

## install

spark is a [shell script][bin], so drop it somewhere and make sure it's added
to your `$PATH`. It's helpful if you have a super-neat collection of dotfiles,
[like mine][dotfiles].

## usage

Just run `spark` and pass it a comma-delimited list of numbers. It's designed
to be used in conjunction with other scripts that can output in that format.

    spark 0,30,55,80,33,150
    ▁▂▃▅▂▇

Invoke help with `spark -h`.

## cooler usage

There's a lot of stuff you can do.

Number of commits to the github/github Git repository, by author:

```bash
› git shortlog -s |
      cut -f1 |
      tr "\n" ',' |
      sed 's/ //g' |
      spark
  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▂▁▁▅▁▂▁▁▁▂▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁
```

Magnitude of earthquakes over 1.0 in the last 24 hours:

```bash
› curl http://earthquake.usgs.gov/earthquakes/catalogs/eqs1day-M1.txt --silent | 
  sed '1d' |
  cut -d, -f9 |
  tr "\n" ',' |
  sed 's/ //g' |
  spark
  ▅▆▂▃▂▂▂▅▂▂▅▇▂▂▂▃▆▆▆▅▃▂▂▂▁▂▂▆▁▃▂▂▂▂▃▂▆▂▂▂▁▂▂▃▂▂▃▂▂▃▂▂▁▂▂▅▂▂▆▆▅▃▆
```

Code visualization. The number of characters of `spark` itself, by line, ignoring empty lines:

```bash
› awk '{ print length($0) }' spark |
  grep -Ev 0 |
  tr "\n" ',' |
  spark
  ▁▁▁▁▅▁▇▁▁▅▁▁▁▁▁▂▂▁▃▃▁▁▃▁▃▁▂▁▁▂▂▅▂▃▂▃▃▁▆▃▃▃▁▇▁▁▂▂▂▇▅▁▂▂▁▇▁▃▁▇▁▂▁▇▁▁▆▂▁▇▁▂▁▁▂▅▁▂▁▆▇▇▂▁▂▁▁▁▂▂▁▅▁▂▁▁▃▁▃▁▁▁▃▂▂▂▁▁▅▂▁▁▁▁▂▂▁▁▁▂▂
```

User login time since last reboot

```bash
  # get users for a specific group
  # needs to be improved 
  users=$(getent group uquota | cut -d ':' -f 4 | tr ',' '\n')
  gr=""
  for i in $users
    do
    gr="$gr$(last | sort | grep $i | cut -c 67-71 | tr ":" " " | awk 'BEGIN {sum=0;  } {sum += $1*60+$2; } END { print sum}'),"
  done
  spark $gr
```

Since it's just a shell script, you could pop it in your prompt, too:

```
ruby-1.8.7-p334 in spark/ on master with history: ▂▅▇▂
›
```

## wicked cool usage

Sounds like a wiki is a great place to collect all of your 
[wicked cool usage][wiki] for spark.

## todo

so hint hint hint if you're looking for something to hack on.

- Speedup. It's a little more sluggish than it should be since we're doing a
  few unnecessary loops.
- I'd like to constrain character widths with a `-w` switch.
- POSIX-compliant. I cheated with some bash functions, but I'd like to get down
  to basics and just do something ultimately portable for everyone.
- Add tests with Blake's [roundup][roundup].

## ▇▁ ⟦⟧ ▇▁

This is a [@holman][holman] joint.

[dotfiles]: https://github.com/holman/dotfiles 
[bin]:      https://github.com/holman/spark/blob/master/spark
[wiki]:     https://github.com/holman/spark/wiki/Wicked-Cool-Usage
[roundup]:  https://github.com/bmizerany/roundup
[holman]:   https://twitter.com/holman
