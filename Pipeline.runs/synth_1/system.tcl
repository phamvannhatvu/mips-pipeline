# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache {C:/Users/Nhat Khai/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-1152-LAPTOP-TQL8U39E/incrSyn}
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.cache/wt [current_project]
set_property parent.project_path C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty-z7-20:part0:1.0 [current_project]
set_property ip_output_repo c:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/imem.coe
add_files C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/dmem.coe
add_files C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/reg.coe
read_verilog -library xil_defaultlib {
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/ALU.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/DMEM.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/EXE_stage.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/ID_stage.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/IF_stage.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/IMEM.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/MEM_stage.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/REG.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/align_check.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/alu_control.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/control.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/exception_handler.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/forward_unit.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/hazard_detection.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/mux_2_to_1.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/mux_4_to_1.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/pc_register.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/pc_update.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/reg_EXE_MEM.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/reg_HI_LO.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/reg_ID_EXE.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/reg_IF_ID.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/reg_MEM_WB.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/sign_extender.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/system_control.v
  C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/new/system.v
}
read_ip -quiet C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/ip/dmem_lib/dmem_lib.xci
set_property used_in_implementation false [get_files -all c:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/ip/dmem_lib/dmem_lib_ooc.xdc]

read_ip -quiet C:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/ip/imem_lib/imem_lib.xci
set_property used_in_implementation false [get_files -all c:/HCMUT/HK222/CO2007/Assignment/mips-pipeline-memory_unit/Pipeline.srcs/sources_1/ip/imem_lib/imem_lib_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top system -part xc7z020clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef system.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file system_utilization_synth.rpt -pb system_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
