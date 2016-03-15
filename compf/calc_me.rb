#!/usr/bin/env ruby
require_relative 'compf'
#
# Интерпретатор арифметических выражений вычисляет значения
# правильных арифметических формул, в которых в качестве
# операндов допустимы только цифры /^[0-9]$/
#
class Calc < Compf
  def initialize
    # Вызов метода initialize класса Compf
    super
    # Создание стека для работы стекового калькулятора
    @s = Stack.new
    @str=""
    @roman = [
    ["M"  , 1000],
    ["CM" , 900],
    ["D"  , 500],
    ["CD" , 400],
    ["C"  , 100],
    ["XC" ,  90],
    ["L"  ,  50],
    ["XL" ,  40],
    ["X"  ,  10],
    ["IX" ,   9],
    ["V"  ,   5],
    ["IV" ,   4],
    ["I"  ,   1]
    ]
  end

  def toArabic(rom)
      reply = 0
      for key, value in @roman
          while rom.index(key) == 0
              reply += value
              rom.slice!(key)
          end
      end
      reply
  end

  # Интерпретация арифметического выражения
  def compile(str)
    super
    @s.top
  end

  private

  # Проверка допустимости символа
  def check_symbol(c)
    raise "Недопустимый символ '#{c}'" if c !~ /[I,V,X,L,C,D,M]/
  end

  def process_symbol(c)
     if sym_type(c) != SYM_OTHER && @str != ""
       @s.push(toArabic(@str))
       @str = ""
     end
     super
  end

  # Заключительная обработка цифры
  def process_value(c)
    @str+=c
  end

  # Заключительная обработка символа операции
  def process_oper(c)
    second, first = @s.pop, @s.pop
    @s.push(first.method(c).call(second))
  end
end

if $0 == __FILE__
  c = Calc.new
  loop do
    print "Арифметическое выражение: "
    str = gets.chomp
    print "Результат его вычисления: "
    puts c.compile(str)
    puts
  end
end
