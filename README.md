# Magic Screen — an Etch A Sketch on FPGA

A digital Etch A Sketch made on a DE10-Nano board with the TELECRAN shield.
This project is part of the **Computer Science minor at ENSEA** (FPGA lab sessions).
The left knob moves the stylus horizontally and the right knob vertically. The drawing stays on a
720×480 HDMI picture, and holding the left knob's button erases it.

## Demo

<p align="center">
  <video src="https://github.com/user-attachments/assets/ddaaf15e-1703-47d7-8633-5253588c83d5" controls width="400"></video>
</p>

*Some latency is visible. It most likely comes from the HDMI-to-USB capture adapter,
not from the design.*

## How it works

- **Encoders** – each knob is read with a 2-flip-flop synchronizer, a 1 ms sampling tick and edge
  detection on its A/B signals. This gives a 10-bit position.
- **HDMI** – two counters generate a 720×480 picture at 60 Hz with a 27 MHz pixel clock from a PLL.
- **Memory** – a dual-port RAM stores 1 bit per pixel. Port A writes a `1` at the stylus position, and
  port B is read by the HDMI controller (white = `1`, black = `0`).
- **Eraser** – a counter runs through every address. A multiplexer gives port A to this counter, which
  writes `0`, while the button is held, and once after each reset (KEY0).

## Requirements

- Terasic DE10-Nano (Cyclone V `5CSEBA6U23I7`) with the TELECRAN shield
- Power supply, a USB cable on the **USB BLASTER II** port, and an HDMI cable
- An HDMI-to-USB capture adapter (or an HDMI screen)
- Intel Quartus Prime Lite 24.1 with ModelSim, and VLC

## Repository

```
encoder/        encoder.vhd, testbench encoder_tb.vhd, ModelSim script encoder.do
hdmi/           hdmi_controler.vhd (HDMI 480p controller)
telecran/       telecran.vhd (top level), dpram.vhd, Quartus project, pll/, i2c/
documentation/  screenshots, RTL view, test videos
report/         lab report (report.tex, report.pdf)
```

## Run it

1. In Quartus, open `telecran/telecran.qpf` and run *Processing > Start Compilation*.
2. Open *Tools > Programmer*, click *Auto Detect* and choose `5CSEBA6`. Click *Change File*, select
   `output_files/telecran.sof`, tick *Program/Configure* and click *Start*.
3. Connect the HDMI output to the capture adapter. In VLC, open *Media > Open Capture Device*,
   choose the adapter and click *Play*.
4. Turn the knobs to draw. Hold the left knob's button to erase, or press KEY0 to reset.

**Simulation:** in ModelSim, change the directory to `encoder/` and type `do encoder.do`.

## Credits

This project is based on the lab handout by the course teachers
([ENSEA_2A_FPGA_Public](https://github.com/lfiack/ENSEA_2A_FPGA_Public)). The dual-port memory, the PLL,
the HDMI chip configuration (I2C), the pin assignments and the HDMI controller tutorial were provided.
The rest was written by me.

## Report

The full report (approach, tests, problems and what I learned) is in [`report/FPGA-2G1TP3-ZOUHOUR.pdf`](report/FPGA-2G1TP3-ZOUHOUR.pdf).
