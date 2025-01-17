class fifo_empty_sequence extends uvm_sequence #(fifo_item);
    
      fifo_item req;
  
	
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_empty_sequence)
      

   `uvm_object_utils_end
    
  
    extern function new(string name = "fifo_empty_sequence"); 
    extern virtual task body();   
endclass : fifo_empty_sequence

//-------------------------------------------------------------------
function fifo_empty_sequence::new(string name = "fifo_empty_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_empty_sequence::body();
   

   
endtask : body
//----------------------------------------------------------------------------------------


class fifo_basic_sequence extends fifo_empty_sequence;
   fifo_item req;

	
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_basic_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "fifo_basic_sequence"); 
    extern virtual task body();   
endclass : fifo_basic_sequence

//-------------------------------------------------------------------
function fifo_basic_sequence::new(string name = "fifo_basic_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_basic_sequence::body();
   for (int i=0; i <5; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;}); 
	#100;
   end 
   for (int i=0; i <5; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;}); 
	#100;
   end
	//`uvm_do_with (req, {read==1'b1; addr==2'b10;}); 
endtask : body
//---------------------------------------------------------------------------------------------


class fifo_empty_read_sequence extends fifo_empty_sequence;
   fifo_item req;
 uvm_status_e status;
	bit[7:0] rdata;
	
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_empty_read_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "fifo_empty_read_sequence"); 
    extern virtual task body();   
endclass : fifo_empty_read_sequence

//-------------------------------------------------------------------
function fifo_empty_read_sequence::new(string name = "fifo_empty_read_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_empty_read_sequence::body();
	`uvm_do_with (req, {read==1'b1; addr==2'b01;}); //checks empty bit
	`uvm_do_with (req, {read==1'b1; addr==2'b01;}); //reads from empty fifo
	`uvm_do_with (req, {read==1'b1; addr==2'b01;}); //checks for underflow bit 
endtask : body
//---------------------------------------------------------------------------------------------
//------------------------------------------------------------
class fifo_full_read_sequence extends fifo_empty_sequence;
   fifo_item req;
   uvm_status_e status;
	bit[7:0] rdata;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(fifo_full_read_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "fifo_full_read_sequence"); 
    extern virtual task body();   
endclass : fifo_full_read_sequence
//-------------------------------------------------------------------
function fifo_full_read_sequence::new(string name = "fifo_full_read_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task fifo_full_read_sequence::body();
	for (int i=0; i<16; i++)begin
	`uvm_do_with (req, {write==1'b1; addr==0;});
	end
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs for full*/
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to full
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs for overflow*
endtask : body
//------------------------------------------------------------
class mem_reg_base_sequence extends fifo_empty_sequence;
   fifo_item req;
   uvm_status_e status;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(mem_reg_base_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "mem_reg_base_sequence"); 
    extern virtual task body();   
endclass : mem_reg_base_sequence
//-------------------------------------------------------------------
function mem_reg_base_sequence::new(string name = "mem_reg_base_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task mem_reg_base_sequence::body();
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==2;}); //chekcs mem*/
	`uvm_do_with (req, {read==1'b1; addr==0;});//reads fifo
	`uvm_do_with (req, {read==1'b1; addr==2;}); //chekcs mem*/
endtask : body
//------------------------------------------------------------
class mem_reg_rand_sequence extends fifo_empty_sequence;
   fifo_item req;
   uvm_status_e status;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(mem_reg_rand_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "mem_reg_rand_sequence"); 
    extern virtual task body();   
endclass : mem_reg_rand_sequence
//-------------------------------------------------------------------
function mem_reg_rand_sequence::new(string name = "mem_reg_rand_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task mem_reg_rand_sequence::body();
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==2;}); //chekcs mem*/
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==2;}); //chekcs mem*/
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==2;}); //chekcs mem*/
endtask : body
//------------------------------------------------------------
class stat_reg_rand_sequence extends fifo_empty_sequence;
   fifo_item req;
   uvm_status_e status;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(mem_reg_rand_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "stat_reg_rand_sequence"); 
    extern virtual task body();   
endclass : stat_reg_rand_sequence
//-------------------------------------------------------------------
function stat_reg_rand_sequence::new(string name = "stat_reg_rand_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task stat_reg_rand_sequence::body();
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs stat*/
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs stat*/
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs stat*/
endtask : body
//------------------------------------------------------------
class stat_clr_sequence extends fifo_empty_sequence;
   fifo_item req;
   uvm_status_e status;
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils_begin(stat_clr_sequence)


   `uvm_object_utils_end
    
   
    extern function new(string name = "stat_clr_sequence"); 
    extern virtual task body();   
endclass : stat_clr_sequence
//-------------------------------------------------------------------
function stat_clr_sequence::new(string name = "stat_clr_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task stat_clr_sequence::body();
	for (int i =0; i <12; i++)begin 
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to fifo
	end 
	for (int i =0; i <6; i++)begin 
	`uvm_do_with (req, {read==1'b1; addr==0;});//writes to fifo
	end 
	`uvm_do_with (req, {write==1'b1; addr==1;wdata[4]==1;});//writes to fifo
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs stat*/
endtask : body







