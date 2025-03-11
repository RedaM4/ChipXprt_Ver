# Compiler options
VCS = vcs -full64 -ntb_opts uvm -sverilog -debug_all -kdb -f ../task1_integ/tb/filelist.f -timescale=1ns/1ns
SIMV = ./simv 

# Default test (can be overridden)
TEST ?= base_test     
VER ?= UVM_FULL  

compile:
	@echo "🔧 Compiling design..."
	$(VCS)

run: 
	@echo "🚀 Running simulation with TEST=$(TEST)"
	$(SIMV) +UVM_TESTNAME=$(TEST)  +UVM_VERBOSITY=$(VER)  +ntb_random_seed_automatic -l log.log





all: compile run
