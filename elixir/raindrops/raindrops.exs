alias :math, as: Math

defmodule Raindrops do  
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    output = number |> get_factors() |> Enum.uniq() |> get_output()
    finalize_output( output, number ) # npa: how to pipe to the nth argument in a function?
  end

  def check_one( number, test, factors ) when number === 1 do 
    factors
  end

  def check_one( number, test, factors ) do 
    # IO.puts "In check_one..."
    # IO.puts "number is #{number}"
    # IO.puts "test is #{test}"
    if rem( number, test ) === 0 do 
      new_factors = factors ++ [test]
      new_number = round( number / test ) # convert to Integer
      check_one( new_number, test, new_factors )
    else
      check_one( number, test + 1, factors )
    end
  end

  def finalize_output( output, number ) do 
    if output === "" do 
      Integer.to_string( number )
    else
      output
    end    
  end

  def get_factors( number ) do 
    check_one( number, 2, [] )
  end

  def get_output( factors ) do 
    Enum.reduce factors, "", fn( factor, str ) -> 
      str <> cond do 
        factor === 3 -> "Pling"
        factor === 5 -> "Plang"
        factor === 7 -> "Plong"
        true -> ""        
      end
    end
  end

  # Previous strategy...

  # def get_factors( number ) do
  #   range = 2..round( Float.floor( Math.sqrt( number )))
  #   Enum.flat_map_reduce( range, number, fn( test, acc ) -> 
  #     if acc > 1 do       
  #       check_one( acc, test, [] ) # returns { factors, number }
  #     else
  #       { :halt, acc }
  #     end
  #   end )
  # end
end
