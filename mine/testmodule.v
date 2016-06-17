
module testmodule (
    input ck,
    input arst,
    input [3:0] inVal,
    output [3:0] outVal
    );

   localparam ELG=9;

    always_ff @(posedge ck or posedge arst)
        if (arst)
            outVal <= testpackage::ELG;
        else
            outVal = inVal;
    integer j;
    integer i;
    initial begin
        for ( i=0; i<10; i = i+1) begin
            j = j + 1;
            a = 5*2;
        end
    //    j = j +1;
    end

endmodule

