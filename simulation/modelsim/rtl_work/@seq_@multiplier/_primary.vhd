library verilog;
use verilog.vl_types.all;
entity Seq_Multiplier is
    port(
        clk             : in     vl_logic;
        resetn          : in     vl_logic;
        start           : in     vl_logic;
        a               : in     vl_logic_vector(3 downto 0);
        b               : in     vl_logic_vector(3 downto 0);
        p               : out    vl_logic_vector(7 downto 0)
    );
end Seq_Multiplier;
