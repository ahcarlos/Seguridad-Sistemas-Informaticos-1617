def A5Cipher
    attr_accessor :lfsr1, :lfsr2, :lfsr3, :C1, :C2, :C3

    def initialize(r1, r2, r3)
        @lfsr1 = r1 #lfsr1
        @lfsr2 = r2 #lfsr2
        @lfsr3 = r3 #lfsr3
        @C1 = 8     # clocking bit lfsr1
        @C2 = 10    # clocking bit lfsr2
        @C3 = 10    # clocking bit lfsr3
        @key_stream
    end

    def majority
        #major = [lfsr1.at(C1), lfsr2.at(C2), lfsr3.at(C3)].join('')
        major = ((@lfsr1.at(@C1) * @lfsr2.at(@C2)) ^  (@lfsr1.at(@C1) * @lfsr3.at(@C3)) ^ (@lfsr2.at(@C2) * @lfsr3.at(@C3)))
        p "mayoria es #{major}"
        p @lfsr1.at(@C1)
        p @lfsr2.at(@C2)
        p @lfsr3.at(@C3)
        return major
    end

    def generate_key_stream
        i = 0
        while ( i < 6) do
            z = @lfsr1.at(18) ^ @lfsr2.at(21) ^ @lfsr3.at(22)
            @key_stream.push(z)

            desplaza = majority

            if (lfsr1.at(C1) == desplaza)
                xor_reg1 = lfsr1.at(18) ^ lfsr1.at(17) ^ lfsr1.at(16) ^ lfsr1.at(13)
                lfsr1.unshift(xor_reg1)
                lfsr1.delete_at(19)
                p "reg 1: #{lfsr1}"
            end

            if (lfsr2.at(C2) == desplaza)
                xor_reg2 = lfsr2.at(21) ^ lfsr2.at(20)
                lfsr2.unshift(xor_reg2)
                lfsr2.delete_at(22)
                p "reg 2: #{lfsr2}"
            end

            if (lfsr3.at(C3) == desplaza)
                xor_value3 = lfsr3.at(22) ^ lfsr3.at(21) ^ lfsr3.at(20) ^ lfsr3.at(7)
                lfsr3.unshift(xor_value3)
                lfsr3.delete_at(23)
                p "reg 3: #{lfsr3}"
            end
        end
    end
end
