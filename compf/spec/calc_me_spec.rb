require 'rspec'
require_relative '../calc_me'

describe 'Калькулятор' do
  let(:calc) { Calc.new }

  context 'сложение' do
    it  '1+2=3' do
      expect(calc.compile('I+II')).to eq 3
    end

    it  '1+2+3+4+5+6=21' do
      expect(calc.compile('I+II+III+IV+V+VI')).to eq 21
    end

    it  '(1+2)+(3+4)=10' do
      expect(calc.compile('(I+II)+(III+IV)')).to eq 10
    end

    it  '(1+(2+3)+4)=10' do
      expect(calc.compile('(I+(II+III)+IV)')).to eq 10
    end

    it  '1933+66=1999' do
      expect(calc.compile('MCMXXXIII+LXVI')).to eq 1999
    end
  end

  context 'вычитание' do
    it '1-2=-1' do
      expect(calc.compile('I-II')).to eq -1
    end

    it '5-2=3' do
      expect(calc.compile('V-II')).to eq 3
    end

    it '1-2-3-4-5-6=-19' do
      expect(calc.compile('I-II-III-IV-V-VI')).to eq -19
    end

    it '(1-2)-(3-4)=0' do
      expect(calc.compile('(I-II)-(III-IV)')).to eq 0
    end

    it '245-657=-412' do
      expect(calc.compile('CCXLV-DCLVII')).to eq -412
    end

    it '2015-2014=1' do
      expect(calc.compile('MMXV-MMXIV')).to eq 1
    end
  end

  context 'умножение' do
    it '1*2=2' do
      expect(calc.compile('I*II')).to eq 2
    end

    it '2*5*2=20' do
      expect(calc.compile('II*V*II')).to eq 20
    end

    it '7*1*1*1=7' do
      expect(calc.compile('VII*I*I*I')).to eq 7
    end

    it '(4*7)*(2*2)=112' do
      expect(calc.compile('(IV*VII)*(II*II)')).to eq 112
    end
    it '10*100=1000' do
      expect(calc.compile('X*C')).to eq 1000
    end
  end

  context 'деление' do
    it '1/2=0' do
      expect(calc.compile('I/II')).to eq 0
    end

    it '2/1=2' do
      expect(calc.compile('II/I')).to eq 2
    end

    it '8/4=2' do
      expect(calc.compile('VIII/IV')).to eq 2
    end

    it '7/1/1/1=7' do
      expect(calc.compile('VII/I/I/I')).to eq 7
    end

    it '8/2/2/2=1' do
      expect(calc.compile('VIII/II/II/II')).to eq 1
    end

    it '(4/2)/(10/5)=1' do
      expect(calc.compile('(IV/II)/(X/V)')).to eq 1
    end

    it '39/2=19' do
      expect(calc.compile('XXXIX/II')).to eq 19
    end
  end

  context 'скобки и приоритеты' do
    it '(1-2)=-1' do
      expect(calc.compile('(I-II)')).to eq -1
    end

    it '((((1-2))))=-1' do
      expect(calc.compile('((((I-II))))')).to eq -1
    end

    it '(1+4)*7=35' do
      expect(calc.compile('(I+IV)*VII')).to eq 35
    end

    it '1+(4*7)=29' do
      expect(calc.compile('I+(IV*VII)')).to eq 29
    end

    it '7*(8)/4=14' do
      expect(calc.compile('VII*(VIII)/IV')).to eq 14
    end

    it '4/8*7=0' do
      expect(calc.compile('IV/VIII*VII')).to eq 0
    end

    it '5/3*2=2' do
      expect(calc.compile('V/III*II')).to eq 2
    end

    it '5/(3*2)=0' do
      expect(calc.compile('V/(III*II)')).to eq 0
    end
  end

  context 'выражения' do
    it '1+2+(2*(3+7))/(5+8/3)=5' do
      test = 'I+II+(II*(III+VII))/(V+VIII/III)'
      expect(calc.compile(test)).to eq 5
    end

    it '(3-5-2*6/(1+1))/(2*5-1+4*(5*2/3))+(7+4+7/9)/(1+6/3)=2' do
      test = '(III-V-II*VI/(I+I))/(II*V-I+IV*(V*II/III))+(VII+IV+VII/IX)/(I+VI/III)'
      expect(calc.compile(test)).to eq 2
    end

    it '((1+(1*(1+(1+1/1)))))/(1+1) = 2' do
      test = '((I+(I*(I+(I+I/I)))))/(I+I)'
      expect(calc.compile(test)).to eq 2
    end

  end

end
