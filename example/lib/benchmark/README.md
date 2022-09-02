## Benchmark

This showing how the modifier layer affected widget tree depth.
In the benchmark, these show identical results.

- Basic benchmark:
    - `Modifier`: 1489 layers
    - `Widget`: 1489 layers
- Complex benchmark:
    - `Modifier`: 1401 layers
    - `Widget`: 1400 layers   

To run this test, you must self-exit when the `StackOverflow` error throws.