# Stethoscope DSP: PSoC 5LP FIR filtering and output chain

CM-01B sensor -> Bessel anti-alias filter -> PSoC 5LP delta-sigma ADC (8 kHz) -> selectable FIR (heart / lung / bowel) -> 12-bit DAC -> Bessel reconstruction filter -> LM386 audio stage.

- `matlab/` filter design and Bode analysis of the analog + digital chain (8 kHz in the chain scripts). `least_squares.m` is an FDATool-exported least-squares `firls` band-pass; `prueba_filtros_digitales.m` compares windowed FIR designs against Parks-McClellan. `sallen_key_lp.m`, `zobelNetwork.m` and `lm386_*` model the analog stages. The final filters in the report use a Kaiser window (beta = 8).
- `simulink/` models of the anti-alias filter, the LM386 stage (custom Simscape block in `+lm386_lib`), the passive filter and a full-chain test, plus a SPICE netlist of the LM386 stage.
- `data/` coefficient tables exported for the PSoC Filter block (`Filter_data_*` arrays for heart, lung, bowel) and MATLAB workspaces used by the scripts.
- `enclosure/` 3D-printable capsule for the contact microphone (STL variants and source `.gx` files).

The PSoC Creator project of the final firmware was not part of the recovered sources, so it is not included; only the exported coefficient tables are available.
