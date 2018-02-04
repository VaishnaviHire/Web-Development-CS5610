defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Basic Operation" do
    assert Calc.eval("5+2") == 7
  end
  
   test "Divide by 0" do
    assert Calc.eval("1/0") == "Can`t divide by zero"
   end

   test "nested brackets" do
    assert Calc.eval("5*4 + (2+8*(3*10)) / 2") == 141
   end

   test "Handling integer division" do
     assert Calc.eval("5 / 2 / 4") == 0
   end

   test "Handling spaces" do
     assert Calc.eval("2+3 + (5/8+60+(20/4) + 10)") == 80
   end 
end
