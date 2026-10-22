quit -sim
vlib work

vcom encoder.vhd
vcom encoder_tb.vhd

vsim work.encoder_tb

add wave -divider Clock/reset:
add wave uut/i_clk
add wave uut/i_rst_n


add wave -divider Inputs:
add wave -color yellow uut/i_A
add wave -color yellow uut/i_B

add wave -divider Outputs:
add wave -radix unsigned uut/o_cnt

run -all
