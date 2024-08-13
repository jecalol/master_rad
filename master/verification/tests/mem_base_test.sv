class mem_base_test extends fifo_base_test;

   `uvm_component_utils(mem_base_test)
    fifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : mem_base_test
     function  mem_base_test::new(string name = "mem_base_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void mem_base_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        //set_specific_configuration();
     	set_type_override_by_type(fifo_empty_sequence::get_type(), mem_reg_base_sequence::get_type());
        super.build_phase(phase);
    endfunction : build_phase


  task mem_base_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
