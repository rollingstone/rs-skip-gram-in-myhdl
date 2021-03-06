-- File: ./ex-target/WordContextUpdated.vhd
-- Generated by MyHDL 1.0dev
-- Date: Mon Oct  5 14:15:05 2015


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_10.all;

entity WordContextUpdated is
    port (
        y: inout signed (15 downto 0);
        error: out signed (15 downto 0);
        new_word_embv: out unsigned(47 downto 0);
        new_context_embv: out unsigned(47 downto 0);
        y_actual: in signed (15 downto 0);
        word_embv: inout unsigned(47 downto 0);
        context_embv: inout unsigned(47 downto 0)
    );
end entity WordContextUpdated;
-- Word-context embeddings updated model.
-- 
-- :param y: return relu(dot(word_emb, context_emb)) as fixbv
-- :param error: return MSE prediction error as fixbv
-- :param new_word_embv: return updated word embedding vector of fixbv
-- :param new_context_embv: return updated context embedding vector of fixbv
-- :param y_actual: actual training value as fixbv
-- :param word_embv: word embedding vector of fixbv
-- :param context_embv: context embedding vector of fixbv
-- :param embedding_dim: embedding dimensionality
-- :param leaky_val: factor for leaky ReLU, 0.0 without
-- :param rate_val: learning rate factor
-- :param fix_min: fixbv min value
-- :param fix_max: fixbv max value
-- :param fix_res: fixbv resolution

architecture MyHDL of WordContextUpdated is



signal y_dcontext_vec: unsigned(47 downto 0);
signal y_dword_vec: unsigned(47 downto 0);
signal wcprod_y_dot_dword_vec: unsigned(47 downto 0);
signal wcprod_y_dot: signed (15 downto 0);
signal wcprod_y_relu_dx: signed (15 downto 0);
signal wcprod_y_dot_dcontext_vec: unsigned(47 downto 0);
type t_array_y_dcontext_list is array(0 to 3-1) of signed (15 downto 0);
signal y_dcontext_list: t_array_y_dcontext_list;
type t_array_context_emb is array(0 to 3-1) of signed (15 downto 0);
signal context_emb: t_array_context_emb;
type t_array_word_emb is array(0 to 3-1) of signed (15 downto 0);
signal word_emb: t_array_word_emb;
type t_array_y_dword_list is array(0 to 3-1) of signed (15 downto 0);
signal y_dword_list: t_array_y_dword_list;
type t_array_wcprod_y_dot_dword_list is array(0 to 3-1) of signed (15 downto 0);
signal wcprod_y_dot_dword_list: t_array_wcprod_y_dot_dword_list;
type t_array_wcprod_y_dot_dcontext_list is array(0 to 3-1) of signed (15 downto 0);
signal wcprod_y_dot_dcontext_list: t_array_wcprod_y_dot_dcontext_list;
type t_array_wcprod_dot_a_list is array(0 to 3-1) of signed (15 downto 0);
signal wcprod_dot_a_list: t_array_wcprod_dot_a_list;
type t_array_wcprod_dot_b_list is array(0 to 3-1) of signed (15 downto 0);
signal wcprod_dot_b_list: t_array_wcprod_dot_b_list;

begin



context_embv(48-1 downto 32) <= None;
context_embv(32-1 downto 16) <= None;
context_embv(16-1 downto 0) <= None;
word_embv(48-1 downto 32) <= None;
word_embv(32-1 downto 16) <= None;
word_embv(16-1 downto 0) <= None;
y_dcontext_list(0) <= y_dcontext_vec(16-1 downto 0);
y_dcontext_list(1) <= y_dcontext_vec(32-1 downto 16);
y_dcontext_list(2) <= y_dcontext_vec(48-1 downto 32);
context_emb(0) <= context_embv(16-1 downto 0);
context_emb(1) <= context_embv(32-1 downto 16);
context_emb(2) <= context_embv(48-1 downto 32);
word_emb(0) <= word_embv(16-1 downto 0);
word_emb(1) <= word_embv(32-1 downto 16);
word_emb(2) <= word_embv(48-1 downto 32);
y_dword_list(0) <= y_dword_vec(16-1 downto 0);
y_dword_list(1) <= y_dword_vec(32-1 downto 16);
y_dword_list(2) <= y_dword_vec(48-1 downto 32);
wcprod_y_dot_dword_list(0) <= wcprod_y_dot_dword_vec(16-1 downto 0);
wcprod_y_dot_dword_list(1) <= wcprod_y_dot_dword_vec(32-1 downto 16);
wcprod_y_dot_dword_list(2) <= wcprod_y_dot_dword_vec(48-1 downto 32);
wcprod_y_dot_dcontext_list(0) <= wcprod_y_dot_dcontext_vec(16-1 downto 0);
wcprod_y_dot_dcontext_list(1) <= wcprod_y_dot_dcontext_vec(32-1 downto 16);
wcprod_y_dot_dcontext_list(2) <= wcprod_y_dot_dcontext_vec(48-1 downto 32);
wcprod_dot_a_list(0) <= word_embv(16-1 downto 0);
wcprod_dot_a_list(1) <= word_embv(32-1 downto 16);
wcprod_dot_a_list(2) <= word_embv(48-1 downto 32);
wcprod_dot_b_list(0) <= context_embv(16-1 downto 0);
wcprod_dot_b_list(1) <= context_embv(32-1 downto 16);
wcprod_dot_b_list(2) <= context_embv(48-1 downto 32);


WORDCONTEXTUPDATED_WCPROD_DOT_DOT: process (wcprod_dot_a_list, wcprod_dot_b_list) is
    variable y_sum: signed(31 downto 0);
begin
    y_sum := to_signed(0.0, 32);
    for j in 0 to 3-1 loop
        y_sum := (y_sum + (wcprod_dot_a_list(j) * wcprod_dot_b_list(j)));
    end loop;
    wcprod_y_dot <= to_signed(y_sum, 16);
end process WORDCONTEXTUPDATED_WCPROD_DOT_DOT;



wcprod_y_dot_dword_vec <= context_embv;



wcprod_y_dot_dcontext_vec <= word_embv;


WORDCONTEXTUPDATED_WCPROD_RELU_RELU: process (wcprod_y_dot) is
    variable zero: signed(15 downto 0);
    variable leaky: signed(15 downto 0);
begin
    if (wcprod_y_dot > zero) then
        y <= wcprod_y_dot;
    else
        y <= to_signed((leaky * wcprod_y_dot), 16);
    end if;
end process WORDCONTEXTUPDATED_WCPROD_RELU_RELU;


WORDCONTEXTUPDATED_WCPROD_RELU_RELU_DX: process (wcprod_y_dot) is
    variable zero: signed(15 downto 0);
    variable leaky: signed(15 downto 0);
    variable one: signed(15 downto 0);
begin
    if (wcprod_y_dot > zero) then
        wcprod_y_relu_dx <= one;
    else
        wcprod_y_relu_dx <= leaky;
    end if;
end process WORDCONTEXTUPDATED_WCPROD_RELU_RELU_DX;


WORDCONTEXTUPDATED_WCPROD_WCPROD_DWORD: process (wcprod_y_relu_dx, wcprod_y_dot_dword_list) is
    variable prod: signed(15 downto 0);
begin
    for j in 0 to 3-1 loop
        prod := to_signed((wcprod_y_relu_dx * wcprod_y_dot_dword_list(j)), 16);
        y_dword_vec(((j + 1) * 16)-1 downto (j * 16)) <= unsigned(prod);
    end loop;
end process WORDCONTEXTUPDATED_WCPROD_WCPROD_DWORD;


WORDCONTEXTUPDATED_WCPROD_WCPROD_DCONTEXT: process (wcprod_y_relu_dx, wcprod_y_dot_dcontext_list) is
    variable prod: signed(15 downto 0);
begin
    for j in 0 to 3-1 loop
        prod := to_signed((wcprod_y_relu_dx * wcprod_y_dot_dcontext_list(j)), 16);
        y_dcontext_vec(((j + 1) * 16)-1 downto (j * 16)) <= unsigned(prod);
    end loop;
end process WORDCONTEXTUPDATED_WCPROD_WCPROD_DCONTEXT;


WORDCONTEXTUPDATED_MSE: process (y, y_actual) is
    variable diff: signed(15 downto 0);
begin
    diff := to_signed((y - y_actual), 16);
    error <= to_signed((diff * diff), 16);
end process WORDCONTEXTUPDATED_MSE;


WORDCONTEXTUPDATED_UPDATED_WORD: process (y, word_emb, y_actual, y_dword_list) is
    variable new: signed(15 downto 0);
    variable y_dword: signed(15 downto 0);
    variable rate: signed(15 downto 0);
    variable delta: signed(15 downto 0);
    variable diff: signed(15 downto 0);
begin
    diff := to_signed((y - y_actual), 16);
    for j in 0 to 3-1 loop
        y_dword := to_signed(y_dword_list(j), 16);
        delta := to_signed(((rate * diff) * y_dword), 16);
        new := to_signed((word_emb(j) - delta), 16);
        new_word_embv(((j + 1) * 16)-1 downto (j * 16)) <= unsigned(new);
    end loop;
end process WORDCONTEXTUPDATED_UPDATED_WORD;


WORDCONTEXTUPDATED_UPDATED_CONTEXT: process (y, y_dcontext_list, y_actual, context_emb) is
    variable y_dcontext: signed(15 downto 0);
    variable rate: signed(15 downto 0);
    variable new: signed(15 downto 0);
    variable delta: signed(15 downto 0);
    variable diff: signed(15 downto 0);
begin
    diff := to_signed((y - y_actual), 16);
    for j in 0 to 3-1 loop
        y_dcontext := to_signed(y_dcontext_list(j), 16);
        delta := to_signed(((rate * diff) * y_dcontext), 16);
        new := to_signed((context_emb(j) - delta), 16);
        new_context_embv(((j + 1) * 16)-1 downto (j * 16)) <= unsigned(new);
    end loop;
end process WORDCONTEXTUPDATED_UPDATED_CONTEXT;

end architecture MyHDL;
