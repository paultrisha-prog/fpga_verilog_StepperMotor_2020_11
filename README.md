# fpga_verilog_StepperMotorController_2020_11 (Spartan-6, PM20S)
This repository contains a compact FPGA-based stepper motor controller project targeting Spartan-6 (XC6SLX9) and the PM20S 4-phase unipolar stepper motor from a lab kit.

Contents:
-  VHDL sources (full-step and half-step), testbenches and UCF constraints.
- images: Torue Control Sequence, hardware setup and timing diagrams.
  
### ---Setup instructions and how to program the board--- ###
# Setup & How-to (Spartan-6 + PM20S)

1. Files you need
   - src/smotor.vhd (full-step)
   - src/smotor_halfstep.vhd (half-step)
   - src/smotor.ucf (pin mapping)
2. Toolchain
   - Xilinx ISE 9.2i (synthesis, implementation)
   - iMPACT for programming the .bit
3. Steps (high-level)
   - Create a new ISE project, add the VHDL file and the UCF file.
   - Synthesize, Implement (Map/Place & Route), Generate Bitstream.
   - Open iMPACT, connect the board via USB-JTAG, program the generated .bit.
4. Hardware wiring
   - FPGA pins -> BH1 header -> ULN2803 inputs
   - ULN2803 outputs -> CNSM motor header (A1,A2,B1,B2)
   - CNSM COM -> Motor V+ (5-12 V), ensure common ground with FPGA board.
   - Ensure correct power supplies: FPGA board via USB or DC adapter; motor supply via separate regulated source.
5. Testing
   - Use board switches for dir and rst (or wire to external switches).
   - Observe LEDs (if present) before connecting motor.
   - Start with low speed (adjust clk divider MSB) and verify motion.
     
# FPGA FLOW (Xilinx Spartan-6, ISE)- #
1. Design Entry

Write RTL (.v / .vhd)

Constraints (.ucf)

IP cores (.xco, wrapper .v/.vhd)

2. Simulation

Functional sim before synthesis

Files: .wdb/.wcfg (ISim), .vcd (wave dumps)

3. Synthesis (XST)

RTL → netlist of LUTs, FFs, DSPs

Files: .ngc (netlist), .syr (synth report), .ncf

4. Translate (ngdbuild)

Merges design + constraints

Files: .ngd (merged netlist), .bld (log)

5. Map

Maps logic onto FPGA resources

Files: .ncd (mapped), .pcf (physical constraints), .mrp (map report)

6. Place & Route (par)

Places logic, routes interconnects

Files: .ncd (final routed), .par (log)

7. Timing Analysis (trce)

Checks setup/hold

Files: .twr (timing report), .twx (summary)

8. Bitstream Generation (bitgen)

Creates configuration file

Files: .bit (JTAG), .rbt / .svf

9. PROM Generation (promgen/iMPACT)

For non-volatile config

Files: .mcs (SPI flash image), .log
