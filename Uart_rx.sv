module uart_rx (
    input logic clk,
    input logic rx,
    input logic rst,
    input logic rdy_clr,
    input logic rx_en,
    output logic[7:0] data_out,
    output logic rdy
);
typedef enum logic [1:0] {
    START,
    DATA,
    STOP,
    IDLE
}t_state;

logic[3:0]sample,index,next_sample,next_index;
logic[7:0] next_data_out;
logic next_rdy;
t_state state,next_state;

always_ff @( posedge clk ) begin 
    if(!rst) begin
        rdy <= 1'b0;
        state <= IDLE;
        sample <= 4'b0000;
        index <= 4'b0000;
        next_rdy <= 1'b0;
        next_state <= IDLE;
        next_sample <= 4'b0000;
        next_index <= 4'b0000;
        
    end
    else begin

        if(index == 7 && sample == 4'd15)begin
            data_out <= next_data_out;
        end
        state <= next_state;
        sample <= next_sample;
        index <= next_index;
        rdy <= next_rdy;
        
    end
end

always_comb begin 
    next_state = state;
    next_sample = sample;
    next_index = index;
    case (state)
        IDLE: begin
             if(rdy_clr)begin
            next_rdy = 1'b0;
            end
            if (rx == 0) begin  
                next_state  = START;
                next_sample = 0;
            end
        end    
        
        START: begin
            if(rdy_clr)begin
            next_rdy = 1'b0;
            end
            if(sample == 4'b1111 && rx_en)begin
                next_state = DATA;
                next_sample = 1'b0;
            end
            else if(rx_en) begin
                next_sample = sample + 1;
            
             end
        end
        DATA: begin
            if(sample == 4'd8 && rx_en) begin
                
                next_data_out[index] = rx; 
                next_sample = sample + 1;
            end
            else if(index == 3'd7 && sample == 4'd15) begin
                next_state = STOP;
                next_sample = 1'd0;
                next_index = 1'b0;
            end
            else if(sample == 4'd15 && rx_en) begin
                next_sample = 4'b0000;
                next_index = index + 1;
            end

            else if(rx_en)begin
                next_sample = sample +1;
            end


         end

    STOP: begin
        next_rdy= 1;
        if(rdy_clr)begin
            next_rdy = 1'b0;
            end
        else if(sample == 4'd15) begin
                next_state = IDLE;
                next_sample = 1'b0;
            end
            else if(rx_en) begin
                next_sample = sample + 1;
            end
    end
         
    endcase
    
end

endmodule