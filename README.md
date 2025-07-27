# Stopwatch Timer in Verilog

This project implements a **simple stopwatch timer** using Verilog HDL. The stopwatch supports start/pause toggling, clearing, and automatic counting of minutes and seconds up to 99:59.

## 🔧 Features

- Displays time as MM:SS (BCD format)
- Controlled by:
  - `start_stop`: toggles start/pause
  - `clr`: clears the time
  - `reset`: async reset for full reset
- Suitable for simulation and FPGA prototyping
- Testbench covers full behavior: start, pause, clear, reset, resume

## 🧪 Files
src/
└── stopwatch.v # Stopwatch logic module

tb/
└── tb_stopwatch.v # Full-featured testbench with waveform support
## 🛠️ Simulation Instructions

1. Use Vivado, ModelSim, or Icarus Verilog.
2. Load `stopwatch.v` and `tb_stopwatch.v`.
3. Run simulation and observe waveform or console logs.
4. Adjust `TICK_COUNT` in `stopwatch.v` to match clock frequency or simulation scale.

## ✅ Sample Output
=== Stopwatch Full Test Start ===
Reset complete
MM:SS -> 00:00
Stopwatch started
MM:SS -> 00:07
Stopwatch paused
MM:SS -> 00:07
Stopwatch resumed
MM:SS -> 02:07
Stopwatch cleared
MM:SS -> 00:00
Stopwatch reset
MM:SS -> 00:00
=== Stopwatch Test Complete ===
