class fifo_ctl_reg extends uvm_reg;
  `uvm_object_utils(fifo_ctl_reg)
   
  //---------------------------------------
  // fields instance 
  //--------------------------------------- 
  rand uvm_reg_field fifo_empty;
  rand uvm_reg_field fifo_full;
  rand uvm_reg_field fifo_overflow;
  rand uvm_reg_field fifo_underflow;
  rand uvm_reg_field fifo_reg_write;

  //---------------------------------------
  // Constructor 
  //---------------------------------------   
  function new (string name = "fifo_ctl_reg");
    super.new(name,8,UVM_NO_COVERAGE); //8 -> Register Width
  endfunction

 
  function void build; 
    
    // Create bitfield
    fifo_empty = uvm_reg_field::type_id::create("fifo_empty");  
    fifo_full = uvm_reg_field::type_id::create("fifo_full");   
    fifo_overflow = uvm_reg_field::type_id::create("fifo_overflow");   
    fifo_underflow = uvm_reg_field::type_id::create("fifo_underflow");   
    fifo_reg_write = uvm_reg_field::type_id::create("fifo_reg_write");    
    // Configure
    fifo_empty.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(0),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h1),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
      fifo_full.configure(.parent(this),
                   .size(1), 
                   .lsb_pos(1),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
     fifo_overflow.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(2),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
     fifo_underflow.configure(.parent(this),
                   .size(1), 
                   .lsb_pos(3),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   

      fifo_reg_write.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(4),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
    endfunction
endclass
//-----------------------------------------------------------------------------------------------------------
class fifo_mem_reg extends uvm_reg;
  `uvm_object_utils(fifo_mem_reg)
   
  //---------------------------------------
  // fields instance 
  //--------------------------------------- 
   uvm_reg_field last_out;
   uvm_reg_field last_in;
   uvm_reg_field depth;

  //---------------------------------------
  // Constructor 
  //---------------------------------------   
  function new (string name = "fifo_mem_reg");
    super.new(name,32,UVM_NO_COVERAGE); //32 -> Register Width
  endfunction

 
  function void build; 
    
    // Create bitfield
    last_out = uvm_reg_field::type_id::create("last_out");  
    last_in = uvm_reg_field::type_id::create("last_in");   
    depth = uvm_reg_field::type_id::create("depth");   
        // Configure
    last_out.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(31),  
                   .access("RO"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(0));   
      last_in.configure(.parent(this),
                   .size(1), 
                   .lsb_pos(0),  
                   .access("RO"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(0));   
     depth.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(8),  
                   .access("RO"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(0));   
 
    endfunction
endclass
