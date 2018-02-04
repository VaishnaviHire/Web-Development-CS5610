defmodule Calc do

# Function to take user input in a loop
 def main() do
 	eval(IO.gets(""))
  	|> IO.inspect
  	main()
 end

# Function takes a string input and returns an integer after evaluation
 def eval(str) do
  	parser(str)
  	|>List.delete(nil)
  	|>calculate([], [])

 end


# Function takes a string input and parse it into list of integers and string
  def parser(str) do
        str
        |>String.split(~r/()[\+|)|\(|\-|\*|\/|^|!|]()/,
                trim: true, include_captures: true)
        |> Enum.map(fn(x) -> String.trim(x) end)
        |> Enum.map(fn(x) -> if Integer.parse(x) == :error
				 do x
                             else 
				 Integer.parse(x)
                                 |> elem(0) end end)
        
	|> Enum.filter(fn(x) -> x != "" end )




  end

# Function returns a tuple with last element and list after elimination of that 
# element from a the given list
 def pop(list) do
 	List.pop_at(list, -1)
 end

# Function returns the list after addition of the given element at the end
 def push(list, element) do
 	List.insert_at(list, -1, element)
 end

# Function returns an integer after evaluating the given list using values and 
# operands stack.
 def calculate(list,values, operands) do
 	
 	{curr,list} = List.pop_at(list,0)
   	cond do
   	is_integer(curr) -> values = push(values, curr)
                            calculate(list,values,operands)

   	curr == "(" ->  operands = push(operands, curr)
                   	calculate(list,values,operands)

   	curr == ")" -> {values, operands} =  brackets_eval(operands,values)
                       calculate(list, values,operands)

   	curr == "+" or curr == "-" or curr == "/" or curr =="*" ->
                 	{values,operands} = precedence_eval(curr,
                                                             operands, values)
                 	calculate(list, values, operands)
   	
	list == []  -> { values, _} = check_empty(operands, values)
                       pop(values) |> elem(0)


        end
 end

# Helper function to evaluate expression in brackets
 def brackets_eval(operands1, values1) do

	cond do

 	List.last(operands1) != "(" -> {val2,values1} = pop(values1)
                                       {val1, values1} = pop(values1)
                                       {op, operands1} = pop(operands1)
                                       values1 = push(values1,
							operate(val1, val2, op))
                                       brackets_eval(operands1, values1)
 	List.last(operands1) == "(" -> {_ , operands1} = pop(operands1)
                                {values1, operands1}
	end
 end

# Helper function to evaluate numbers using given operator
 def operate(num1, num2, opr) do
 	cond do

   	opr == "+" -> num1 + num2
   	opr == "-" -> num1 - num2
   	opr ==  "*" -> num1 * num2
   	opr ==  "/" -> if num2 != 0 do
		   	  div(num1, num2)
		       else
		    	  "Can`t divide by zero"|> IO.inspect
			  System.halt(0) end
   	true-> 0
	end
 end

#Helper function to handle operands stack after the given string is traversed
 def check_empty(operands1, values1) do
	cond do
	operands1 != [] -> {val2, values1} = pop(values1)
                           {val1, values1} = pop(values1)
                           {op, operands1} = pop(operands1)
                           values1 = push(values1,operate(val1,val2,op))
                           check_empty(operands1, values1)

	true ->
        {values1, operands1}
	end
 end

# Helper function to determine precedence values of the operations
 def precedence(op1, op2) do
	cond do

	op2 == "(" or op2 == ")" -> false
	(op1 == "*" or op1 == "/") and (op2 == "+" or op2 == "-") -> false
	true -> true

	end
 end

# Helper function to evaluate expression using their precedence values
 def precedence_eval(currelem,operands1, values1) do
	cond do
	operands1 != []  and precedence(currelem, List.last(operands1))==true
		-> {op, operands1} = pop(operands1)
   		   {val2, values1} = pop(values1)
   		   {val1, values1} = pop(values1)
   		   values1 = push(values1, operate(val1, val2, op))
   		   precedence_eval(currelem, operands1,values1)

  	true -> operands1 = push(operands1, currelem)
        	{values1, operands1}
	end
 end

end

                                                    

