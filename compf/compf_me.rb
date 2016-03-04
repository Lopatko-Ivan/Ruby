#!/usr/bin/env ruby
require_relative 'stack'
#
# Стековый компилятор формул преобразует правильные
# арифметические формулы (цепочки языка, задаваемого
# грамматикой G0) в программы для стекового калькулятора
# (цепочки языка, определяемого грамматикой Gs):
#
# G0:
#     F  ->  T  |  F+T  |  F-T
#     T  ->  M  |  T*M  |  T/M
#     M  -> (F) |   V
#     V  ->  a  |   b   |   c   |  ...  |    z
#
# Gs:
#     e  ->  e e + | e e - | e e * | e e / |
#            | a | b | ... | z
#
# В качестве операндов в формулах допустимы только
# однобуквенные имена переменных /^[a-z]$/
#
class Compf < Stack
  # Константы, задающие тип символа
  SYM_LEFT  = 0 # '('
  SYM_RIGHT = 1 # ')'
  SYM_OPER  = 2 # '+', '-', '*', '/'
  SYM_OTHER = 3 # иные символы

  def initialize
    # Вызов метода initialize класса Stack
    super
    #Создание массива с результатом компиляции
    @data = Array.new
  end

  def compile(str)
    @data.clear
    # Последовательный вызов для всех символов
    # взятой в скобки формулы метода process_symbol
    "(#{str})".each_char{|c| process_symbol(c)}
    compile2(@data)
  end

  private

  # Определение типа символа
  def sym_type(c)
    case c
    when '('
      SYM_LEFT
    when ')'
      SYM_RIGHT
    when '+', '-', '*', '/'
      SYM_OPER
    else
      check_symbol(c)
      SYM_OTHER
    end
  end

  # Проверка допустимости символа
  def check_symbol(c)
    raise "Недопустимый символ '#{c}'" if c !~ /[a-z]/
  end

  # Обработка символа
  def process_symbol(c)
    case sym_type(c)
    when SYM_LEFT
      push(c)
    when SYM_RIGHT
      process_suspended_operators(c)
      pop
    when SYM_OPER
      process_suspended_operators(c)
      push(c)
    when SYM_OTHER
      process_value(c)
    end
  end

  # Заключительная обработка имени переменной
  def process_value(c)
    @data << c
  end

  # Заключительная обработка символа операции
  def process_oper(c)
    @data <<  c
  end

  # Обработка отложенных операций
  def process_suspended_operators(c)
    while precedes?(top, c)
      process_oper(pop)
    end
  end

  # Определение приоритета операции
  def priority(c)
    (c == '+' or c == '-') ? 1 : 2
  end

  # Определение отношения предшествования
  def precedes?(a, b)
    return false if sym_type(a) == SYM_LEFT
    return true  if sym_type(b) == SYM_RIGHT
    priority(a) >= priority(b)
  end

  #поиск первого оператора
  def find_op(ar)
    a=[]
    n1=ar.index("*")
    n2=ar.index("/")
    n3=ar.index("+")
    n4=ar.index("-")
    a << n1
    a << n2
    a << n3
    a << n4
    a.compact!
    a.min
  end

  # Преобразование формулы стекового компилятора в нужную
  def compile2(ar)
    while find_op(ar)!=nil
      n=find_op(ar)
      ar[n-2,3]="(#{ar[n-2]}#{ar[n]}#{ar[n-1]})"
    end
    ar.join('')
  end
end

if $0 == __FILE__
  c = Compf.new
  loop do
    print "Арифметическая  формула: "
    str = gets.chomp
    print "Результат её компиляции: "
    puts c.compile(str)
    puts
  end
end
