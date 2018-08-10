 ///////////////////////////////////////////////////////////////////////////////
 //
 // Project:  Aurora 64B/66B
 // Company:  Xilinx
 //
 //
 //
 // (c) Copyright 2008 - 2009 Xilinx, Inc. All rights reserved.
 //
 // This file contains confidential and proprietary information
 // of Xilinx, Inc. and is protected under U.S. and
 // international copyright and other intellectual property
 // laws.
 //
 // DISCLAIMER
 // This disclaimer is not a license and does not grant any
 // rights to the materials distributed herewith. Except as
 // otherwise provided in a valid license issued to you by
 // Xilinx, and to the maximum extent permitted by applicable
 // law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 // WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 // AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 // BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 // INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 // (2) Xilinx shall not be liable (whether in contract or tort,
 // including negligence, or under any other theory of
 // liability) for any loss or damage of any kind or nature
 // related to, arising under or in connection with these
 // materials, including for any direct, or any indirect,
 // special, incidental, or consequential loss or damage
 // (including loss of data, profits, goodwill, or any type of
 // loss or damage suffered as a result of any action brought
 // by a third party) even if such damage or loss was
 // reasonably foreseeable or Xilinx had been advised of the
 // possibility of the same.
 //
 // CRITICAL APPLICATIONS
 // Xilinx products are not designed or intended to be fail-
 // safe, or for use in any application requiring fail-safe
 // performance, such as life-support or safety devices or
 // systems, Class III medical devices, nuclear facilities,
 // applications related to the deployment of airbags, or any
 // other applications that could lead to death, personal
 // injury, or severe property or environmental damage
 // (individually and collectively, "Critical
 // Applications"). Customer assumes the sole risk and
 // liability of any use of Xilinx products in Critical
 // Applications, subject only to applicable laws and
 // regulations governing limitations on product liability.
 //
 // THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 // PART OF THIS FILE AT ALL TIMES.
 
 //
 ///////////////////////////////////////////////////////////////////////////////
 //
 //  aurora_64b66b_0_TB
 //
 //  Aurora Generator
 //
 //
 //  Description:  This testbench instantiates 2 Aurora Example Modules. The serial TX pins from  
 //                one module are connected to the RX pins of the other and vice versa. A simple AXI4-Stream based
 //                frame generator is used to generate packets for the TX data interface while a frame checker
 //                module is connected to the RX data interface to check the incoming frames and keep 
 //                track of any errors.
 //         
 ///////////////////////////////////////////////////////////////////////////////
 
 `timescale 1 ns / 1 ps
 
 module aurora_64b66b_0_TB;
 
 //*************************Parameter Declarations**************************
    parameter          TIME_UNIT  = 1; // Do not modify this parameter. 
    parameter          USR_CLK_PCOUNT  = 210; // Do not modify this parameter. 
       parameter       USER_CLK_PERIOD = 20.48*TIME_UNIT;
     parameter       SIM_MAX_TIME  = 99999999*TIME_UNIT;//3000000000; //To quit the simulation
     parameter       DCLK_PERIOD   = 16.667*TIME_UNIT; //60 MHz CLK
     parameter       CLOCKPERIOD_1 = 6.400	*TIME_UNIT; 
     parameter       CLOCKPERIOD_2 = 6.400	*TIME_UNIT; 

     parameter       INIT_CLOCKPERIOD_1 = 20.000	*TIME_UNIT; 
     parameter       INIT_CLOCKPERIOD_2 = 20.000	*TIME_UNIT; 
     parameter       DRP_CLOCKPERIOD_1  = 10.000	*TIME_UNIT; 
     parameter       DRP_CLOCKPERIOD_2  = 10.000	*TIME_UNIT; 
     
     parameter       US = 1000; // 1 us

 //************************Internal Register Declarations*****************************
 
     //Freerunning Clock
       reg                reference_clk_1_n_r; 
       reg                reference_clk_2_n_r; 

       reg                init_clk_1_n_r; 
       reg                init_clk_2_n_r; 

       reg                drp_clk_1_r; 
       reg                drp_clk_2_r; 
       wire               drp_clk_1; 
       wire               drp_clk_2;          
 
     //Global signals
       reg                gsr_r; 
       reg                gts_r; 
       reg                reset_i_1;
       reg                reset_i_2;
       reg                pma_init_r; 
       reg       gsr_done;            //Indicates the deassertion of GSR    
     
 
 //********************************Wire Declarations**********************************
     
     //Freerunning Clock         
       wire               reference_clk_1_p_r; 
       wire               reference_clk_2_p_r;          
       wire               init_clk_1_p_r; 
       wire               init_clk_2_p_r;          
 
 
 //Dut1
 
     //Error Detection Interface
       wire               hard_err_1_i;         
       wire               soft_err_1_i;         
 
     //Status 
       wire               channel_up_1_i;         
       wire               lane_up_1_i; 
 
 
     //GTX Serial I/O
       wire               rxp_1_i;  
       wire               rxn_1_i;  
     
       wire               txp_1_i;  
       wire               txn_1_i;  
       wire               dtxn_1_i;
       wire               dtxp_1_i;
     // Error signals from the frame checker
       wire    [0:7]      data_err_count_1_o;  
 
 //Dut2
 
     //Error Detection Interface
       wire               hard_err_2_i;         
       wire               soft_err_2_i;         
 
     //Status 
       wire               channel_up_2_i;         
       wire               lane_up_2_i; 
 
 
     //GTX Serial I/O
       wire               rxp_2_i;  
       wire               rxn_2_i;  
     
       wire               txp_2_i;  
       wire               txn_2_i;  
       wire               dtxp_2_i;
       wire               dtxn_2_i;
     // Error signals from the frame checker
       wire    [0:7]      data_err_count_2_o;  
 
       reg      flag_rxtvalid1 = 1'b0;
       reg      flag_rxtvalid2 = 1'b0;


       reg      channel_up1 = 1'b0;
       reg      channel_up2 = 1'b0;
       reg      flag        = 1'b0;
       reg      flag_1      = 1'b0;
       reg      flag_2      = 1'b1;
       reg      flag_3      = 1'b0;
       reg      flag_4      = 1'b1;
       
//       wire crxn_1_i, crxp_1_i, crxn_2_i, crxn_2_i;
       reg connect;
       reg en1;
       reg en2;
       reg en3;
       reg en4;
       reg nodelay1;
       reg nodelay2;
       reg nodelay3;
       reg nodelay4;
       
delay d1(txn_1_i, dtxn_1_i, reset_i_1, init_clk_1_n_r, en1, nodelay1);  
           
delay d2(txp_1_i, dtxp_1_i, reset_i_1, init_clk_1_p_r, en2, nodelay2);

delay d3(txn_2_i, dtxn_2_i, reset_i_2, init_clk_2_n_r, en3, nodelay3);

delay d4(txp_2_i, dtxn_2_i, reset_i_2, init_clk_2_p_r, en4, nodelay4);

 //*********************************Main Body of Code**********************************
 
 
     //________________________ Tie offs ___________________________________
     
     wire   tied_to_ground_i     =    1'b0;
     
     //_________________________GTX Serial Connections________________
    
 
     assign   rxn_1_i      =    connect ? txn_2_i : 1'bx;
     assign   rxp_1_i      =    connect ? txp_2_i : 1'bx;
     assign   rxn_2_i      =    connect ? txn_1_i : 1'bx;
     assign   rxp_2_i      =    connect ? txp_1_i : 1'bx;
     
    
     //__________________________Global Signals_____________________________
     
     //Simultate the global reset that occurs after configuration at the beginning
     //of the simulation. Note that both GTX swift models use the same global signals.
   //  assign glbl.GSR = gsr_r;
   //  assign glbl.GTS = gts_r;
 
     initial
         begin
            gts_r      = 1'b0;        
            gsr_r      = 1'b1;
            gsr_done   = 1'b0;
            pma_init_r = 1'b1;
            reset_i_1 = 1'b1;
            reset_i_2 = 1'b1;
            
            connect = 1;
            en1 = 0;
            en2 = 0;
            en3 = 0;
            en4 = 0;
            nodelay1 = 1;
            nodelay2 = 1;
            nodelay3 = 1;
            nodelay4 = 1;
            //#(160*INIT_CLOCKPERIOD_1);
            repeat(160) @(posedge init_clk_1_n_r);
            gsr_r      = 1'b0;
            gsr_done   = 1'b1;
            pma_init_r = 1'b0;
            #(60*TIME_UNIT) 
            reset_i_1 = 1'b0;
            reset_i_2 = 1'b0;
            
            @(posedge channel_up_1_i) connect = 0;
            #(20 * US) connect = 1;
            
            @(posedge channel_up_1_i) connect = 0;
            #(10 * US);
            reset_i_1 = 1'b1;
            #(10 * US);
            reset_i_1 = 1'b0;
            connect = 1;
            repeat(30)@(posedge init_clk_1_n_r);
            nodelay1 = 0;
            repeat(30)@(posedge init_clk_1_p_r);
            nodelay2 = 0;
            repeat(30)@(posedge init_clk_2_n_r);
            nodelay3 = 0;
            repeat(30)@(posedge init_clk_2_p_r);
            nodelay4 = 0;
            
            @(posedge channel_up_1_i) connect = 0;
            reset_i_1 = 1'b1;
            reset_i_2 = 1'b1;   
            #(20 * US);
            reset_i_1 = 1'b0;
            reset_i_2 = 1'b0;   
            connect = 1;
            
            
     end
 
 
     //____________________________Clocks____________________________
 
     initial reference_clk_1_n_r = 1'b0;
 
 
     always #(CLOCKPERIOD_1 / 2) reference_clk_1_n_r = !reference_clk_1_n_r;
 
     assign reference_clk_1_p_r = !reference_clk_1_n_r;
 
 
 
     initial reference_clk_2_n_r = 1'b0;
 
 
     always #(CLOCKPERIOD_2 / 2) reference_clk_2_n_r = !reference_clk_2_n_r;
 
     assign reference_clk_2_p_r = !reference_clk_2_n_r;
 
 
     //--------------------------------------------------------------
 
     initial init_clk_1_n_r = 1'b0;
 
 
     always #(INIT_CLOCKPERIOD_1 / 2) init_clk_1_n_r = !init_clk_1_n_r;
 
     assign init_clk_1_p_r = !init_clk_1_n_r;
 
 
 
     initial init_clk_2_n_r = 1'b0;
 
 
     always #(INIT_CLOCKPERIOD_2 / 2) init_clk_2_n_r = !init_clk_2_n_r;
 
     assign init_clk_2_p_r = !init_clk_2_n_r;
 
 
     //--------------------------------------------------------------
     //____________________________DRP Clock_________________________
 
     initial drp_clk_1_r = 1'b0;
 
 
     always #(DRP_CLOCKPERIOD_1 / 2) drp_clk_1_r = !drp_clk_1_r;
 
     assign drp_clk_1 = !drp_clk_1_r;
 
 
 
     initial drp_clk_2_r = 1'b0;
 
 
     always #(DRP_CLOCKPERIOD_2 / 2) drp_clk_2_r = !drp_clk_2_r;
 
     assign drp_clk_2 = !drp_clk_2_r;
 
 
 
 
     //____________________________Resets____________________________
     
 
     //________________________Instantiate Dut 1 ________________
 
aurora_64b66b_0_exdes aurora_example_1_i
 (
     // User IO
     .RESET(reset_i_1),
     // Error signals from Aurora    
     .HARD_ERR			(hard_err_1_i),
     .SOFT_ERR			(soft_err_1_i),
 
     // Status Signals
     .LANE_UP(lane_up_1_i),
     .CHANNEL_UP		(channel_up_1_i),
 
 
     .INIT_CLK_P		(init_clk_1_p_r),
     .INIT_CLK_N		(init_clk_1_n_r),
     .PMA_INIT			(pma_init_r),
     .DRP_CLK_IN		(drp_clk_1),
 
     // Clock Signals
     .GTXQ1_P		(reference_clk_1_p_r),
     .GTXQ1_N		(reference_clk_1_n_r),
 
     // GT I/O
     .RXP			(rxp_1_i),
     .RXN			(rxn_1_i),
 
     .TXP			(txp_1_i),
     .TXN			(txn_1_i),

     // Error signals from the frame checker
     .DATA_ERR_COUNT		(data_err_count_1_o)
 );
 
     //________________________Instantiate Dut 2 ________________
 
aurora_64b66b_0_exdes aurora_example_2_i
 (
     // User IO
     .RESET(reset_i_2),
     // Error signals from Aurora    
     .HARD_ERR			(hard_err_2_i),
     .SOFT_ERR			(soft_err_2_i),
 
     // Status Signals
     .LANE_UP(lane_up_2_i),
     .CHANNEL_UP		(channel_up_2_i),
 
 
     .INIT_CLK_P		(init_clk_2_p_r),
     .INIT_CLK_N		(init_clk_2_n_r),
     .PMA_INIT			(pma_init_r),
     .DRP_CLK_IN		(drp_clk_2),
 
     // Clock Signals
     .GTXQ1_P		(reference_clk_2_p_r),
     .GTXQ1_N		(reference_clk_2_n_r),
 
     // GT I/O
     .RXP			(rxp_2_i),
     .RXN			(rxn_2_i),
 
     .TXP			(txp_2_i),
     .TXN			(txn_2_i),

     // Error signals from the frame checker
     .DATA_ERR_COUNT		(data_err_count_2_o)
 );
 

 always @(posedge aurora_example_1_i.rx_tvalid_r)
 begin
     flag_rxtvalid1 = 1'b1;
 end

 always @(posedge aurora_example_2_i.rx_tvalid_r)
 begin
     flag_rxtvalid2 = 1'b1;
 end
 
 
 
//     always @ (posedge channel_up_1_i or posedge channel_up_2_i or
//               posedge data_err_count_1_o or posedge data_err_count_2_o)
//     begin
//        if(channel_up_1_i == 1 && !channel_up1)
//        begin
//           $display("\n## aurora_64b66b_0_TB : @Time : %0t CHANNEL_UP is asserted in DUT1\n",$time);
//           channel_up1 = 1'b1;
//        end
  
//        if(channel_up_2_i == 1 && !channel_up2)
//        begin
//           $display("\n## aurora_64b66b_0_TB : @Time : %0t CHANNEL_UP is asserted in DUT2\n",$time);
//           channel_up2 = 1'b1;
//        end
 
//        if((data_err_count_1_o >  8'd0) || ( data_err_count_2_o >  8'd0))
//        begin
//           $display("\n## aurora_64b66b_0_TB : @Time : %0t ERROR : Test Fail\n",$time);
////           #(2000*TIME_UNIT) $finish;
//        end
           
//        if(channel_up_1_i == 1 && channel_up_2_i == 1)
//        begin
//           #(USR_CLK_PCOUNT*USER_CLK_PERIOD); 
//           if(!((|data_err_count_1_o)  | (|data_err_count_2_o)))
//           begin
//            if (flag_rxtvalid1 == 1 && flag_rxtvalid2 == 1)
//              $display("\n## aurora_64b66b_0_TB : @Time : %0t Test Completed Successfully\n",$time);
//            else
//              $display("\n## aurora_64b66b_0_TB : @Time : %0t Test Completed; no transactions\n",$time);
////              $finish;
//           end
//           else
//           begin
//              $display("\n## aurora_64b66b_0_TB : @Time : %0t Test Fail\n",$time);
////              $finish;
//           end
//        end
//     end
 
//    //Abort the simulation when it reaches to max time limit
//    initial
//    begin
//      #(SIM_MAX_TIME) $display("\n aurora_64b66b_0_TB : @Time : %0t ERROR : Reached max. simulation time limit\n",$time);
//      $display("\n channel_up_2_i : %0h  channel_up_1_i : %0h   lane_up_2_i : %0h  lane_up_1_i :%0h ",channel_up_2_i,channel_up_1_i,lane_up_2_i,lane_up_1_i);
//      $finish;
//    end
 
 endmodule
