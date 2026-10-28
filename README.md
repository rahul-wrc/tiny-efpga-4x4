# ⚡ Tiny Embedded FPGA (eFPGA) — 4×4 Configurable Logic Fabric

<p align="center">
  <strong>A Reconfigurable Digital Hardware Fabric Designed in Verilog HDL</strong>
  <br/>
  LUT4 Logic • Programmable Interconnect • FPGA Prototyping
</p>

<p align="center">
  <img src="https://img.shields.io/badge/HDL-Verilog-blue?style=for-the-badge&logo=verilog" alt="Verilog"/>
  <img src="https://img.shields.io/badge/Tool-Vivado-orange?style=for-the-badge" alt="Vivado"/>
  <img src="https://img.shields.io/badge/Simulation-XSIM-purple?style=for-the-badge" alt="XSIM"/>
  <img src="https://img.shields.io/badge/Board-Basys%203-red?style=for-the-badge" alt="Basys 3"/>
</p>

---

## 🧠 Overview

This project explores the design of a **Tiny Embedded FPGA (eFPGA)** featuring a **4×4 array of Configurable Logic Blocks (CLBs)** connected through configurable routing resources.

The fabric uses LUT-based logic and programmable interconnect to demonstrate how digital circuits can be mapped onto a reconfigurable hardware architecture. A **4-bit Arithmetic Logic Unit (ALU)** serves as the application demonstration on the Basys 3 FPGA development board.

## 🏗️ Architecture

| Component | Description |
|---|---|
| **4×4 CLB Array** | 16 configurable logic blocks forming the fabric |
| **LUT4** | Implements Boolean functions using a 16-bit truth table |
| **Connection Boxes (CBs)** | Select routing signals for LUT inputs |
| **Switch Boxes (SBs)** | Connect routing tracks across the fabric |
| **Configuration Logic** | Defines LUT functions and routing connectivity |

### 🔄 How It Works

1. **Configure:** Load truth-table bits into LUTs and set routing selections.
2. **Route:** Connection and switch boxes direct signals through the fabric.
3. **Compute:** Configured LUTs implement the required logic functions.
4. **Demonstrate:** Run the mapped ALU design on the Basys 3 board.

## ⚙️ ALU Demonstration

The configured fabric is used to demonstrate a **4-bit ALU** supporting the following operations:

| Operation | Function |
|---|---|
| ADD | Arithmetic addition |
| SUB | Arithmetic subtraction |
| AND | Bitwise AND |
| OR | Bitwise OR |
| XOR | Bitwise exclusive OR |
| NOT | Bitwise complement |

**Hardware platform:** Basys 3 FPGA (Artix-7)

Switches provide the input values and operation selection, while LEDs display the result, according to the implemented board interface.

## 🛠️ Technology Stack

- **HDL:** Verilog
- **FPGA Design:** Xilinx Vivado 2024.1
- **Simulation:** XSIM
- **Hardware:** Digilent Basys 3 — Artix-7 FPGA
- **Design Concepts:** LUT4, configurable logic, routing architecture, RTL simulation, FPGA implementation

## 🎯 Project Objectives

- Design a compact 4×4 configurable logic fabric.
- Explore LUT-based Boolean function implementation.
- Develop configurable connection and switch-box routing.
- Demonstrate digital computation using a circuit mapped onto the fabric.
- Validate the design through simulation and FPGA prototyping.

## 🚀 Future Scope

- Automated configuration and bitstream generation
- Enhanced routing flexibility
- Support for additional circuit configurations
- Timing, area, and resource-utilization analysis
- Exploration of ASIC integration for embedded FPGA applications

---

<p align="center">
  <strong>Exploring Reconfigurable Computing at the RTL Level</strong>
  <br/>
  Built with Verilog HDL and Xilinx Vivado.
</p>
