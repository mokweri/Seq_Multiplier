transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/Seq_Multiplier.v}
vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/Register_4bit.v}
vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/shift_reg.v}
vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/shift_reg_si.v}
vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/Adder_4bit.v}

vlog -vlog01compat -work work +incdir+G:/Msc.ECE/COURSE\ WORK/ECE\ 503\ Advanced\ Digital\ Integrated\ Circuits/FPGA\ Labs\ -\ Verilog/Quartus\ Projects/Seq_Multiplier {G:/Msc.ECE/COURSE WORK/ECE 503 Advanced Digital Integrated Circuits/FPGA Labs - Verilog/Quartus Projects/Seq_Multiplier/Seq_Multiplier_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  Seq_Multiplier_tb

add wave *
view structure
view signals
run -all
