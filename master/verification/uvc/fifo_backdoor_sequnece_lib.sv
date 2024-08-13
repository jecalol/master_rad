class fifo_bempty_sequence extends uvm_sequence #(fifo_item);
    
      fifo_item req;
  
	
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_bempty_sequence)
      

   `uvm_object_utils_end
    
  
    extern function new(string name = "fifo_bempty_sequence"); 
    extern virtual task body();   
endclass : fifo_empty_sequence

//-------------------------------------------------------------------
function fifo_bempty_sequence::new(string name = "fifo_bempty_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_bempty_sequence::body();
   

   
endtask : body
//---------------------------------------------------------------------
class fifo_empty_read_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
 uvm_status_e status;
	bit[7:0] rdata;
	
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_empty_read_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "fifo_empty_read_back_sequence"); 
    extern virtual task body();   
endclass : fifo_empty_read_back_sequence

//-------------------------------------------------------------------
function fifo_empty_read_back_sequence::new(string name = "fifo_empty_read_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_empty_read_back_sequence::body();
	p_sequencer.regmodel.STAT_REG.fifo_empty.read(status,  rdata, UVM_BACKDOOR);

	`uvm_do_with (req, {read==1'b1; addr==0;}); //reads from empty fifo
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
endtask : body
//---------------------------------------------------------------------------------------------

class fifo_full_read_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_full_read_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "fifo_full_read_back_sequence"); 
    extern virtual task body();   
endclass : fifo_full_read_sequence
//-------------------------------------------------------------------
function fifo_full_read_back_sequence::new(string name = "fifo_full_read_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_full_read_back_sequence::body();
	for (int i=0; i<16; i++)begin
	`uvm_do_with (req, {write==1'b1; addr==0;});
	end
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to full
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
endtask : body
//------------------------------------------------------------------
//------------------------------------------------------------
class mem_reg_base_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(mem_reg_base_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "mem_reg_base_back_sequence"); 
    extern virtual task body();   
endclass : mem_reg_base_back_sequence
//-------------------------------------------------------------------
function mem_reg_base_back_sequence::new(string name = "mem_reg_base_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task mem_reg_base_back_sequence::body();
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	p_sequencer.regmodel.MEM_REG.read(status,  rdata);
	`uvm_do_with (req, {read==1'b1; addr==0;});//reads fifo
	p_sequencer.regmodel.MEM_REG.read(status,  rdata);
endtask : body
//------------------------------------------------------------
class mem_reg_rand_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(mem_reg_rand_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "mem_reg_rand_back_sequence"); 
    extern virtual task body();   
endclass : mem_reg_rand_back_sequence
//-------------------------------------------------------------------
function mem_reg_rand_back_sequence::new(string name = "mem_reg_rand_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task mem_reg_rand_back_sequence::body();
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	p_sequencer.regmodel.MEM_REG.read(status,  rdata);
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	p_sequencer.regmodel.MEM_REG.read(status,  rdata);
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	p_sequencer.regmodel.MEM_REG.read(status,  rdata);
endtask : body
//------------------------------------------------------------
class stat_reg_rand_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(stat_reg_rand_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "stat_reg_rand_back_sequence"); 
    extern virtual task body();   
endclass : stat_reg_rand_back_sequence
//-------------------------------------------------------------------
function stat_reg_rand_back_sequence::new(string name = "stat_reg_rand_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task stat_reg_rand_back_sequence::body();
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
endtask : body
//------------------------------------------------------------
class stat_clr_back_sequence extends fifo_bempty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(stat_clr_back_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "stat_clr_back_sequence"); 
    extern virtual task body();   
endclass : stat_clr_back_sequence
//-------------------------------------------------------------------
function stat_clr_back_sequence::new(string name = "stat_clr_back_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task stat_clr_back_sequence::body();
	for (int i =0; i <12; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	//p_sequencer.regmodel.STAT_REG.fifo_reg_write(status,  1'b1);
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
endtask : body
