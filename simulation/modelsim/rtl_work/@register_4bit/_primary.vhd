library verilog;
use verilog.vl_types.all;
entity Register_4bit is
    port(
        clk             : in     vl_logic;
        ld              : in     vl_logic;
        a               : in     vl_logic_vector(3 downto 0);
        y               : out    vl_logic_vector(3 downto 0)
    );
end Register_4bit;
