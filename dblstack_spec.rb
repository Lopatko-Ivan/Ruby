require 'rspec'
require_relative './dblstack'

describe DblStack do

  let(:dblstack) { DblStack.new }

  context "Свойства методов empty? и empty:" do
    it "только что созданные стеки являются пустыми" do
      expect(dblstack.empty?(0)).to be true
      expect(dblstack.empty?(1)).to be true
      expect(dblstack.empty?).to be true
    end

    it "пустой первый стек с добавленным в него элементом не является пустым" do
      dblstack.push(0,17)
      expect(dblstack.empty?).to be false
      expect(dblstack.empty?(0)).to be false
      expect(dblstack.empty?(1)).to be true
    end

    it "пустой второй стек с добавленным в него элементом не является пустым" do
      dblstack.push(1,17)
      expect(dblstack.empty?).to be false
      expect(dblstack.empty?(1)).to be false
      expect(dblstack.empty?(0)).to be true
    end

    it "пустые стеки с добавленными в них элементами не являются пустыми" do
      dblstack.push(1,17)
      dblstack.push(0,17)
      expect(dblstack.empty?).to be false
      expect(dblstack.empty?(1)).to be false
      expect(dblstack.empty?(0)).to be false
    end

    it "после вызова метода empty стеки становятся пустыми" do
      dblstack.push(0,17)
      dblstack.push(1,17)
      dblstack.empty
      expect(dblstack.empty?).to be true
      expect(dblstack.empty?(0)).to be true
      expect(dblstack.empty?(1)).to be true
    end

    it "после вызова метода empty первый стек становится пустым" do
      dblstack.push(0,17)
      dblstack.push(1,17)
      dblstack.empty(0)
      expect(dblstack.empty?).to be false
      expect(dblstack.empty?(0)).to be true
      expect(dblstack.empty?(1)).to be false
    end

    it "после вызова метода empty второй стек становится пустым" do
      dblstack.push(0,17)
      dblstack.push(1,17)
      dblstack.empty(1)
      expect(dblstack.empty?).to be false
      expect(dblstack.empty?(0)).to be false
      expect(dblstack.empty?(1)).to be true
    end
  end



  context "Особенности работы с пустым и полностью заполненным стеком:" do
    it "из пустого стека нельзя ничего извлечь" do
      expect{dblstack.pop(0)}.to raise_error(RuntimeError, "Stack is empty")
      expect{dblstack.pop(1)}.to raise_error(RuntimeError, "Stack is empty")
    end

    it "у пустого стека ничего не лежит на вершине" do
      expect{dblstack.top(0)}.to raise_error(RuntimeError, "Stack is empty")
      expect{dblstack.top(1)}.to raise_error(RuntimeError, "Stack is empty")
    end

    it "в пустой стек можно положить лишь ограниченное число элементов в начало" do
      DblStack::DEF_SIZE.times{dblstack.push(0,17)}
      expect{dblstack.push(0,17)}.to raise_error(RuntimeError, "Stacks are full")
      expect{dblstack.push(1,17)}.to raise_error(RuntimeError, "Stacks are full")
    end

    it "в пустой стек можно положить лишь ограниченное число элементов в конец" do
      DblStack::DEF_SIZE.times{dblstack.push(1,17)}
      expect{dblstack.push(1,17)}.to raise_error(RuntimeError, "Stacks are full")
      expect{dblstack.push(0,17)}.to raise_error(RuntimeError, "Stacks are full")
    end

    it "в пустой стек можно положить лишь ограниченное число элементов" do
      x=
      (DblStack::DEF_SIZE-3).times{dblstack.push(0,17)}
      (3).times{dblstack.push(1,17)}
      expect{dblstack.push(1,17)}.to raise_error(RuntimeError, "Stacks are full")
      expect{dblstack.push(0,17)}.to raise_error(RuntimeError, "Stacks are full")
    end

  end

  context "Особенности дисциплины обслуживания LIFO:" do
    it "первым пришёл - последним ушёл" do
      dblstack.push(0,17)
      dblstack.push(1,18)
      dblstack.push(0,19)
      dblstack.push(1,20)
      expect(dblstack.top(0)).to eq 19
      expect(dblstack.pop(0)).to eq 19
      expect(dblstack.top(1)).to eq 20
      expect(dblstack.pop(1)).to eq 20
      expect(dblstack.top(0)).to eq 17
      expect(dblstack.pop(0)).to eq 17
      expect(dblstack.top(1)).to eq 18
      expect(dblstack.pop(1)).to eq 18
    end
  end

  context "Особенности работы с неправильным стеком:" do
    it "вызов метода empty вызывает ошибку" do
	expect{dblstack.empty(2)}.to raise_error(RuntimeError, "Wrong stack")
    end

    it "вызов метода empty? вызывает ошибку" do
	expect{dblstack.empty?(2)}.to raise_error(RuntimeError, "Wrong stack")
    end

    it "вызов метода push вызывает ошибку" do
	expect{dblstack.push(2,18)}.to raise_error(RuntimeError, "Wrong stack")
    end

    it "вызов метода pop вызывает ошибку" do
	expect{dblstack.pop(2)}.to raise_error(RuntimeError, "Wrong stack")
    end

    it "вызов метода top вызывает ошибку" do
	expect{dblstack.top(2)}.to raise_error(RuntimeError, "Wrong stack")
    end
  end
end
