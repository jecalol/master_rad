class fifo_bus2reg extends uvm_reg_adapter;
    `uvm_object_utils(fifo_bus2reg)
    
    function new (string name = "fifo_bus2reg");
        super.new(name);
    endfunction
    
    virtual function uvm_sequence_item bus2reg(const ref uvm_reg_bus_op rw);
        bus_pkt pkt = bus_pkt::type_id::create("pkt");
        pkt.write = (rw.kind == UVM_WRITE) ? 1 : 0;
        rw.addr= pkt.addr;
       rw.data= pkt.data ;
        
        return pkt;
    endfunction
    
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        bus_pkt pkt;
        if( !$cast(pkt, bus_item) 
            `uvm_fatal ("bus2reg_adapter", "Failed to cast bus_item to pkt")
        
        rw.kind = pkt.write ? UVM_WRITE : UVM_READ;
         pkt.addr=rw.addr ;
        rw.data = pkt.data=rw.data ;
    endfunction
endclass
