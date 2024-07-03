class fifo_reg2bus extends uvm_reg_adapter;
    `uvm_object_utils(fifo_reg2bus)
    
    function new (string name = "fifo_reg2bus");
        super.new(name);
    endfunction
    
    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        fifo_item req;
 	req = fifo_item::type_id::create("req");
        req.write = (rw.kind == UVM_WRITE) ? 1 : 0;
        req.addr = rw.addr;
        req.wdata = rw.data;
        
        return req;
    endfunction
    
    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        fifo_item req;
        if( !$cast(req, bus_item) )
            `uvm_fatal ("reg2apb_adapter", "Failed to cast bus_item to pkt")
        
        rw.kind = req.write ? UVM_WRITE : UVM_READ;
        rw.addr = req.addr;
        rw.data = req.wdata;
    endfunction
endclass
