library verilog;
use verilog.vl_types.all;
entity DFF_en is
    port(
        clk             : in     vl_logic;
        en              : in     vl_logic;
        d               : in     vl_logic;
        q               : out    vl_logic
    );
end DFF_en;
