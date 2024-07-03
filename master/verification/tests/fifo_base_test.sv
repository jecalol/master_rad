
class fifo_base_test extends uvm_test;

      `uvm_component_utils (fifo_base_test) 

    fifo_env m_env;
    fifo_env_cfg m_env_cfg;
    fifo_empty_sequence  ms_seq;
    extern function new(string name = "fifo_base_test", uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  fifo_base_test::new(string name = "fifo_base_test", uvm_component parent);
	super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void fifo_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);


    m_env = fifo_env::type_id::create("m_env", this);
    m_env_cfg = fifo_env_cfg::type_id::create("m_env_cfg", this);

    m_env_cfg.set_default_config();
    
    uvm_config_db#(fifo_env_cfg)::set(this, "m_env", "m_env_cfg", m_env_cfg);
    
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task fifo_base_test::run_phase(uvm_phase phase);
       phase.raise_objection(this);
       ms_seq=fifo_empty_sequence::type_id::create("ms_seq");
       ms_seq.start(m_env.m_agent.sequencer);
      phase.phase_done.set_drain_time(this, 100ns);
       phase.drop_objection(this);
endtask
