

module UART (
    input  logic       clk,        
    input  logic       rst,

    // TX interface
    input  logic [7:0] tx_data,
    input  logic       tx_start,
    output logic       tx,
    

    // RX interface
    input  logic       rx,
    output logic [7:0] rx_data,
    output logic       rx_rdy,
    input  logic       rx_clr
);

logic Baud_tx_wire,Baud_rx_wire;

Baud_generator baud_inst (
    .clk   (clk),
    .rst_n (rst),
    .tx_en (Baud_tx_wire),
    .rx_en (Baud_rx_wire)
);

uart_tx tx_inst (
    .clk    (clk),
    .rst    (rst),
    .p_data (tx_data),
    .Wrt    (tx_start),
    .tx_en  (Baud_tx_wire),
    .s_data (tx)
);

uart_rx rx_inst (
    .clk      (clk),
    .rst      (rst),
    .rx       (rx),
    .rdy_clr (rx_clr),
    .rdy     (rx_rdy),
    .data_out(rx_data),
    .rx_en   (Baud_rx_wire)
);



endmodule