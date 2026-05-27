`timescale 1ns/1ps

module uart_tb;

    logic   clk;        
    logic   rst;

    // TX interface
    logic[7:0] tx_data;
    logic   tx_start;
    logic   tx;
    

    // RX interface
    logic   rx;
    logic[7:0] rx_data;
    logic   rx_rdy;
    logic   rx_clr;

    UART dut(.clk(clk),.rst(rst)
            ,.tx_data(tx_data),.tx_start(tx_start),
            .tx(tx),.rx(rx),.rx_data(rx_data),
            .rx_rdy(rx_rdy),.rx_clr(rx_clr));

    
    
    always #10 clk = ~clk;
    initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, uart_tb.dut);
end

    assign rx = tx;

    initial begin
        clk = 0;
        rst = 0;
        tx_start = 0;
        tx_data  = 8'h00;
        rx_clr   = 0;

        #100 rst = 1;

        // wait a bit
        #100;

        // send one byte
        tx_data  = 8'hA6;
        tx_start = 1;
        #20;
        tx_start = 0;

        // wait for RX
        wait (rx_rdy);
        rx_clr = 1;
        #20;
        rx_clr = 0;
        #100
        // send one byte
        tx_data  = 8'h67;
       
        tx_start = 1;
        #4000;
        tx_start = 0;

        wait (rx_rdy);
        #40;
        rx_clr = 1;
        #40;
        rx_clr = 0;


        #5_000_000;
        $finish;
    end

endmodule