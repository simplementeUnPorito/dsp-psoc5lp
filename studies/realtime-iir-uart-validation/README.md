# Study: real-time IIR filtering in C on the PSoC 5LP with MATLAB validation

**Objective.** Run a direct-form IIR filter in firmware on the PSoC 5LP and validate it against the unfiltered capture in MATLAB.

**Method.**
- ADC SAR acquires 512 samples into RAM through DMA; samples are converted to volts (float).
- `aplicar_filtro()` applies a difference equation with 13 numerator and 13 denominator coefficients (12th order); alternative FIR/IIR coefficient sets are kept as comments in `main.c`.
- A UART command interface at 115200 baud (`I` acquire, `X` filter, `P` send) lets MATLAB (`matlab/capture_and_compare.m`, fs = 5 kHz) read the raw and filtered vectors and plot them together.

**Contents.** `psoc/` project definition (`.cyprj`, `.cydwr`) and `main.c`; `matlab/` capture script. The TopDesign schematic file was not present in the recovered sources, and the serial-plot helper library is third-party and not included.

No result figure was recovered for this study.

**Authors.** Elías David Álvarez Martínez and Tania Patricia Romero Centurión, 2024; advisor: Lic. Federico Daniel Morán Fretes.
