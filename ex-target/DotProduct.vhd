-- File: ./ex-target/DotProduct.vhd
-- Generated by MyHDL 1.0dev
-- Date: Tue Oct  6 16:32:07 2015


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_10.all;

entity DotProduct is
    port (
        y: out signed (15 downto 0);
        y_da_vec: out unsigned(47 downto 0);
        y_db_vec: out unsigned(47 downto 0);
        a_vec: inout unsigned(47 downto 0);
        b_vec: inout unsigned(47 downto 0)
    );
end entity DotProduct;
-- Vector dot product and derivative model using fixbv type.
-- 
-- :param y: return dot(a_vec, b_vec) as fixbv
-- :param y_da_vec: return d/da dot(a_vec, b_vec) as vector of fixbv
-- :param y_db_vec: return d/db dot(a_vec, b_vec) as vector of fixbv
-- :param a_vec: vector of fixbv
-- :param b_vec: vector of fixbv
-- :param dim: vector dimensionality
-- :param fix_min: fixbv min value
-- :param fix_max: fixbv max value
-- :param fix_res: fixbv resolution

architecture MyHDL of DotProduct is



type t_array_a_list is array(0 to 3-1) of signed (15 downto 0);
signal a_list: t_array_a_list;
type t_array_b_list is array(0 to 3-1) of signed (15 downto 0);
signal b_list: t_array_b_list;

begin



b_vec(48-1 downto 32) <= None;
b_vec(32-1 downto 16) <= None;
b_vec(16-1 downto 0) <= None;
a_vec(48-1 downto 32) <= None;
a_vec(32-1 downto 16) <= None;
a_vec(16-1 downto 0) <= None;
a_list(0) <= a_vec(16-1 downto 0);
a_list(1) <= a_vec(32-1 downto 16);
a_list(2) <= a_vec(48-1 downto 32);
b_list(0) <= b_vec(16-1 downto 0);
b_list(1) <= b_vec(32-1 downto 16);
b_list(2) <= b_vec(48-1 downto 32);


DOTPRODUCT_DOT: process (a_list, b_list) is
    variable y_sum: signed(31 downto 0);
begin
    y_sum := to_signed(0.0, 32);
    for j in 0 to 3-1 loop
        y_sum := (y_sum + (a_list(j) * b_list(j)));
    end loop;
    y <= to_signed(y_sum, 16);
end process DOTPRODUCT_DOT;



y_da_vec <= b_vec;



y_db_vec <= a_vec;

end architecture MyHDL;
