library verilog;
use verilog.vl_types.all;
entity shift_reg_si is
    generic(
        N               : integer := 1
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        load            : in     vl_logic;
        shiftr          : in     vl_logic;
        D               : in     vl_logic_vector;
        Q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end shift_reg_si;
