require 'rspec'
require_relative './lset'

describe LSet do

  let(:lset) { LSet.new }

  context "Свойства методов empty? и empty:" do
    it "только что созданное множество является пустым" do
      expect(lset.empty?).to be true
    end

    it "" do
      lset.insert(18)
      lset.delete(18)
      expect(lset.empty?).to be true
    end

    it "пустое множество с добавленным в него элементом не является пустым" do
      lset.insert(17)
      expect(lset.empty?).to be false
    end

    it "после вызова метода empty множество становится пустым" do
      lset.insert(17)
      lset.empty
      expect(lset.empty?).to be true
    end
  end

  context "Свойства метода include?:" do
    it "только что созданное множество ничего не содержит" do
      expect(lset.include?(20)).to be false
    end

    it "Множество содержит добавленный в него элемент" do
      lset.insert(18)
      expect(lset.include?(18)).to be true
      expect(lset.include?(19)).to be false
    end
  end

  context "Особенности работы с пустым и полностью заполненным множеством:" do
    it "из пустого множества можно удалить любой элемент" do
      expect{lset.delete(17)}.not_to raise_error
    end

    it "В полностью заполненное мн-во нельзя добавить элемент которого там нет" do
      i=0
      LSet::DEF_SIZE.times{lset.insert(i);i+=1}
      expect{lset.insert(i)}.to raise_error(RuntimeError, "LSet is full")
    end

    it "В полностью заполненное мн-во можно добавить элемент который там есть" do
      i=0
      LSet::DEF_SIZE.times{lset.insert(i);i+=1}
      expect{lset.insert(i-1)}.not_to raise_error
    end
  end
end
