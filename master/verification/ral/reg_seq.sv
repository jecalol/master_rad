class req_seq extends uvm_sequence;




  fifo_reg_block  regmodel;   
   `uvm_declare_p_sequencer(fifo_master_sequencer)	
   `uvm_object_utils(fifo_polling_sequence)
      

    
    extern function new(string name = "req_seq"); 
    extern virtual task body();   
endclass : req_seq

//-------------------------------------------------------------------
function req_seq::new(string name = "req_seq");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task req_seq::body();

    uvm_reg_data_t m_data;
    uvm_status_e   m_status;
    uvm_reg        m_reg;
    if (starting_phase != null)
      starting_phase.raise_objection(this);
     m_reg = field_name.get_parent();
    fork
        begin
            m_reg.read(m_status, m_data, UVM_BACKDOOR);
            while(m_data != value_to_be_polled)begin
                #(polling_interval * 1ns);
                m_reg.read(m_status, m_data, UVM_BACKDOOR);
            end 
        end
        begin
            #(polling_duration * 1ns);
            `uvm_error(get_type_name(), "Maximum polling duration reached")
        end
    join_any
    disable fork;

    
    //Do this in the order you prefer + the tasks from the presentation :)
    // try backdoor access -> write a repeat which writes random data to a certain register and show this in waves (note: backdoor does not consume simulation time, and you need to show that the register value changes on the waves) -> backdoor paths need to be added
    // try printing the value of one field of one register 
    // try printing the whole path of all registers in the ral model using the proper function (note: you first need to get all registers, and then use foreach to show the paths) 
    // try reseting the register to default value
    // write data only to one field of a register
    // print the type of all registers using the proper function
    // print all fields of all registers (first get all the fields)
    // get some register based on its name, and then print it's mirrored value
   
      
    if (starting_phase != null)
      starting_phase.drop_objection(this);  
    
endtask : body
