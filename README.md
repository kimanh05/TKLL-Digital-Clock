# Digital Clock (Verilog)

## 📌 Overview
This project implements a modular digital clock system using Verilog HDL. The system supports multiple operating modes including time display, time setting, stopwatch, and countdown timer.

## 🚀 Features
- 12-hour time display (HH:MM:SS)
- Multiple modes:
  - Time display
  - Time setting
  - Stopwatch (count up)
  - Countdown timer
- Real-time output using 7-segment display
- User interaction via switches and buttons

## 🏗️ Architecture
The design follows a modular hardware architecture:
- **clock_divider**: Generates 1Hz clock signal from system clock
- **time_counter**: Handles time increment/decrement logic
- **mode_controller**: Controls system modes and transitions
- **bcd_converter**: Converts binary values to BCD format
- **7-segment driver**: Displays output on LEDs

## 🎮 Control Logic
- Buttons and switches are used for:
  - Mode selection
  - Time adjustment
  - Start/stop control
- Ensures correct state transitions and synchronization

## 🧪 Verification
- Simulated using Xilinx Vivado
- Verified correct behavior for:
  - Time progression
  - Mode switching
  - Stopwatch and countdown functionality
- Output validated through waveform analysis

## 🛠️ Tools & Technologies
- Verilog HDL
- Xilinx Vivado

## 📂 Project Structure
**/src** # Verilog source files
**/testbench** # Simulation testbench
**/sim** # Waveform outputs

## 🎯 Learning Outcomes
- Designed modular RTL system
- Implemented FSM for control logic
- Built real-time digital system with multiple modes
- Practiced hardware simulation and verification
