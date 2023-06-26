library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity ALU_componente is
    port (
        A, B    : in    std_logic_vector(7 downto 0);
        ALU_Sel : in    std_logic_vector(1 downto 0);
        NZVC    : out   std_logic_vector(3 downto 0);
        Result  : out   std_logic_vector(7 downto 0)
    );
end entity; 

architecture arch_alu of ALU_componente is


begin

    ALU_PROCESS : process (A, B, ALU_Sel)
        variable Sum_uns : unsigned(8 downto 0);
		  variable Sub_uns : unsigned(8 downto 0);
        
        begin
            if (ALU_Sel = "00") then
                -- operacion para la suma
                Sum_uns := unsigned('0' & A) + unsigned('0' & B);
                Result <= std_logic_vector(Sum_uns(7 downto 0));
					 
				
                --- BANDERA NEGATIVA(N) -------------------------------
                NZVC(3) <= Sum_uns(7);
                --- BANDERA CERO (Z) ---------------------------------
                if (Sum_uns(7 downto 0) = x"00") then
                    NZVC(2) <= '1';
                else
                    NZVC(2) <= '0';
                end if;
                --- BANDERA DE DESBORDE (V) -------------------------------
                if ((A(7)='0' and B(7)='0' and Sum_uns(7)='1') or
                    (A(7)='1' and B(7)='1' and Sum_uns(7)='0')) then
                        NZVC(1) <= '1';
                else
                    NZVC(1) <= '0';
                end if;
                --- BANDERA DE CARRY (C) ------------------------------------
                NZVC(0) <= Sum_uns(8);
					 
            end if;
				
				if (ALU_Sel = "01") then 
						--operacion para la resta
						Sub_uns := unsigned('0' & A) - unsigned('0' & B);
						Result <= std_logic_vector(Sub_uns(7 downto 0));

						--- BANDERA NEGATIVA (N) ---------------------------------------
						NZVC(3) <= Sub_uns(7);

						--- BANDERA CERO (Z) -------------------------------------------
					if (Sub_uns(7 downto 0) = x"00") then
					NZVC(2) <= '1';
					else
						NZVC(2) <= '0';
					end if;

						--bandera de desborde
					if ((A(7)='1' and B(7)='0' and Sub_uns(7)='0') or
						(A(7)='0' and B(7)='1' and Sub_uns(7)='1')) then
					   NZVC(1) <= '1';
					else
						NZVC(1) <= '0';
					end if;

					--bandera del carry
						NZVC(0) <= not Sub_uns(8);
				end if;

		end process;
		
end architecture ;