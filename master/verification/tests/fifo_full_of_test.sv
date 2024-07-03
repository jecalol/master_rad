class fifo_full_of_test extends fifo_base_test;

   `uvm_component_utils(fifo_full_of_test)
    fifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : fifo_full_of_test
     function  fifo_full_of_test::new(string name = "fifo_full_of_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void fifo_full_of_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        super.build_phase(phase);
        //set_specific_configuration();
     set_type_override_by_type(fifo_empty_sequence::get_type(), fifo_full_read_sequence::get_type());

    endfunction : build_phase


  task fifo_full_of_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
