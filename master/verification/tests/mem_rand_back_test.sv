class mem_rand_back_test extends fifo_base_back_test;

   `uvm_component_utils(mem_rand_back_test)
    fifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : mem_rand_back_test
     function  mem_rand_back_test::new(string name = "mem_rand_back_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void mem_rand_back_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        //set_specific_configuration();
     	set_type_override_by_type(fifo_bempty_sequence::get_type(), mem_reg_rand_back_sequence::get_type());
        super.build_phase(phase);
    endfunction : build_phase


  task mem_rand_back_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
