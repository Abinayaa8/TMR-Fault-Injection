# Fault-Injection Evaluation of Triple Modular Redundancy (TMR)

## Overview
This project evaluates the fault-masking capability of Triple Modular Redundancy (TMR) in digital logic using Verilog RTL simulation. An unprotected accumulator is compared with a TMR-protected accumulator under simulated single-register and simultaneous double-register faults.

## Objectives
- Design baseline and TMR-protected accumulator circuits using Verilog.
- Inject faults using testbench-based fault injection.
- Compare output behavior using Icarus Verilog and GTKWave.
- Examine synthesis statistics using Yosys.
- Evaluate the limitations of majority voting under multiple faults.

## Tools Used
- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys

## Experimental Results

| Experiment | Baseline Final Output | TMR Final Output |
|---|---:|---:|
| No fault | 10 | 10 |
| Single-register fault | 138 | 10 |
| Simultaneous faults in registers A and B | 138 | 138 |

The expected accumulator output is 10 after inputs 5, 3, and 2. The experiments demonstrate masking of the tested single-register faults and failure under simultaneous corruption of two registers.

## Limitations
The results are based on RTL simulation and testbench-forced faults. They do not establish physical hardware reliability or FPGA implementation results.

## Future Work
- Implement and verify an independent TMR architecture.
- Test additional fault locations and bit positions.
- Evaluate FPGA resource utilization and timing overhead.
- Investigate fault coverage and recovery behavior.

## Conclusion
This project provides an RTL simulation study of TMR fault masking and the limitations of majority voting under multiple faults.
