/*************************************************************************************/
/***************************    Actor : yehia shahin      ****************************/
/***************************    Project : Adder testbench ****************************/
/***************************    Target : UVM_sv           ****************************/
/*************************************************************************************/
/*************************************************************************************/

bit running  = 1 ; 
interface intf (input bit clk) ; 
 logic  a , b , rst , q ;
  
  clocking cb @(posedge clk);
    output  d ,rst ; 
  endclocking
  
  modport dut (input clk , input d ,input rst , output q );
  modport tb (clocking cb); 
endinterface

package pack1 ; 



import uvm_pkg::*;
`include "uvm_macros.svh"
// add_sequence is child of uvm_sequence_item
class add_sequence_item extends uvm_sequence_item ; 
  `uvm_object_utils(add_sequence_item);
  
  function new (string name = "add_sequence_item");
    super.new(name);
  endfunction 
  
  
  
endclass

class add_sequence extends uvm_sequence ;
  
  `uvm_object_utils(add_sequence);
  function new (string name = "add_sequence");
    super.new(name);
  endfunction 
  
endclass

/************************************************************************/
class add_driver extends uvm_driver  #(add_sequence_item);
  virtual intf.tb local_vif ; 

   
  `uvm_component_utils (add_driver) ; 
  function new (string name = "add_driver",uvm_component parent = null );
    super.new(name,parent);
  endfunction 
    

  function void build_phase (uvm_phase phase);
    void'(uvm_config_db#(virtual intf.tb)::get(this , "", "my_vif", local_vif));
    $display ("ryfuheifhie");
  endfunction

  
  function void connect_phase (uvm_phase phase);
    
    
  endfunction  
      
  task run_phase (uvm_phase phase);
    
    
  endtask 
  
endclass

/***********************************************************************************/
class add_monitor extends uvm_monitor; 
  
  `uvm_component_utils (add_monitor);
  function new (string name = "add_monitor",uvm_component parent = null);
    super.new(name,parent);
    
  endfunction 
  
  function void build_phase (uvm_phase phase);
    virtual intf.tb local_vif ; 
    uvm_config_db#(virtual intf.tb):: get(this , "", "my_vif1", local_vif);
    $display ("monitor component ");
    
  endfunction
  
  function void connect_phase (uvm_phase phase );
    
    
  endfunction 
  
  task run_phase (uvm_phase phase);
  
    
  endtask 
  
  
endclass
/***********************************************************************************/

class add_sequencer  extends uvm_sequencer#(add_sequence_item) ; 
  
  `uvm_component_utils(add_sequencer);
  function new (string name = "add_sequencer", uvm_component parent = null);
    super.new(name,parent); 
  endfunction 
  
  function void build_phase (uvm_phase phase);
    $display ("the sequencer component ");
    
  endfunction
  
  function void connect_phase (uvm_phase phase);
    
  endfunction
  
  task run_phase (uvm_phase phase);
    
  endtask 
  
  
endclass
/***********************************************************************************/

class add_agent extends uvm_agent ;
  
   // sequencer , monitor , driver , virtual_interface
  `uvm_component_utils(add_agent);
  
  add_driver O_add_driver ; 
  add_monitor O_add_monitor ;
  add_sequencer O_add_sequencer ; 
  
  function new (string name = "add_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  function void build_phase (uvm_phase phase);
    virtual intf.tb local_vif;
    O_add_driver = add_driver::type_id::create ("O_add_driver",this);
    O_add_monitor = add_monitor ::type_id::create("O_add_monitor",this);
    O_add_sequencer=add_sequencer::type_id::create("O_add_sequencer",this);
    if (!uvm_config_db#(virtual intf.tb):: get(this , "", "my_vif", local_vif))
      `uvm_fatal(get_full_name(),"error");
    uvm_config_db #(virtual intf.tb) :: set (this, "O_add_driver","my_vif",local_vif);
    uvm_config_db #(virtual intf.tb) :: set (this, "O_add_monitor","my_vif1",local_vif);
    $display ("the agent component");

    
  endfunction 
  
  function void connect_phase (uvm_phase phase);
    
  endfunction 
  
  task run_phase (uvm_phase phase);
    
  endtask
  
  
endclass 
/***********************************************************************************/

class add_scoreboard extends uvm_scoreboard ; 

  `uvm_component_utils(add_scoreboard);
  function new (string name = "add_scoreboard", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    
    $display ("subscriber component ");
  endfunction 
  
  function void connect_phase (uvm_phase phase);
    
  endfunction 
  
  task run_phase (uvm_phase phase); 
    
  endtask 
  
endclass
/***********************************************************************************/
/*
class add_subscriber extends uvm_subscriber #(2) ; 
  `uvm_component_utils(add_subscriber);
  function new (string name = "add_subscriber", uvm_component parent = null ); 
    super.new(name,parent); 
  endfunction 
  
  
  function void build_phase (uvm_phase phase );
    
  endfunction 
  
  function void connect_phase (uvm_phase phase ); 
    
  endfunction 
  
  task run_phase (uvm_phase phase );
    
  endtask 
  
endclass
*/

/***********************************************************************************/

class add_env extends uvm_env ; 
  
  // agent , scoreboard , subscriber 
  add_agent O_add_agent ; 
  add_scoreboard O_add_scoreboard ; 
 // add_subscriber O_add_subscriber;
  virtual intf.tb local_vif ; 
  
  `uvm_component_utils(add_env);//registration 
  
  function new (string name = "add_env" , uvm_component parent = null );
    super.new(name,parent); 
  endfunction 
  
  function void build_phase (uvm_phase phase );
    O_add_agent = add_agent :: type_id :: create("O_add_agent",this);
    O_add_scoreboard = add_scoreboard :: type_id :: create("O_add_scoreboard",this);
    
    if (!uvm_config_db#(virtual intf.tb)::get(this,"","my_vif",local_vif))
      `uvm_fatal (get_full_name(),"Error");
    uvm_config_db#(virtual intf.tb) :: set(this ,"O_add_agent","my_vif",local_vif);
    $display ("the enviroment component");


    //O_add_subscriber = add_subscriber :: type_id :: create ("O_add_subscriber",this);
    
  endfunction 
  
  function void connect_phase (uvm_phase phase );
    
  endfunction 
  
  task run_phase (uvm_phase phase ); 
    
  endtask 
endclass
/***********************************************************************************/

class add_test extends uvm_test ; 
  `uvm_component_utils (add_test);
  add_env O_add_env ; 
  add_sequence O_add_sequence ; 
  
  function new (string name = "add_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  function void build_phase (uvm_phase phase );
    
    virtual intf.tb local_vif ; 
    O_add_env = add_env::type_id::create("O_add_env",this);
    O_add_sequence = add_sequence::type_id::create ("O_add_sequence");
    
    if (!uvm_config_db#(virtual intf.tb)::get(this,"","my_vif",local_vif))
      `uvm_fatal(get_full_name(),"error");
    uvm_config_db#(virtual intf.tb)::set(this, "O_add_env","my_vif",local_vif);
    
    $display("the test component");

  endfunction 
  
  function void connect_phase (uvm_phase phase );
    
  endfunction 
  
  task run_phase (uvm_phase phase ); 
    
  endtask 
  
endclass
endpackage


module test_bench (intf.tb intf_t); 
  import pack1::*; 
  
  initial begin 
    uvm_config_db #(virtual intf.tb)::set(null,"uvm_test_top","my_vif",intf_t);
    run_test("add_test"); // initial the phasses
  end
  
endmodule 

module top ; 
  bit clk ; 
 	
  intf intf1 (clk) ;
  adder adder (intf1.dut);
  test_bench t1 (intf1.tb); 
  initial begin 
  while (running == 1 ) begin 
    #5 clk = ~clk ; 
  end
  end
endmodule



