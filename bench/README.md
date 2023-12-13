Here
- `bench1_a.v` is uses array
- `bench1_la.v` is uses LinkedArray
- `bench1_ll.v` is uses datatypes.DoublyLinkedList

```bash

> v -prod bench1_a.v
> v -prod bench1_la.v
> v -prod bench1_ll.v

> hyperfine.exe .\bench1_a.exe .\bench1_la.exe .\bench1_ll.exe
Benchmark 1: .\bench1_a.exe
  Time (mean ± σ):     288.0 ms ±  28.5 ms    [User: 62.5 ms, System: 140.3 ms]
  Range (min … max):   254.3 ms … 344.8 ms    10 runs

Benchmark 2: .\bench1_la.exe
  Time (mean ± σ):      50.2 ms ±   3.0 ms    [User: 24.3 ms, System: 2.0 ms]
  Range (min … max):    45.4 ms …  58.2 ms    47 runs

Benchmark 3: .\bench1_ll.exe
  Time (mean ± σ):      36.4 ms ±   2.4 ms    [User: 15.6 ms, System: 3.3 ms]
  Range (min … max):    33.4 ms …  49.6 ms    51 runs

Summary
  .\bench1_ll.exe ran
    1.38 ± 0.12 times faster than .\bench1_la.exe
    7.92 ± 0.94 times faster than .\bench1_a.exe
```
