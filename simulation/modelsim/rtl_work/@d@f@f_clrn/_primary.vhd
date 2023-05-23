library verilog;
use verilog.vl_types.all;
entity DFF_clrn is
    port(
        clk             : in     vl_logic;
        clrn            : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end DFF_clrn;
