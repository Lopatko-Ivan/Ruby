require 'rspec'
require_relative './dequeue'

describe Dequeue do

  let(:dequeue) { Dequeue.new }

  context "Свойства методов empty? и empty:" do
    it "только что созданный дек является пустым" do
      expect(dequeue.empty?).to be true
    end

    it "пустой дек с добавленным в него элементом в начало не является пустым" do
      dequeue.push_front(17)
      expect(dequeue.empty?).to be false
    end

    it "пустой дек с добавленным в него элементом в конец не является пустым" do
      dequeue.push_back(17)
      expect(dequeue.empty?).to be false
    end

    it "после вызова метода empty дек становится пустым" do
      dequeue.push_back(17)
      dequeue.empty
      expect(dequeue.empty?).to be true
    end
  end

  context "Особенности работы с пустым и полностью заполненным деком:" do
    it "из пустого дека нельзя ничего извлечь сзади" do
      expect{dequeue.pop_back}.to raise_error(RuntimeError, "Dequeue is empty")
    end

    it "из пустго дека нельзя ничего извлечь спереди" do
      expect{dequeue.pop_front}.to raise_error(RuntimeError, "Dequeue is empty")
    end

    it "у пустого дека ничего не лежит на вершине" do
      expect{dequeue.front}.to raise_error(RuntimeError, "Dequeue is empty")
    end

    it "у пустого дека ничего не лежит на дне" do
      expect{dequeue.back}.to raise_error(RuntimeError, "Dequeue is empty")
    end

    it "в пустой дек можно положить лишь ограниченное число элементов сзади" do
      Dequeue::DEF_SIZE.times{dequeue.push_back(17)}
      expect{dequeue.push_back(17)}.to raise_error(RuntimeError, "Dequeue is full")
      expect{dequeue.push_front(17)}.to raise_error(RuntimeError, "Dequeue is full")
    end

    it "в пустой дек можно положить лишь ограниченное число элементов спереди" do
      Dequeue::DEF_SIZE.times{dequeue.push_front(17)}
      expect{dequeue.push_back(17)}.to raise_error(RuntimeError, "Dequeue is full")
      expect{dequeue.push_front(17)}.to raise_error(RuntimeError, "Dequeue is full")
    end

    it " пустой дек отличим от заполненного сзади" do
      Dequeue::DEF_SIZE.times{dequeue.push_back(17)}
      expect(dequeue.empty?).to be false
    end

    it " пустой дек отличим от заполненного спереди" do
      Dequeue::DEF_SIZE.times{dequeue.push_front(17)}
      expect(dequeue.empty?).to be false
    end
  end

  context "Особенности дисциплины обслуживания FIFO:" do
    it "первым пришёл - первым ушёл" do
      dequeue.push_back(17)
      dequeue.push_front(18)
      dequeue.push_front(19)
      dequeue.push_back(16)
      expect(dequeue.front).to eq 19
      expect(dequeue.back).to eq 16
      expect(dequeue.pop_back).to eq 16
      expect(dequeue.pop_front).to eq 19
      expect(dequeue.front).to eq 18
      expect(dequeue.back).to eq 17
      expect(dequeue.pop_back).to eq 17
      expect(dequeue.pop_front).to eq 18
      expect(dequeue.empty?).to be true
    end
  end
end
