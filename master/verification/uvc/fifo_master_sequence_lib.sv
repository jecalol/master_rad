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
	`uvm_do_with (req, {write==1'b1; addr==0;}); 
	#100;
	`uvm_do_with (req, {read==1'b1; addr==2'b00;}); 
	#100;
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
	//`uvm_do_with (req, {read==1'b1; addr==1;}); //checks empty bit
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	`uvm_do_with (req, {write==1'b1; addr==0;}); //reads from empty fifo
	p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	//`uvm_do_with (req, {read==1'b1; addr==1;}); //checks for underflow bit 
endtask : body
//---------------------------------------------------------------------------------------------

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
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs for full*/
	for (int i=0; i<16; i++)begin
	`uvm_do_with (req, {write==1'b1; addr==0;});
	end
	//p_sequencer.regmodel.STAT_REG.read(status,  rdata);
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs for full*/
	`uvm_do_with (req, {write==1'b1; addr==0;});//writes to full
	`uvm_do_with (req, {read==1'b1; addr==1;}); //chekcs for overflow*/
	//p_sequencer.regmodel.STAT_REG.read(status,  rdata);
endtask : body



