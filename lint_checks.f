
+incdir+./packages/dependencies
+incdir+./packages/rv_iommu
+incdir+./include
////+incdir+./vendor
////+incdir+./rtl
////+incdir+./rtl/translation_logic
////+incdir+./rtl/translation_logic/cdw
////+incdir+./rtl/translation_logic/ptw
////+incdir+./rtl/translation_logic/iotlb
////+incdir+./rtl/translation_logic/wrapper
////+incdir+./rtl/software_interface
////+incdir+./rtl/software_interface/regmap
////+incdir+./rtl/software_interface/wrapper
////+incdir+./rtl/ext_interfaces
////+incdir+./rtl/ext_interfaces

./lint_checks.sv

./rtl/riscv_iommu.sv

./rtl/ext_interfaces/rv_iommu_axi4_bc.sv
./rtl/ext_interfaces/rv_iommu_ds_if.sv
./rtl/ext_interfaces/rv_iommu_prog_if.sv

./rtl/software_interface/rv_iommu_cq_handler.sv
./rtl/software_interface/rv_iommu_fq_handler.sv
./rtl/software_interface/rv_iommu_hpm.sv
./rtl/software_interface/rv_iommu_msi_ig.sv
./rtl/software_interface/rv_iommu_wsi_ig.sv
./rtl/software_interface/regmap/rv_iommu_field_arb.sv
./rtl/software_interface/regmap/rv_iommu_field.sv
./rtl/software_interface/regmap/rv_iommu_regmap.sv
./rtl/software_interface/wrapper/rv_iommu_sw_if_wrapper.sv

./rtl/translation_logic/rv_iommu_ddtc.sv
./rtl/translation_logic/rv_iommu_iotlb_sv39x4.sv
./rtl/translation_logic/rv_iommu_mrifc.sv
./rtl/translation_logic/rv_iommu_mrif_handler.sv
./rtl/translation_logic/rv_iommu_msiptw.sv
./rtl/translation_logic/rv_iommu_pdtc.sv
./rtl/translation_logic/cdw/rv_iommu_cdw_pc.sv
./rtl/translation_logic/cdw/rv_iommu_cdw.sv
./rtl/translation_logic/ptw/rv_iommu_ptw_sv39x4_pc.sv
./rtl/translation_logic/ptw/rv_iommu_ptw_sv39x4.sv
./rtl/translation_logic/wrapper/rv_iommu_translation_wrapper.sv
./rtl/translation_logic/wrapper/rv_iommu_tw_sv39x4_pc.sv
./rtl/translation_logic/wrapper/rv_iommu_tw_sv39x4.sv

./vendor/apb_to_reg.sv
./vendor/axi2apb_64_32.sv
./vendor/axi_ar_buffer.sv
./vendor/axi_atop_filter.sv
./vendor/axi_aw_buffer.sv
./vendor/axi_b_buffer.sv
./vendor/axi_burst_splitter.sv
./vendor/axi_demux.sv
./vendor/axi_err_slv.sv
./vendor/axi_lite_to_reg.sv
./vendor/axi_r_buffer.sv
./vendor/axi_single_slice.sv
./vendor/axi_slice.sv
./vendor/axi_to_axi_lite.sv
./vendor/axi_to_reg.sv
./vendor/axi_w_buffer.sv
/////./vendor/cf_math_pkg.sv
./vendor/counter.sv
./vendor/delta_counter.sv
./vendor/fifo.sv
./vendor/fifo_v2.sv
./vendor/fifo_v3.sv
./vendor/id_queue.sv
./vendor/lzc.sv
./vendor/onehot_to_bin.sv
./vendor/REG_BUS.sv
./vendor/rr_arb_tree.sv
./vendor/spill_register_flushable.sv
./vendor/spill_register.sv
./vendor/stream_arbiter_flushable.sv
./vendor/stream_arbiter.sv
./vendor/stream_demux.sv
./vendor/stream_mux.sv
./vendor/stream_register.sv

