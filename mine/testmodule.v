

module testmodule(
    input ck,
    input arst,
    input [3:0] inval,
    output [3:0] outVal
    );


    always_ff @(posedge ck or posedge arst)
        if (arst)
            outVal <= 0;
        else
            outVal = inVal;

endmodule

