
// include directories
//*** add incdir include directories here

// compile files
//*** add compile files here
// -timescale 1ns/1ns
// +incdir+../Lab11_multi_UVCs          

// +incdir+../clock_and_reset              
// +incdir+../../yapp/sv              
// ../sv/yapp_pkg.sv  
// ../sv/yapp_if.sv
+incdir+../yapp/sv
../yapp/sv/yapp_pkg.sv
../yapp/sv/yapp_if.sv

+incdir+../clock_and_reset/sv              
../clock_and_reset/sv/clock_and_reset_pkg.sv
../clock_and_reset/sv/clock_and_reset_if.sv

+incdir+../hbus/sv              
../hbus/sv/hbus_pkg.sv 
../hbus/sv/hbus_if.sv

+incdir+../channel/sv              
../channel/sv/channel_if.sv
../channel/sv/channel_pkg.sv


+incdir+../task1_integ/tb              
../task1_integ/tb/yapp_router.sv                
../task1_integ/tb/clkgen.sv                
../task1_integ/tb/hw_top_dut.sv                
../task1_integ/tb/tb_top.sv                

