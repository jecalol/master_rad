class fifo_epty_uf_back_test extends fifo_base_back_test;

   `uvm_component_utils(fifo_epty_uf_back_test)
    fifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : fifo_epty_uf_back_test
     function  fifo_epty_uf_back_test::new(string name = "fifo_epty_uf_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void fifo_epty_uf_back_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        super.build_phase(phase);
        //set_specific_configuration();
     set_type_override_by_type(fifo_bempty_sequence::get_type(), fifo_empty_read_back_sequence::get_type());

    endfunction : build_phase


  task fifo_epty_uf_back_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
