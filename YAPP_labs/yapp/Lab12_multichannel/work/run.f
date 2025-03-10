+UVM_VERBOSITY=UVM_FULL 
+ntb_random_seed_automatic
+UVM_TESTNAME=mcseq_test
// +UVM_TESTNAME=test_uvc_integration
// +UVM_TESTNAME=simple_test
// +UVM_TESTNAME=set_config_test
// +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=short_packet_test +ntb_random_seed_automatic
// +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=base_test +ntb_random_seed_automatic

// +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=base_test +SVSEED=random
// +UVM_VERBOSITY=UVM_LOw  
// vcs -sverilog -timescale=1ns/10ps -full64 -f ../tb/filelist.f -ntb_opts -uvm -o simv
//./simv -f run.f