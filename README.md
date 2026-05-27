# UART
# UART Communication System in SystemVerilog

## Overview

This project is a complete **UART (Universal Asynchronous Receiver Transmitter)** implementation written in **SystemVerilog**.
It includes:

* UART Transmitter (`Uart_tx.sv`)
* UART Receiver (`Uart_rx.sv`)
* Top UART Module (`UART.sv`)
* Testbench (`Uart_tb.sv`)
* Additional experimental/test module (`trial.sv`)

The project was developed as part of my digital design and VLSI learning journey focused on RTL design, communication protocols, and hardware verification.

---

# Features

* Fully written in **SystemVerilog**
* Modular RTL design
* UART TX and RX implementation
* Testbench for simulation and verification
* Designed for FPGA/ASIC learning
* Clean and scalable architecture
* Beginner-friendly communication protocol project

---

# File Structure

```bash
├── UART.sv          # Top-level UART module
├── Uart_tx.sv       # UART transmitter
├── Uart_rx.sv       # UART receiver
├── Uart_tb.sv       # Testbench for simulation
├── trial.sv         # Experimental/testing module
└── README.md
```

---

# UART Basics

UART is a serial communication protocol used for transmitting and receiving data between devices.

### Communication Format

```text
| Start Bit | Data Bits | Stop Bit |
```

Typical UART configuration:

* 8 Data Bits
* No Parity
* 1 Stop Bit

---

# Simulation

This project can be simulated using:

* ModelSim
* QuestaSim
* Vivado Simulator
* Icarus Verilog
* Verilator

---

# Example Compilation

## Using Icarus Verilog

```bash
iverilog -g2012 UART.sv Uart_tx.sv Uart_rx.sv Uart_tb.sv -o uart_sim
vvp uart_sim
```

---

# Waveform Viewing

If waveform dumping is enabled:

```bash
gtkwave dump.vcd
```

---

# Learning Outcomes

Through this project I learned:

* RTL Design using SystemVerilog
* Finite State Machines (FSMs)
* Serial Communication Protocols
* Timing and Synchronization
* Testbench Development
* Digital Design Debugging
* Hardware Verification Basics

---

# Future Improvements

Planned upgrades for the project:

* Configurable baud rate generator
* Parity bit support
* FIFO buffering
* Error detection
* AXI/APB interface integration
* FPGA implementation

---

# About Me

I am an Electronics and VLSI student passionate about:

* Computer Architecture
* Digital Design
* RTL Development
* FPGA Design
* Processor Design
* Low-Level Hardware Systems

Currently building larger hardware projects including custom CPUs and digital systems.

---

# Connect With Me

## GitHub

[https://github.com/Mage-imm](https://github.com/Mage-imm)

## LinkedIn

[https://linkedin.com/in/manav-shah-0630863ab](https://linkedin.com/in/manav-shah-0630863ab)

---

# License

This project is open-source and available under the MIT License.
