module Baud_generator #(
    parameter int FREQ = 50_000_000,
    parameter int BAUD = 9600,
    parameter int OVERSAMPLING = 16
)(
    input  logic clk,
    input  logic rst_n,
    output logic tx_en,
    output logic rx_en
);

localparam Cycle_master = FREQ/BAUD ;
localparam Cycle_slave  = Cycle_master/OVERSAMPLING;


logic [$clog2(Cycle_master) - 1:0] countm;
logic [$clog2(Cycle_slave) - 1:0] counts;
always_ff @(posedge clk or negedge rst_n ) begin 
 if (!rst_n) begin
        countm <= 0;
        counts <= 0;
        tx_en  <= 0;
        rx_en  <= 0;
 end
 else begin

    if (countm == Cycle_master - 1) begin
        countm <= 0;
        tx_en <= 1;
    end
    else begin
         countm <= countm + 1;
         tx_en <= 0;
    end

    if(counts == Cycle_slave - 1) begin
        counts <= 0;
        rx_en <= 1;
    end

    else begin
        counts <= counts +1;
        rx_en <= 0;
    end
 end

end 
    
endmodule