#!/usr/bin/env ruby
# encoding: utf-8
require 'spec_helper'

context '# Pruebas con el primer ejemplo propuesto.' do
    before :all do
        @ex1_a = DiffieHellman.new(5, 4, 13)
        @ex1_b = DiffieHellman.new(2, 4, 13)
    end

    it '- Los valores de xA e yA son correctos.' do
        expect(@ex1_a.secret).to eq(5)
        expect(@ex1_b.secret).to eq(2)
    end

    it "- Los valores de α y el numero primo 'p' son correctos." do
        expect(@ex1_a.alpha).to eq(4)
        expect(@ex1_b.alpha).to eq(4)

        expect(@ex1_a.prime).to eq(13)
        expect(@ex1_b.prime).to eq(13)
    end

    it '- Los valores de la clave coinciden.' do
        expect(@ex1_a.key).to eq(@ex1_b.key)
    end

    it '- El valor de la clave del primer ejemplo es correcto.' do
        @ex1_a.generate_key(@ex1_b.public_value)
        @ex1_b.generate_key(@ex1_a.public_value)
        expect(@ex1_a.key).to eq(9)
        expect(@ex1_b.key).to eq(9)
    end
end

context '# Pruebas con el segundo ejemplo propuesto.' do
    before :all do
        @ex2_a = DiffieHellman.new(25, 23, 43)
        @ex2_b = DiffieHellman.new(33, 23, 43)
    end

    it '- Los valores de xA e yA son correctos.' do
        expect(@ex2_a.secret).to eq(25)
        expect(@ex2_b.secret).to eq(33)
    end

    it "- Los valores de α y el numero primo 'p' son correctos." do
        expect(@ex2_a.alpha).to eq(23)
        expect(@ex2_b.alpha).to eq(23)

        expect(@ex2_a.prime).to eq(43)
        expect(@ex2_b.prime).to eq(43)
    end

    it '- Los valores de la clave coinciden.' do
        expect(@ex2_a.key).to eq(@ex2_b.key)
    end

    it '- El valor de la clave del segundo ejemplo es correcto.' do
        @ex2_a.generate_key(@ex2_b.public_value)
        @ex2_b.generate_key(@ex2_a.public_value)
        expect(@ex2_a.key).to eq(4)
        expect(@ex2_b.key).to eq(4)
    end
end

context '# Pruebas con el tercer ejemplo propuesto' do
    before :all do
        @ex3_a = DiffieHellman.new(54, 43, 113)
        @ex3_b = DiffieHellman.new(71, 43, 113)
    end

    it '- Los valores de xA e yA son correctos.' do
        expect(@ex3_a.secret).to eq(54)
        expect(@ex3_b.secret).to eq(71)
    end

    it "- Los valores de α y el numero primo 'p' son correctos." do
        expect(@ex3_a.alpha).to eq(43)
        expect(@ex3_b.alpha).to eq(43)

        expect(@ex3_a.prime).to eq(113)
        expect(@ex3_b.prime).to eq(113)
    end

    it '- Los valores de la clave coinciden.' do
        expect(@ex3_a.key).to eq(@ex3_b.key)
    end

    it '- El valor de la clave del segundo ejemplo es correcto.' do
        @ex3_a.generate_key(@ex3_b.public_value)
        @ex3_b.generate_key(@ex3_a.public_value)
        expect(@ex3_a.key).to eq(61)
        expect(@ex3_b.key).to eq(61)
    end
end