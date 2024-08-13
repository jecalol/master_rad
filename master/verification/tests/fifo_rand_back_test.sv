class fifo_rand_back_test extends fifo_base_back_test;

   `uvm_component_utils(fifo_rand_back_test)
    fifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : fifo_rand_back_test
     function  fifo_rand_back_test::new(string name = "fifo_rand_back_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void fifo_rand_back_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        //set_specific_configuration();
     	set_type_override_by_type(fifo_bempty_sequence::get_type(), stat_reg_rand_back_sequence::get_type());
        super.build_phase(phase);
    endfunction : build_phase


  task fifo_rand_back_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
