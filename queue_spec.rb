require 'rspec'
require_relative './queue'

describe Queue do

  let(:queue) { Queue.new }

  context "Свойства методов empty? и empty:" do
    it "только что созданная очередь является пустой" do
      expect(queue.empty?).to be true
    end

    it "пустая очередь с добавленным в нее элементом не является пустой" do
      queue.enqueue(17)
      expect(queue.empty?).to be false
    end

    it "после вызова метода empty очередь становится пустой" do
      queue.enqueue(17)
      queue.empty
      expect(queue.empty?).to be true
    end
  end

  context "Особенности работы с пустой и полностью заполненной очередью:" do
    it "из пустой очереди нельзя ничего извлечь" do
      expect{queue.dequeue}.to raise_error(RuntimeError, "Queue is empty")
    end

    it "у пустой очереди ничего не лежит на вершине" do
      expect{queue.front}.to raise_error(RuntimeError, "Queue is empty")
    end

    it "в пустую очередь можно положить лишь ограниченное число элементов" do
      Queue::DEF_SIZE.times{queue.enqueue(17)}
      expect{queue.enqueue(17)}.to raise_error(RuntimeError, "Queue is full")
    end
    it " пустая очередь отличима от заполненной" do
      Queue::DEF_SIZE.times{queue.enqueue(17)}
      expect(queue.empty?).to be false
    end
  end

  context "Особенности метода forward:" do
    it "при последовательном заполнении и опустошении очереди не происходит заполнения" do
      queue.enqueue(17)
      Queue::DEF_SIZE.times do
        queue.enqueue(17)
        queue.dequeue
      end
      expect(queue.size).to be < Queue::DEF_SIZE
    end
  end


  context "Особенности дисциплины обслуживания FIFO:" do
    it "первым пришёл - первым ушёл" do
      queue.enqueue(17)
      queue.enqueue(18)
      expect(queue.front).to eq 17
      expect(queue.dequeue).to eq 17
      expect(queue.front).to eq 18
      expect(queue.dequeue).to eq 18
    end
  end
end
