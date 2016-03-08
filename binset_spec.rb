require 'rspec'
require_relative './binset'

describe BinSet do

  let(:binset) { BinSet.new }

  context "Свойства методов empty? и empty:" do
    it "только что созданное множество является пустым" do
      expect(binset.empty?).to be true
    end

    it "" do
      binset.insert(18)
      binset.delete(18)
      expect(binset.empty?).to be true
    end

    it "пустое множество с добавленным в него элементом не является пустым" do
      binset.insert(17)
      expect(binset.empty?).to be false
    end

    it "после вызова метода empty множество становится пустым" do
      binset.insert(17)
      binset.empty
      expect(binset.empty?).to be true
    end
  end

  context "Свойства метода include?:" do
    it "только что созданное множество ничего не содержит" do
      expect(binset.include?(20)).to be false
    end

    it "Множество содержит добавленный в него элемент" do
      binset.insert(18)
      expect(binset.include?(18)).to be true
      expect(binset.include?(19)).to be false
    end
  end

  context "Особенности работы с пустым и полностью заполненным множеством:" do
    it "из пустого множества можно удалить любой элемент" do
      expect{binset.delete(17)}.not_to raise_error
    end

    it "В полностью заполненное мн-во нельзя добавить элемент которого там нет" do
      i=0
      BinSet::DEF_SIZE.times{binset.insert(i);i+=1}
      expect{binset.insert(i)}.to raise_error(RuntimeError, "BinSet is full")
    end

    it "В полностью заполненное мн-во можно добавить элемент который там есть" do
      i=0
      BinSet::DEF_SIZE.times{binset.insert(i);i+=1}
      expect{binset.insert(i-1)}.not_to raise_error
    end
  end
end
