# ============================================================
#   QuestaSim Run Script (Batch Mode) - Fixed Version
# ============================================================

# -------- User Settings --------
set project_name "i_riscv_core_project"
set top_module_name "risc_test"
set proj_dir "C:/Users/mosta/OneDrive/Desktop/irisc_v_core_project"
# --------------------------------

# Go to project directory
cd $proj_dir
puts "WORKING DIR = [pwd]"

# Create folders (absolute paths)
file mkdir "$proj_dir/logs"
file mkdir "$proj_dir/project_related_files"

# Check if logs directory exists
if {![file isdirectory "$proj_dir/logs"]} {
    puts "ERROR: logs directory was not created! Check permissions or OneDrive settings."
    quit -f
}

# Timestamp
set t [clock format [clock seconds] -format "%Y%m%d_%H%M%S"]

# Log file paths (absolute)
set comp_log "$proj_dir/logs/compile_$t.log"
set sim_out_log "$proj_dir/logs/sim_output_$t.log"
set sim_err_log "$proj_dir/logs/sim_err_$t.log"

# Project file
set proj_file "$proj_dir/project_related_files/${project_name}.mpf"
if {![file exists $proj_file]} {
    project new $proj_file $project_name
    puts "Created new project $project_name"
} else {
    project open $proj_file
    puts "Opened project $project_name"
}

# Create work library if not exists
if {![file exists work]} {
    vlib work
    vmap work work
}

# Compile Verilog files
vlog -l $comp_log "$proj_dir/rtl/*.v"

# Run simulation in batch mode
transcript file $sim_err_log
vsim -c -voptargs="+acc" work.$top_module_name -l $sim_out_log
run -all
transcript file ""

# Report
echo "============================================================"
echo " Project file     : $proj_file"
echo " Compilation log  : $comp_log"
echo " Simulation output: $sim_out_log"
echo " Simulation errors: $sim_err_log"
echo "============================================================"

quit -f
