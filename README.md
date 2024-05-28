# UART Transmitter/Receiver in VHDL

Welcome to the UART Transmitter/Receiver VHDL implementation repository. This project provides a VHDL codebase for a Universal Asynchronous Receiver-Transmitter (UART) that includes both transmitter (TX) and receiver (RX) functionality.
This Project was written for the course: "Schaltungsentwurf 2" at the Ravensburg Weingarten University.

## Table of Contents

1. Introduction
2. Features
3. Usage

## Introduction
This project provides a VHDL implementation of a UART Transmitter/Receiver. UART is a widely-used serial communication protocol that allows for asynchronous data transmission between devices. This repository contains the source code, testbenches, and documentation necessary to understand and utilize the UART modules.
This Design was part of a bigger Project of the University course "Schaltungsentwurf 2" and comes with a Test bench to prove it is working.

## Features
- Transmitter (TX): converts parallel Data into serial data
- Receiver (RX): Converts received serial data into parallel data and stores it for the duration of the baud rate
- Switchable baudrate between 9600 baud and 115200 baud via digital input
- No Parity bit
- 1x Start Bit and 1x Stop bit
- Synchronous design: all modules work with the same clock


## USAGE

- m_clk_i takes the clock
- m_rst_i is the restet. This reset is low active!
- m_tx_i is the input for the tx_data
- m_baud_sel_i is to select the baud rate 0 = 9600baud, 1 = 115200 baud
- m_rx_i is for receiving data
- m_tx_start_i is to begin transmission
- m_rx_data_o is the data output of the recieved data
- m_rx_data_ready signals that the data is recieved and ready for the duration of 1x baud rate
- m_tx_data_ready signals that the data has been sent and the stopbit is sent
- m_tx_o is the output of the tx signal
