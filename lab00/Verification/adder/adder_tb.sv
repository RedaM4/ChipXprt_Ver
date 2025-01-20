module adder_tb;
    logic [3:0] a;
    logic [3:0] b;
    logic [3:0] sum;

    adder DUT(
        .a(a),
        .b(b),
        .sum(sum)
    );


    initial begin 
        a = 0; b = 3; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
        a = 2; b = 6; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
        a = 6; b = 7; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
        a = 4; b = 2; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
        a = 8; b = 3; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
        a = 2; b = 9; #10; $display("a = %d, b = %d, sum = %d",a,b,sum);
    end

endmodule 