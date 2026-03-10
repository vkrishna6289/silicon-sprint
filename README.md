# Ping-Pong Buffer Controller

## Silicon Sprint Hackathon 2026

A **Ping-Pong Buffer Controller** implemented in **Verilog HDL** to enable continuous data streaming between a producer and consumer without stalling.

This design uses **two alternating memory banks** where one bank is written while the other is read, allowing uninterrupted data flow.

---

# Project Overview

The Ping-Pong buffering technique is widely used in **digital signal processing, streaming architectures, and SoC interconnects** to avoid pipeline stalls.

This implementation provides:

* Continuous producer-consumer data transfer
* Dual-buffer architecture
* Automatic bank switching
* Modular RTL hierarchy
* Self-checking verification testbench

---

# Problem Statement

Design a **dual-bank memory controller** that allows simultaneous read/write access without interrupting the producer or consumer.

The controller must manage:

* Bank arbitration
* Address mapping
* Swap status signalling

---

# System Architecture

The design consists of three main modules:

### 1. Controller

Handles:

* Bank arbitration
* Write pointer control
* Read pointer control
* Swap signal generation

### 2. Buffer Bank 0

Memory storage for incoming data when selected for write operations.

### 3. Buffer Bank 1

Memory storage for incoming data when banks are swapped.

At any given time:

Producer → writes to one bank
Consumer → reads from the other bank

When the write buffer becomes full, the controller swaps the banks.

---

# Architecture Diagram

```
           +-----------+
           | Producer  |
           +-----+-----+
                 |
                 v
          +-------------+
          | Controller  |
          |             |
          | bank_sel    |
          | swap_done   |
          +------+------+
                 |
        ---------------------
        |                   |
        v                   v
+---------------+   +---------------+
| Buffer Bank 0 |   | Buffer Bank 1 |
+-------+-------+   +-------+-------+
        |                   |
        -----------+--------
                    |
                    v
              +-----------+
              | Consumer  |
              +-----------+
```

---

# Features

* Dual memory bank architecture
* Continuous read/write operations
* Parameterized data width and depth
* Modular RTL design
* Automatic bank switching
* Scalable architecture

---

# Project Structure

```
ping-pong-buffer-controller
│
├── rtl
│   ├── ping_pong_top.v
│   ├── controller.v
│   └── buffer_bank.v
│
├── tb
│   └── tb_ping_pong.v
│
├── synthesis
│   ├── area_report.txt
│   ├── timing_report.txt
│   └── power_report.txt
│
└── README.md
```

---

# RTL Description

## Controller Module

Responsible for:

* Managing read and write pointers
* Determining active memory bank
* Generating swap signals
* Ensuring continuous data transfer

## Buffer Bank Module

Implements memory using a register array with:

* synchronous write operation
* synchronous read operation

## Top Module

Connects controller and buffer banks together.

---

# Verification

A **self-checking testbench** verifies functional correctness.

Verification includes:

* Continuous producer/consumer operation
* Randomized input data generation
* Expected output comparison
* Automatic error detection

Simulation ensures correct bank switching and uninterrupted data flow.

---

# Synthesis

Synthesis was performed to evaluate hardware metrics including:

* Area utilization
* Timing performance
* Power consumption

Generated reports:

* Area Report
* Timing Report
* Power Report

---

# Results

The design successfully demonstrates:

* Continuous data streaming
* Correct bank switching behavior
* Reliable memory access operations

Simulation confirmed functional correctness.

---

# Applications

Ping-Pong buffers are widely used in:

* Video streaming hardware
* DSP pipelines
* Network packet processing
* High-speed data acquisition systems
* AI accelerators

---

# Team Information

Event: Silicon Sprint Hackathon 2026
Problem Statement: Ping-Pong Buffer Controller

---

# License

This project is provided for educational and research purposes.
