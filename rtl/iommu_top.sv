// +FHDR*****************************************************************************
//                 Copyright (c) 2024 Auto-SoC Co., Ltd..
//                       ALL RIGHTS RESERVED
// **********************************************************************************
// Filename     : iommu_top.sv
// Author       : orysduan
// Created On   : 2024-02-23 18:04
// Last Modified: 
// ----------------------------------------------------------------------------------
// Description  :  top module of iommu_top.sv
//                 1: 
//
// ----------------------------------------------------------------------------------
// Child-module :  
//
//
// -FHDR*****************************************************************************
// **********************************************************************************

`include "include/assertions.svh"
`include "ariane_axi_soc_pkg.sv"
`include "typedef_global.svh"
`include "rv_iommu_pkg.sv"
`include "rv_iommu_reg_pkg.sv"
`include "rv_iommu_field_pkg.sv"

module iommu_top(/*AUTOARG*/
    //Outputs
    tri_axi_awready, tri_axi_wready, tri_axi_bid, tri_axi_buser,
    tri_axi_bresp, tri_axi_bvalid, tri_axi_arready, tri_axi_rid,
    tri_axi_ruser, tri_axi_rdata, tri_axi_rresp, tri_axi_rvalid,
    tri_axi_rlast, tci_axi_awid, tci_axi_awuser, tci_axi_awqos,
    tci_axi_awregion, tci_axi_awatop, tci_axi_awlen, tci_axi_awsize,
    tci_axi_awburst, tci_axi_awawaddr, tci_axi_awlock, tci_axi_awcache,
    tci_axi_awprot, tci_axi_awvalid, tci_axi_wuser, tci_axi_wdata,
    tci_axi_wstrb, tci_axi_wlast, tci_axi_wvalid, tci_axi_bready,
    tci_axi_arid, tci_axi_aruser, tci_axi_arqos, tci_axi_arregion,
    tci_axi_arlen, tci_axi_arsize, tci_axi_arburst, tci_axi_araddr,
    tci_axi_arlock, tci_axi_arcache, tci_axi_arprot, tci_axi_arvalid,
    tci_axi_rready, dsi_axi_awid, dsi_axi_awuser, dsi_axi_awqos,
    dsi_axi_awregion, dsi_axi_awatop, dsi_axi_awlen, dsi_axi_awsize,
    dsi_axi_awburst, dsi_axi_awaddr, dsi_axi_awlock, dsi_axi_awcache,
    dsi_axi_awprot, dsi_axi_awvalid, dsi_axi_wuser, dsi_axi_wdata,
    dsi_axi_wstrb, dsi_axi_wlast, dsi_axi_wvalid, dsi_axi_bready,
    dsi_axi_arid, dsi_axi_aruser, dsi_axi_arqos, dsi_axi_arregion,
    dsi_axi_arlen, dsi_axi_arsize, dsi_axi_arburst, dsi_axi_araddr,
    dsi_axi_arlock, dsi_axi_arcache, dsi_axi_arprot, dsi_axi_arvalid,
    dsi_axi_rready,
    `ifdef RV_IOMMU_PROG_IF_USE_AXI
    cfg_axi_awready, cfg_axi_wready, cfg_axi_bid, cfg_axi_buser,
    cfg_axi_bresp, cfg_axi_bvalid, cfg_axi_arready, cfg_axi_rid,
    cfg_axi_ruser, cfg_axi_rdata, cfg_axi_rresp, cfg_axi_rvalid,
    cfg_axi_rlast,
    `else // RV_IOMMU_PROG_IF_USE_APB
    prdata_o, pready_o, pslverr_o,
    `endif  //`endif RV_IOMMU_PROG_IF_USE_AXI
    wsi,

    //Inputs
    clk, rst_n, tri_axi_awid, tri_axi_awuser, tri_axi_awqos,
    tri_axi_awregion, tri_axi_awatop, tri_axi_awlen, tri_axi_awsize,
    tri_axi_awburst, tri_axi_awaddr, tri_axi_awlock, tri_axi_awcache,
    tri_axi_awprot, tri_axi_awstream_id, tri_axi_awss_id_valid,
    tri_axi_awsubstream_id, tri_axi_awvalid, tri_axi_wuser,
    tri_axi_wdata, tri_axi_wstrb, tri_axi_wlast, tri_axi_wvalid,
    tri_axi_bready, tri_axi_arid, tri_axi_aruser, tri_axi_arqos,
    tri_axi_arregion, tri_axi_arlen, tri_axi_arsize, tri_axi_arburst,
    tri_axi_araddr, tri_axi_arlock, tri_axi_arcache, tri_axi_arprot,
    tri_axi_arstream_id, tri_axi_arss_id_valid, tri_axi_arsubstream_id,
    tri_axi_arvalid, tri_axi_rready, tci_axi_awready, tci_axi_wready,
    tci_axi_bid, tci_axi_buser, tci_axi_bresp, tci_axi_bvalid,
    tci_axi_arready, tci_axi_rid, tci_axi_ruser, tci_axi_rdata,
    tci_axi_rresp, tci_axi_rlast, tci_axi_rvalid, dsi_axi_awready,
    dsi_axi_wready, dsi_axi_bid, dsi_axi_buser, dsi_axi_bresp,
    dsi_axi_bvalid, dsi_axi_arready, dsi_axi_rid, dsi_axi_ruser,
    dsi_axi_rdata, dsi_axi_rresp, dsi_axi_rlast, dsi_axi_rvalid
    `ifdef RV_IOMMU_PROG_IF_USE_AXI
    ,cfg_axi_awid, cfg_axi_awuser, cfg_axi_awqos, cfg_axi_awregion
    ,cfg_axi_awatop, cfg_axi_awlen, cfg_axi_awsize, cfg_axi_awburst
    ,cfg_axi_awaddr, cfg_axi_awlock, cfg_axi_awcache, cfg_axi_awprot
    ,cfg_axi_awvalid, cfg_axi_wuser, cfg_axi_wdata, cfg_axi_wstrb
    ,cfg_axi_wlast, cfg_axi_wvalid, cfg_axi_bready, cfg_axi_arid
    ,cfg_axi_aruser, cfg_axi_arregion, cfg_axi_arqos, cfg_axi_arlen
    ,cfg_axi_arsize, cfg_axi_arburst, cfg_axi_araddr, cfg_axi_arlock
    ,cfg_axi_arcache, cfg_axi_arprot, cfg_axi_arvalid, cfg_axi_rready
    `else // RV_IOMMU_PROG_IF_USE_APB
    ,penable_i, pwrite_i, paddr_i, psel_i, pwdata_i
    `endif  //`endif RV_IOMMU_PROG_IF_USE_AXI
);

//////////////////////////////////////////////////////////////////////////////
// Parameter Definition                                                     //
//////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------
// Parameters that can be modified/overrided when instance this module
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Local Prameters
// Parameters that can NOT be modified/overrided when instance this module
//--------------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////
// Input/Output Declaration                                                 //
//////////////////////////////////////////////////////////////////////////////

input                           clk;
input                           rst_n; //lowactive

// Translation Request Interface(Slave)
// ~ AW
input  [ariane_soc::IdWidth-1:0]  tri_axi_awid;
input  [ariane_axi_soc::UserWidth-1:0]  tri_axi_awuser;
input  [3:0]                    tri_axi_awqos;
input  [3:0]                    tri_axi_awregion;
input  [5:0]                    tri_axi_awatop;
input  [7:0]                    tri_axi_awlen;
input  [2:0]                    tri_axi_awsize;
input  [1:0]                    tri_axi_awburst;
input  [ariane_axi_soc::AddrWidth-1:0]  tri_axi_awaddr;
input                           tri_axi_awlock;
input  [3:0]                    tri_axi_awcache;
input  [2:0]                    tri_axi_awprot;
input  [23:0]                   tri_axi_awstream_id; //device_id
input                           tri_axi_awss_id_valid;
input  [19:0]                   tri_axi_awsubstream_id; //process_id
input                           tri_axi_awvalid;
output                          tri_axi_awready;

// ~ W
input  [ariane_axi_soc::UserWidth-1:0]  tri_axi_wuser;
input  [ariane_axi_soc::DataWidth-1:0]  tri_axi_wdata;
input  [ariane_axi_soc::StrbWidth-1:0]  tri_axi_wstrb;
input                           tri_axi_wlast;
input                           tri_axi_wvalid;
output                          tri_axi_wready;

// ~ B
output [ariane_soc::IdWidth-1:0]  tri_axi_bid;
output [ariane_axi_soc::UserWidth-1:0]  tri_axi_buser;
output [1:0]                    tri_axi_bresp;
output                          tri_axi_bvalid;
input                           tri_axi_bready;

// ~ AR
input  [ariane_soc::IdWidth-1:0]  tri_axi_arid;
input  [ariane_axi_soc::UserWidth-1:0]  tri_axi_aruser;
input  [3:0]                    tri_axi_arqos;
input  [3:0]                    tri_axi_arregion;
input  [7:0]                    tri_axi_arlen;
input  [2:0]                    tri_axi_arsize;
input  [1:0]                    tri_axi_arburst;
input  [ariane_axi_soc::AddrWidth-1:0]  tri_axi_araddr;
input                           tri_axi_arlock;
input  [3:0]                    tri_axi_arcache;
input  [2:0]                    tri_axi_arprot;
input  [23:0]                   tri_axi_arstream_id;
input                           tri_axi_arss_id_valid;
input  [19:0]                   tri_axi_arsubstream_id;
input                           tri_axi_arvalid;
output                          tri_axi_arready;

// ~ R
output [ariane_soc::IdWidth-1:0]  tri_axi_rid;
output [ariane_axi_soc::UserWidth-1:0]  tri_axi_ruser;
output [ariane_axi_soc::DataWidth-1:0]  tri_axi_rdata;
output [1:0]                    tri_axi_rresp;
output                          tri_axi_rvalid;
output                          tri_axi_rlast;
input                           tri_axi_rready;


// Translation Completion Interface (Master)
// ~ AW
output [ariane_soc::IdWidth-1:0]  tci_axi_awid;
output [ariane_axi_soc::UserWidth-1:0]  tci_axi_awuser;
output [3:0]                    tci_axi_awqos;
output [3:0]                    tci_axi_awregion;
output [5:0]                    tci_axi_awatop;
output [7:0]                    tci_axi_awlen;
output [2:0]                    tci_axi_awsize;
output [1:0]                    tci_axi_awburst;
output [ariane_axi_soc::AddrWidth-1:0]  tci_axi_awawaddr;
output                          tci_axi_awlock;
output [3:0]                    tci_axi_awcache;
output [2:0]                    tci_axi_awprot;
output                          tci_axi_awvalid;
input                           tci_axi_awready;

// ~ W
output [ariane_axi_soc::UserWidth-1:0]  tci_axi_wuser;
output [ariane_axi_soc::DataWidth-1:0]  tci_axi_wdata;
output [ariane_axi_soc::StrbWidth-1:0]  tci_axi_wstrb;
output                          tci_axi_wlast;
output                          tci_axi_wvalid;
input                           tci_axi_wready;
input  [ariane_soc::IdWidth-1:0]  tci_axi_bid;
input  [ariane_axi_soc::UserWidth-1:0]  tci_axi_buser;
input  [1:0]                    tci_axi_bresp;
input                           tci_axi_bvalid;
output                          tci_axi_bready;

// ~ AR
output [ariane_soc::IdWidth-1:0]  tci_axi_arid;
output [ariane_axi_soc::UserWidth-1:0]  tci_axi_aruser;
output [3:0]                    tci_axi_arqos;
output [3:0]                    tci_axi_arregion;
output [7:0]                    tci_axi_arlen;
output [2:0]                    tci_axi_arsize;
output [1:0]                    tci_axi_arburst;
output [ariane_axi_soc::AddrWidth-1:0]  tci_axi_araddr;
output                          tci_axi_arlock;
output [3:0]                    tci_axi_arcache;
output [2:0]                    tci_axi_arprot;
output                          tci_axi_arvalid;
input                           tci_axi_arready;

// ~ R
input  [ariane_soc::IdWidth-1:0]  tci_axi_rid;
input  [ariane_axi_soc::UserWidth-1:0]  tci_axi_ruser;
input  [ariane_axi_soc::DataWidth-1:0]  tci_axi_rdata;
input  [1:0]                    tci_axi_rresp;
input                           tci_axi_rlast;
input                           tci_axi_rvalid;
output                          tci_axi_rready;

// Data Structures Interface (Master)
// ~ AW
output [ariane_soc::IdWidth-1:0]  dsi_axi_awid;
output [ariane_axi_soc::UserWidth-1:0]  dsi_axi_awuser;
output [3:0]                    dsi_axi_awqos;
output [3:0]                    dsi_axi_awregion;
output [5:0]                    dsi_axi_awatop;
output [7:0]                    dsi_axi_awlen;
output [2:0]                    dsi_axi_awsize;
output [1:0]                    dsi_axi_awburst;
output [ariane_axi_soc::AddrWidth-1:0]  dsi_axi_awaddr;
output                          dsi_axi_awlock;
output [3:0]                    dsi_axi_awcache;
output [2:0]                    dsi_axi_awprot;
output                          dsi_axi_awvalid;
input                           dsi_axi_awready;
output [ariane_axi_soc::UserWidth-1:0]  dsi_axi_wuser;
output [ariane_axi_soc::DataWidth-1:0]  dsi_axi_wdata;
output [ariane_axi_soc::StrbWidth-1:0]  dsi_axi_wstrb;
output                          dsi_axi_wlast;
output                          dsi_axi_wvalid;
input                           dsi_axi_wready;

// ~ B
input  [ariane_soc::IdWidth-1:0]  dsi_axi_bid;
input  [ariane_axi_soc::UserWidth-1:0]  dsi_axi_buser;
input  [1:0]                    dsi_axi_bresp;
input                           dsi_axi_bvalid;
output                          dsi_axi_bready;

// ~ AR
output [ariane_soc::IdWidth-1:0]  dsi_axi_arid;
output [ariane_axi_soc::UserWidth-1:0]  dsi_axi_aruser;
output [3:0]                    dsi_axi_arqos;
output [3:0]                    dsi_axi_arregion;
output [7:0]                    dsi_axi_arlen;
output [2:0]                    dsi_axi_arsize;
output [1:0]                    dsi_axi_arburst;
output [ariane_axi_soc::AddrWidth-1:0]  dsi_axi_araddr;
output                          dsi_axi_arlock;
output [3:0]                    dsi_axi_arcache;
output [2:0]                    dsi_axi_arprot;
output                          dsi_axi_arvalid;
input                           dsi_axi_arready;

// ~ R
input  [ariane_soc::IdWidth-1:0]  dsi_axi_rid;
input  [ariane_axi_soc::UserWidth-1:0]  dsi_axi_ruser;
input  [ariane_axi_soc::DataWidth-1:0]  dsi_axi_rdata;
input  [1:0]                    dsi_axi_rresp;
input                           dsi_axi_rlast;
input                           dsi_axi_rvalid;
output                          dsi_axi_rready;


`ifdef RV_IOMMU_PROG_IF_USE_AXI
    // Programming Interface (Slave) (AXI4 Ful1-> AXI4-Lite -> Reg IF) 
    // ~ AW
    input  [ariane_soc::IdWidthSlave-1:0]  cfg_axi_awid;
    input  [ariane_axi_soc::UserWidth-1:0]  cfg_axi_awuser;
    input  [3:0]                    cfg_axi_awqos;
    input  [3:0]                    cfg_axi_awregion;
    input  [5:0]                    cfg_axi_awatop;
    input  [7:0]                    cfg_axi_awlen;
    input  [2:0]                    cfg_axi_awsize;
    input  [1:0]                    cfg_axi_awburst;
    input  [ariane_axi_soc::AddrWidth-1:0]  cfg_axi_awaddr;
    input                           cfg_axi_awlock;
    input  [3:0]                    cfg_axi_awcache;
    input  [2:0]                    cfg_axi_awprot;
    input                           cfg_axi_awvalid;
    output                          cfg_axi_awready;
    
    // ~ W
    input  [ariane_axi_soc::UserWidth-1:0]  cfg_axi_wuser;
    input  [ariane_axi_soc::DataWidth-1:0]  cfg_axi_wdata;
    input  [ariane_axi_soc::StrbWidth-1:0]  cfg_axi_wstrb;
    input                           cfg_axi_wlast;
    input                           cfg_axi_wvalid;
    output                          cfg_axi_wready;
    
    // ~ B
    output [ariane_soc::IdWidthSlave-1:0]  cfg_axi_bid;
    output [ariane_axi_soc::UserWidth-1:0]  cfg_axi_buser;
    output [1:0]                    cfg_axi_bresp;
    output                          cfg_axi_bvalid;
    input                           cfg_axi_bready;
    
    // ~ AR
    input  [ariane_soc::IdWidthSlave-1:0]  cfg_axi_arid;
    input  [ariane_axi_soc::UserWidth-1:0]  cfg_axi_aruser;
    input  [3:0]                    cfg_axi_arregion;
    input  [3:0]                    cfg_axi_arqos;
    input  [7:0]                    cfg_axi_arlen;
    input  [2:0]                    cfg_axi_arsize;
    input  [1:0]                    cfg_axi_arburst;
    input  [ariane_axi_soc::AddrWidth-1:0]  cfg_axi_araddr;
    input                           cfg_axi_arlock;
    input  [3:0]                    cfg_axi_arcache;
    input  [2:0]                    cfg_axi_arprot;
    input                           cfg_axi_arvalid;
    output                          cfg_axi_arready;
    
    // ~ R
    output [ariane_soc::IdWidthSlave-1:0]  cfg_axi_rid;
    output [ariane_axi_soc::UserWidth-1:0]  cfg_axi_ruser;
    output [ariane_axi_soc::DataWidth-1:0]  cfg_axi_rdata;
    output [1:0]                    cfg_axi_rresp;
    output                          cfg_axi_rvalid;
    output                          cfg_axi_rlast;
    input                           cfg_axi_rready;
`else // RV_IOMMU_PROG_IF_USE_APB
    // Programming Interface (Slave) (APB -> Reg IF) 
    input                          penable_i;
    input                          pwrite_i;
    input  [31:0]                  paddr_i;
    input                          psel_i;
    input  [31:0]                  pwdata_i;
    output [31:0]                  prdata_o;
    output                         pready_o;
    output                         pslverr_o;
`endif // RV_IOMMU_PROG_IF_USE_AXI

// Wire Signaled Interrupt
output [ariane_soc::IOMMUNumWires-1:0]  wsi;


//////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                       //
//////////////////////////////////////////////////////////////////////////////

/*autodefine*/
//auto wires{{{
wire                         cfg_axi_arready;
wire                         cfg_axi_awready;
wire [ariane_soc::IdWidthSlave-1:0] cfg_axi_bid;
wire [1:0]                   cfg_axi_bresp;
wire [ariane_axi_soc::UserWidth-1:0] cfg_axi_buser;
wire                         cfg_axi_bvalid;
wire [ariane_axi_soc::DataWidth-1:0] cfg_axi_rdata;
wire [ariane_soc::IdWidthSlave-1:0] cfg_axi_rid;
wire                         cfg_axi_rlast;
wire [1:0]                   cfg_axi_rresp;
wire [ariane_axi_soc::UserWidth-1:0] cfg_axi_ruser;
wire                         cfg_axi_rvalid;
wire                         cfg_axi_wready;
wire                         clk_i;
wire [ariane_axi_soc::AddrWidth-1:0] dsi_axi_araddr;
wire [1:0]                   dsi_axi_arburst;
wire [3:0]                   dsi_axi_arcache;
wire [ariane_soc::IdWidth-1:0] dsi_axi_arid;
wire [7:0]                   dsi_axi_arlen;
wire                         dsi_axi_arlock;
wire [2:0]                   dsi_axi_arprot;
wire [3:0]                   dsi_axi_arqos;
wire [3:0]                   dsi_axi_arregion;
wire [2:0]                   dsi_axi_arsize;
wire [ariane_axi_soc::UserWidth-1:0] dsi_axi_aruser;
wire                         dsi_axi_arvalid;
wire [ariane_axi_soc::AddrWidth-1:0] dsi_axi_awaddr;
wire [5:0]                   dsi_axi_awatop;
wire [1:0]                   dsi_axi_awburst;
wire [3:0]                   dsi_axi_awcache;
wire [ariane_soc::IdWidth-1:0] dsi_axi_awid;
wire [7:0]                   dsi_axi_awlen;
wire                         dsi_axi_awlock;
wire [2:0]                   dsi_axi_awprot;
wire [3:0]                   dsi_axi_awqos;
wire [3:0]                   dsi_axi_awregion;
wire [2:0]                   dsi_axi_awsize;
wire [ariane_axi_soc::UserWidth-1:0] dsi_axi_awuser;
wire                         dsi_axi_awvalid;
wire                         dsi_axi_bready;
wire                         dsi_axi_rready;
wire [ariane_axi_soc::DataWidth-1:0] dsi_axi_wdata;
wire                         dsi_axi_wlast;
wire [ariane_axi_soc::StrbWidth-1:0] dsi_axi_wstrb;
wire [ariane_axi_soc::UserWidth-1:0] dsi_axi_wuser;
wire                         dsi_axi_wvalid;
wire [31:0]                  prdata_o;
wire                         pready_o;
wire                         pslverr_o;
wire                         rst_ni;
wire [ariane_axi_soc::AddrWidth-1:0] tci_axi_araddr;
wire [1:0]                   tci_axi_arburst;
wire [3:0]                   tci_axi_arcache;
wire [ariane_soc::IdWidth-1:0] tci_axi_arid;
wire [7:0]                   tci_axi_arlen;
wire                         tci_axi_arlock;
wire [2:0]                   tci_axi_arprot;
wire [3:0]                   tci_axi_arqos;
wire [3:0]                   tci_axi_arregion;
wire [2:0]                   tci_axi_arsize;
wire [ariane_axi_soc::UserWidth-1:0] tci_axi_aruser;
wire                         tci_axi_arvalid;
wire [5:0]                   tci_axi_awatop;
wire [ariane_axi_soc::AddrWidth-1:0] tci_axi_awawaddr;
wire [1:0]                   tci_axi_awburst;
wire [3:0]                   tci_axi_awcache;
wire [ariane_soc::IdWidth-1:0] tci_axi_awid;
wire [7:0]                   tci_axi_awlen;
wire                         tci_axi_awlock;
wire [2:0]                   tci_axi_awprot;
wire [3:0]                   tci_axi_awqos;
wire [3:0]                   tci_axi_awregion;
wire [2:0]                   tci_axi_awsize;
wire [ariane_axi_soc::UserWidth-1:0] tci_axi_awuser;
wire                         tci_axi_awvalid;
wire                         tci_axi_bready;
wire                         tci_axi_rready;
wire [ariane_axi_soc::DataWidth-1:0] tci_axi_wdata;
wire                         tci_axi_wlast;
wire [ariane_axi_soc::StrbWidth-1:0] tci_axi_wstrb;
wire [ariane_axi_soc::UserWidth-1:0] tci_axi_wuser;
wire                         tci_axi_wvalid;
wire                         tri_axi_arready;
wire                         tri_axi_awready;
wire [ariane_soc::IdWidth-1:0] tri_axi_bid;
wire [1:0]                   tri_axi_bresp;
wire [ariane_axi_soc::UserWidth-1:0] tri_axi_buser;
wire                         tri_axi_bvalid;
wire [ariane_axi_soc::DataWidth-1:0] tri_axi_rdata;
wire [ariane_soc::IdWidth-1:0] tri_axi_rid;
wire                         tri_axi_rlast;
wire [1:0]                   tri_axi_rresp;
wire [ariane_axi_soc::UserWidth-1:0] tri_axi_ruser;
wire                         tri_axi_rvalid;
wire                         tri_axi_wready;
wire [ariane_soc::IOMMUNumWires-1:0] wsi;
wire [(ariane_soc::IOMMUNumWires-1):0] wsi_wires_o;
//}}}
// End of automatic define

// Translation Request Interface (Slave)
ariane_axi_soc::req_mmu_t dev_tr_req_i;
ariane_axi_soc::resp_t    dev_tr_resp_o;

// Translation Completion Interface (Master)
ariane_axi_soc::resp_t    dev_comp_resp_i;
ariane_axi_soc::req_t     dev_comp_req_o;

// Data Structures Interface (Master)
ariane_axi_soc::resp_t    ds_resp_i;
ariane_axi_soc::req_t     ds_req_o;

`ifdef RV_IOMMU_PROG_IF_USE_AXI
    //Programming Interface (Slave) (AXI4 Full1->AXI4-Lite ->Reg IF)
    ariane_axi_soc::req_slv_t  prog_req_i;
    ariane_axi_soc::resp_slv_t prog_resp_o;
`endif // RV_IOMMU_PROG_IF_USE_AXI


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////

assign clk_i  = clk;
assign rst_ni =rst_n;

// Translation Request Interface (Slave)
// ~ AW
assign dev_tr_req_i.aw.id           = tri_axi_awid;
assign dev_tr_req_i.aw.user         = tri_axi_awuser;
assign dev_tr_req_i.aw.qos          = tri_axi_awqos;
assign dev_tr_req_i.aw.region       = tri_axi_awregion;
assign dev_tr_req_i.aw.atop         = tri_axi_awatop;
assign dev_tr_req_i.aw.len          = tri_axi_awlen;
assign dev_tr_req_i.aw.size         = tri_axi_awsize;
assign dev_tr_req_i.aw.burst        = tri_axi_awburst;
assign dev_tr_req_i.aw.addr         = tri_axi_awaddr;
assign dev_tr_req_i.aw.lock         = tri_axi_awlock;
assign dev_tr_req_i.aw.cache        = tri_axi_awcache;
assign dev_tr_req_i.aw.prot         = tri_axi_awprot;
assign dev_tr_req_i.aw.stream_id    = tri_axi_awstream_id;      // device_id
assign dev_tr_req_i.aw.ss_id_valid  = tri_axi_awss_id_valid;
assign dev_tr_req_i.aw.substream_id = tri_axi_awsubstream_id;   // process_id
assign dev_tr_req_i.aw_valid        = tri_axi_awvalid;
assign tri_axi_awready              = dev_tr_resp_o.aw_ready;

// ~ W
assign dev_tr_req_i.w.user          = tri_axi_wuser;
assign dev_tr_req_i.w.data          = tri_axi_wdata;
assign dev_tr_req_i.w.strb          = tri_axi_wstrb;
assign dev_tr_req_i.w.last          = tri_axi_wlast;
assign dev_tr_req_i.w_valid         = tri_axi_wvalid;
assign tri_axi_wready               = dev_tr_resp_o.w_ready;

// ~ B
assign tri_axi_bid                  = dev_tr_resp_o.b.id;
assign tri_axi_buser                = dev_tr_resp_o.b.user;
assign tri_axi_bresp                = dev_tr_resp_o.b.resp;
assign tri_axi_bvalid               = dev_tr_resp_o.b_valid;
assign dev_tr_req_i.b_ready         = tri_axi_bready;

// ~ AR
assign dev_tr_req_i.ar.id           = tri_axi_arid;
assign dev_tr_req_i.ar.user         = tri_axi_aruser;
assign dev_tr_req_i.ar.qos          = tri_axi_arqos;
assign dev_tr_req_i.ar.region       = tri_axi_arregion;
assign dev_tr_req_i.ar.len          = tri_axi_arlen;
assign dev_tr_req_i.ar.size         = tri_axi_arsize;
assign dev_tr_req_i.ar.burst        = tri_axi_arburst;
assign dev_tr_req_i.ar.addr         = tri_axi_araddr;
assign dev_tr_req_i.ar.lock         = tri_axi_arlock;
assign dev_tr_req_i.ar.cache        = tri_axi_arcache;
assign dev_tr_req_i.ar.prot         = tri_axi_arprot;
assign dev_tr_req_i.ar.stream_id    = tri_axi_arstream_id;    // device_id
assign dev_tr_req_i.ar.ss_id_valid  = tri_axi_arss_id_valid;
assign dev_tr_req_i.ar.substream_id = tri_axi_arsubstream_id; // process_id
assign dev_tr_req_i.ar_valid        = tri_axi_arvalid;
assign tri_axi_arready              = dev_tr_resp_o.ar_ready;

// ~ R
assign tri_axi_rid                  = dev_tr_resp_o.r.id   ;
assign tri_axi_ruser                = dev_tr_resp_o.r.user ;
assign tri_axi_rdata                = dev_tr_resp_o.r.data ;
assign tri_axi_rresp                = dev_tr_resp_o.r.resp ;
assign tri_axi_rvalid               = dev_tr_resp_o.r_valid;
assign tri_axi_rlast                = dev_tr_resp_o.r.last ;
assign dev_tr_req_i.r_ready         = tri_axi_rready;


// Translation Completion Interface (Master)
// ~ AW
assign tci_axi_awid                 = dev_comp_req_o.aw.id  ;
assign tci_axi_awuser               = dev_comp_req_o.aw.user;
assign tci_axi_awqos                = dev_comp_req_o.aw.qos ;
assign tci_axi_awatop               = dev_comp_req_o.aw.atop;
assign tci_axi_awregion             = dev_comp_req_o.aw.region;
assign tci_axi_awlen                = dev_comp_req_o.aw.len;
assign tci_axi_awsize               = dev_comp_req_o.aw.size;
assign tci_axi_awburst              = dev_comp_req_o.aw.burst;
assign tci_axi_awawaddr             = dev_comp_req_o.aw.addr;
assign tci_axi_awlock               = dev_comp_req_o.aw.lock;
assign tci_axi_awcache              = dev_comp_req_o.aw.cache;
assign tci_axi_awprot               = dev_comp_req_o.aw.prot;
assign tci_axi_awvalid              = dev_comp_req_o.aw_valid;
assign dev_comp_resp_i.aw_ready     = tci_axi_awready;

// ~ W
assign tci_axi_wuser                = dev_comp_req_o.w.user;
assign tci_axi_wdata                = dev_comp_req_o.w.data;
assign tci_axi_wstrb                = dev_comp_req_o.w.strb;
assign tci_axi_wlast                = dev_comp_req_o.w.last;
assign tci_axi_wvalid               = dev_comp_req_o.w_valid;
assign dev_comp_resp_i.w_ready      = tci_axi_wready;

// ~ B
assign dev_comp_resp_i.b.id         = tci_axi_bid;
assign dev_comp_resp_i.b.user       = tci_axi_buser;
assign dev_comp_resp_i.b.resp       = tci_axi_bresp;
assign dev_comp_resp_i.b_valid      = tci_axi_bvalid;
assign tci_axi_bready               = dev_comp_req_o.b_ready;

// ~ AR
assign tci_axi_arid                 = dev_comp_req_o.ar.id;
assign tci_axi_aruser               = dev_comp_req_o.ar.user;
assign tci_axi_arqos                = dev_comp_req_o.ar.qos;
assign tci_axi_arregion             = dev_comp_req_o.ar.region;
assign tci_axi_arlen                = dev_comp_req_o.ar.len;
assign tci_axi_arsize               = dev_comp_req_o.ar.size;
assign tci_axi_arburst              = dev_comp_req_o.ar.burst;
assign tci_axi_araddr               = dev_comp_req_o.ar.addr;
assign tci_axi_arlock               = dev_comp_req_o.ar.lock;
assign tci_axi_arcache              = dev_comp_req_o.ar.cache;
assign tci_axi_arprot               = dev_comp_req_o.ar.prot;
assign tci_axi_arvalid              = dev_comp_req_o.ar_valid;
assign dev_comp_resp_i.ar_ready     = tci_axi_arready;

// ~ R
assign dev_comp_resp_i.r.id         = tci_axi_rid;
assign dev_comp_resp_i.r.user       = tci_axi_ruser;
assign dev_comp_resp_i.r.data       = tci_axi_rdata;
assign dev_comp_resp_i.r.resp       = tci_axi_rresp;
assign dev_comp_resp_i.r.last       = tci_axi_rlast;
assign dev_comp_resp_i.r_valid      = tci_axi_rvalid;
assign tci_axi_rready               = dev_comp_req_o.r_ready;

// Data Structuress Interface (Master)
// ~ AW
assign dsi_axi_awid                 = ds_req_o.aw.id;
assign dsi_axi_awuser               = ds_req_o.aw.user;
assign dsi_axi_awqos                = ds_req_o.aw.qos;
assign dsi_axi_awregion             = ds_req_o.aw.region;
assign dsi_axi_awatop               = ds_req_o.aw.atop;
assign dsi_axi_awlen                = ds_req_o.aw.len;
assign dsi_axi_awsize               = ds_req_o.aw.size;
assign dsi_axi_awburst              = ds_req_o.aw.burst;
assign dsi_axi_awaddr               = ds_req_o.aw.addr;
assign dsi_axi_awlock               = ds_req_o.aw.lock;
assign dsi_axi_awcache              = ds_req_o.aw.cache;
assign dsi_axi_awprot               = ds_req_o.aw.prot;
assign dsi_axi_awvalid              = ds_req_o.aw_valid;
assign ds_resp_i.aw_ready           = dsi_axi_awready;

// ~ W
assign dsi_axi_wuser                = ds_req_o.w.user;
assign dsi_axi_wdata                = ds_req_o.w.data;
assign dsi_axi_wstrb                = ds_req_o.w.strb;
assign dsi_axi_wlast                = ds_req_o.w.last;
assign dsi_axi_wvalid               = ds_req_o.w_valid;
assign ds_resp_i.w_ready            = dsi_axi_wready;

// ~ B
assign ds_resp_i.b.id               = dsi_axi_bid;
assign ds_resp_i.b.user             = dsi_axi_buser;
assign ds_resp_i.b.resp             = dsi_axi_bresp;
assign ds_resp_i.b_valid            = dsi_axi_bvalid;
assign dsi_axi_bready               = ds_req_o.b_ready;

// ~ AR
assign dsi_axi_arid                 = ds_req_o.ar.id;
assign dsi_axi_aruser               = ds_req_o.ar.user;
assign dsi_axi_arqos                = ds_req_o.ar.qos;
assign dsi_axi_arregion             = ds_req_o.ar.region;
assign dsi_axi_arlen                = ds_req_o.ar.len;
assign dsi_axi_arsize               = ds_req_o.ar.size;
assign dsi_axi_arburst              = ds_req_o.ar.burst;
assign dsi_axi_araddr               = ds_req_o.ar.addr;
assign dsi_axi_arlock               = ds_req_o.ar.lock;
assign dsi_axi_arcache              = ds_req_o.ar.cache;
assign dsi_axi_arprot               = ds_req_o.ar.prot;
assign dsi_axi_arvalid              = ds_req_o.ar_valid;
assign ds_resp_i.ar_ready           = dsi_axi_arready;

// ~ R
assign ds_resp_i.r.id               = dsi_axi_rid;
assign ds_resp_i.r.user             = dsi_axi_ruser;
assign ds_resp_i.r.data             = dsi_axi_rdata;
assign ds_resp_i.r.resp             = dsi_axi_rresp;
assign ds_resp_i.r.last             = dsi_axi_rlast;
assign ds_resp_i.r_valid            = dsi_axi_rvalid;
assign dsi_axi_rready               = ds_req_o.r_ready;


`ifdef RV_IOMMU_PROG_IF_USE_AXI
    // Programming Interface (Slave) (AXI4 Full -> AXI4-Lite -> Reg IF)
    // ~ AW
    assign prog_req_i.aw.id             = cfg_axi_awid;
    assign prog_req_i.aw.user           = cfg_axi_awuser;
    assign prog_req_i.aw.qos            = cfg_axi_awqos;
    assign prog_req_i.aw.region         = cfg_axi_awregion;
    assign prog_req_i.aw.atop           = cfg_axi_awatop;
    assign prog_req_i.aw.len            = cfg_axi_awlen;
    assign prog_req_i.aw.size           = cfg_axi_awsize;
    assign prog_req_i.aw.burst          = cfg_axi_awburst;
    assign prog_req_i.aw.addr           = cfg_axi_awaddr;
    assign prog_req_i.aw.lock           = cfg_axi_awlock;
    assign prog_req_i.aw.cache          = cfg_axi_awcache;
    assign prog_req_i.aw.prot           = cfg_axi_awprot;
    assign prog_req_i.aw_valid          = cfg_axi_awvalid;
    assign cfg_axi_awready              = prog_resp_o.aw_ready;
    
    // ~ W
    assign prog_req_i.w.user            = cfg_axi_wuser;
    assign prog_req_i.w.data            = cfg_axi_wdata;
    assign prog_req_i.w.strb            = cfg_axi_wstrb;
    assign prog_req_i.w.last            = cfg_axi_wlast;
    assign prog_req_i.w_valid           = cfg_axi_wvalid;
    assign cfg_axi_wready               = prog_resp_o.w_ready;
    assign cfg_axi_bid                  = prog_resp_o.b.id;
    assign cfg_axi_buser                = prog_resp_o.b.user;
    assign cfg_axi_bresp                = prog_resp_o.b.resp ;
    assign cfg_axi_bvalid               = prog_resp_o.b_valid;
    assign prog_req_i.b_ready           = cfg_axi_bready;
    
    // ~ AR
    assign prog_req_i.ar.id             = cfg_axi_arid;
    assign prog_req_i.ar.user           = cfg_axi_aruser;
    assign prog_req_i.ar.qos            = cfg_axi_arqos;
    assign prog_req_i.ar.region         = cfg_axi_arregion;
    assign prog_req_i.ar.len            = cfg_axi_arlen;
    assign prog_req_i.ar.size           = cfg_axi_arsize;
    assign prog_req_i.ar.burst          = cfg_axi_arburst;
    assign prog_req_i.ar.addr           = cfg_axi_araddr;
    assign prog_req_i.ar.lock           = cfg_axi_arlock;
    assign prog_req_i.ar.cache          = cfg_axi_arcache;
    assign prog_req_i.ar.prot           = cfg_axi_arprot;
    assign prog_req_i.ar_valid          = cfg_axi_arvalid;
    assign cfg_axi_arready              = prog_resp_o.ar_ready;
    
    // ~ R
    assign cfg_axi_rid                  = prog_resp_o.r.id;
    assign cfg_axi_ruser                = prog_resp_o.r.user;
    assign cfg_axi_rdata                = prog_resp_o.r.data;
    assign cfg_axi_rresp                = prog_resp_o.r.resp;
    assign cfg_axi_rlast                = prog_resp_o.r.last;
    assign cfg_axi_rvalid               = prog_resp_o.r_valid;
    assign prog_req_i.r_ready           = cfg_axi_rready;
`endif // RV_IOMMU_PROG_IF_USE_AXI


// WSI
assign wsi = wsi_wires_o;


riscv_iommu #(
    .IOTLB_ENTRIES   ( 16                         ),
    .DDTC_ENTRIES    ( 8                          ),
    .PDTC_ENTRIES    ( 8                          ),
    .MRIFC_ENTRIES   ( 4                          ),

    .InclPC          ( 1'b1                       ),
    .InclBC          ( 1'b1                       ),
    .InclDBG         ( 1'b1                       ),

    .MSITrans        ( rv_iommu::MSI_FLAT_MRIF    ),
    .IGS             ( rv_iommu::BOTH             ),
    .N_INT_VEC       ( ariane_soc::IOMMUNumWires  ),
    .N_IOHPMCTR      ( 16                         ),

    .ADDR_WIDTH      ( 64                         ),
    .DATA_WIDTH      ( 64                         ),
    .ID_WIDTH        ( ariane_soc::IdWidth        ),
    .ID_SLV_WIDTH    ( ariane_soc::IdWidthSlave   ),
    .USER_WIDTH      ( 1                          ),
    .aw_chan_t       ( ariane_axi_soc::aw_chan_t  ),
    .w_chan_t        ( ariane_axi_soc::w_chan_t   ),
    .b_chan_t        ( ariane_axi_soc::b_chan_t   ),
    .ar_chan_t       ( ariane_axi_soc::ar_chan_t  ),
    .r_chan_t        ( ariane_axi_soc::r_chan_t   ),
    .axi_req_t       ( ariane_axi_soc::req_t      ),
    .axi_rsp_t       ( ariane_axi_soc::resp_t     ),
  `ifdef RV_IOMMU_PROG_IF_USE_AXI
    .axi_req_slv_t   ( ariane_axi_soc::req_slv_t  ),
    .axi_rsp_slv_t   ( ariane_axi_soc::resp_slv_t ),
  `endif // RV_IOMMU_PROG_IF_USE_AXI
    .axi_req_mmu_t   ( ariane_axi_soc::req_mmu_t  ),
    .reg_req_t       ( iommu_reg_req_t            ),
    .reg_rsp_t       ( iommu_reg_rsp_t            ),

    .dc_t            (rv_iommu::dc_base_t         )
) i_riscv_iommu (

    .clk_i           ( clk_i                      ),
    .rst_ni          ( rst_ni                     ),

    // Translation Request Interface (Slave)
    .dev_tr_req_i    ( dev_tr_req_i               ),
    .dev_tr_resp_o   ( dev_tr_resp_o              ),

    // Translation Completion Interface (Master)
    .dev_comp_resp_i ( dev_comp_resp_i            ),
    .dev_comp_req_o  ( dev_comp_req_o             ),

    // Implicit Memory Accesses Interface (Master)
    .ds_resp_i       ( ds_resp_i                  ),
    .ds_req_o        ( ds_req_o                   ),

  `ifdef RV_IOMMU_PROG_IF_USE_AXI
    // Programming Interface (Slave) (AXI4 Full -> AXI4-Lite -> Reg IF)
    .prog_req_i      ( prog_req_i                 ),
    .prog_resp_o     ( prog_resp_o                ),
  `else // RV_IOMMU_PROG_IF_USE_APB
    // Programming Interface (Slave) (APB -> Reg IF)
    .penable_i       ( penable_i                  ),
    .pwrite_i        ( pwrite_i                   ),
    .paddr_i         ( paddr_i[31:0]              ),
    .psel_i          ( psel_i                     ),
    .pwdata_i        ( pwdata_i[31:0]             ),
    .prdata_o        ( prdata_o[31:0]             ),
    .pready_o        ( pready_o                   ),
    .pslverr_o       ( pslverr_o                  ),
  `endif // RV_IOMMU_PROG_IF_USE_AXI

    .wsi_wires_o     ( wsi_wires_o[(ariane_soc::IOMMUNumWires-1):0] )
);

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")


