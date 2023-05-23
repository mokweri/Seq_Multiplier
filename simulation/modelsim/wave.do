onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Seq_Multiplier_tb/clk
add wave -noupdate /Seq_Multiplier_tb/resetn
add wave -noupdate /Seq_Multiplier_tb/start
add wave -noupdate /Seq_Multiplier_tb/a
add wave -noupdate /Seq_Multiplier_tb/b
add wave -noupdate /Seq_Multiplier_tb/p
add wave -noupdate /Seq_Multiplier_tb/uut/counterr/min_tick
add wave -noupdate /Seq_Multiplier_tb/uut/Adder/s
add wave -noupdate /Seq_Multiplier_tb/uut/E_reg/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {66187 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 54
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {271440 ps}
