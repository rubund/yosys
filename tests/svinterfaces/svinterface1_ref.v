
module TopModule(
    input logic clk,
    input logic rst,
    input logic [1:0] sig,
    output logic [21:0] outOther,
    output logic [1:0] sig_out);


    logic MyInterfaceInstance_setting;
    logic [3:0] MyInterfaceInstance_other_setting;
    logic [1:0] MyInterfaceInstance_mysig_out;

  SubModule1 u_SubModule1 (
    .clk(clk),
    .rst(rst),
    .u_MyInterface_setting(MyInterfaceInstance_setting),
    .u_MyInterface_mysig_out(MyInterfaceInstance_mysig_out),
    .u_MyInterface_other_setting(MyInterfaceInstance_other_setting),
    .outOther(outOther),
    .sig (sig)
  );

  assign sig_out = MyInterfaceInstance_mysig_out;


  assign MyInterfaceInstance_setting = 1;

endmodule


module SubModule1(
    input logic clk,
    input logic rst,
    input logic u_MyInterface_setting,
    output logic [3:0] u_MyInterface_other_setting,
    output logic [1:0] u_MyInterface_mysig_out,
    output logic [21:0] outOther,
    input logic [1:0] sig

  );

  always @(posedge clk or posedge rst)
    if(rst)
      u_MyInterface_mysig_out <= 0;
    else begin
      if(u_MyInterface_setting)
        u_MyInterface_mysig_out <= sig;
      else
        u_MyInterface_mysig_out <= ~sig;
    end

    logic MyInterfaceInstanceInSub_setting;
    logic [21:0] MyInterfaceInstanceInSub_other_setting;
    logic [1:0] MyInterfaceInstanceInSub_mysig_out;


  SubModule2 u_SubModule2 (
    .clk(clk),
    .rst(rst),
    .u_MyInterfaceInSub2_setting(u_MyInterface_setting),
    .u_MyInterfaceInSub2_mysig_out(u_MyInterface_mysig_out),
    .u_MyInterfaceInSub2_other_setting(u_MyInterface_other_setting),
    .u_MyInterfaceInSub3_setting(MyInterfaceInstanceInSub_setting),
    .u_MyInterfaceInSub3_mysig_out(MyInterfaceInstanceInSub_mysig_out),
    .u_MyInterfaceInSub3_other_setting(MyInterfaceInstanceInSub_other_setting),
    .sig (sig)
  );
    assign outOther = MyInterfaceInstanceInSub_other_setting;

    assign MyInterfaceInstanceInSub_setting = 0;
    assign MyInterfaceInstanceInSub_mysig_out = 3;

endmodule

module SubModule2(

    input logic clk,
    input logic rst,
    input logic u_MyInterfaceInSub2_setting,
    output logic [3:0] u_MyInterfaceInSub2_other_setting,
    input  logic [1:0] u_MyInterfaceInSub2_mysig_out,
    input logic u_MyInterfaceInSub3_setting,
    output logic [21:0] u_MyInterfaceInSub3_other_setting,
    input  logic [1:0] u_MyInterfaceInSub3_mysig_out,
    input logic [1:0] sig

  );

   assign u_MyInterfaceInSub2_other_setting[3:0] = 9;
   assign u_MyInterfaceInSub3_other_setting[21:0] = 13;

endmodule
