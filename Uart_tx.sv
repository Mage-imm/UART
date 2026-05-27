module uart_tx (
    input logic Wrt,
    input logic[7:0] p_data,
    input logic clk,
    input logic tx_en,
    input logic  rst,
    output logic s_data
);

typedef enum logic [1:0] {
    IDLE,
    START,
    DATA,
    STOP
}tx_state;

tx_state state,next_state;
logic[3:0] count,next_count;
logic next_s_data;



always_ff @( posedge clk ) begin 
    if(!rst) begin
        state <= IDLE;
        count <= 0;
        s_data <= 1'b1;
         

    end
    else begin
        state <= next_state;
        count <= next_count;
        s_data <= next_s_data;
      
    end
end

logic wrt_pending;

always_ff @(posedge clk) begin
    if (!rst)
        wrt_pending <= 1'b0;
    else if (Wrt)
        wrt_pending <= 1'b1;
    else if (state == START)
        wrt_pending <= 1'b0;
end



always_comb begin 
    case (state)
       IDLE: begin
    next_s_data = 1'b1;
    next_state  = IDLE;
    next_count = count;

    if (wrt_pending && tx_en) begin
        next_state = START;   // aligned
    end
end



       START: begin
    next_s_data = 1'b0;

    if (tx_en)
        next_state = DATA;
        
end


        DATA: begin
            /// DEFAULTSSS
            next_count = count;
            next_s_data = s_data;
            next_state = state;
            if (tx_en)  begin
                next_count = count + 1;
                next_s_data = p_data[count];
            end
            else if(count == 0) begin
                next_s_data = p_data[count];
                next_count = count +1;
            end
            else if(count == 8) begin
                next_state = STOP;
                next_count = 0;
            end
            
        end

        STOP: begin
            // DEFAULTSSS
            next_count = count;
            next_s_data = s_data;
            next_state = state;
            if(tx_en)begin
            
            next_state = IDLE;
            end
            
        end

    endcase
end
endmodule