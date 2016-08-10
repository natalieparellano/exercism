defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode( string ) do
    string |> letters() |> atoms() |> make_tups() |> format_tups()
  end

  defp atoms( letters ) do 
    Enum.map letters, fn( let ) -> String.to_atom( let ) end 
  end

  defp encode_one( last_tup, let ) do 
    { last_let, last_count } = last_tup
    if last_let == let do
      [increment_tup( last_tup )]
    else
      [{ let, 1 }] ++ [last_tup]
    end
  end

  defp format_tups( tup_list ) do
    List.foldr tup_list, "", fn( { let, count_let }, str ) ->
      str <> Integer.to_string( count_let ) <> Atom.to_string( let )
    end    
  end

  defp increment_tup( { let, count_let } ) do 
    { let, count_let + 1 }
  end  

  defp letters( string ) do 
    String.split( string, "", trim: true )
  end  

  defp make_tups( atoms ) do 
    Enum.reduce atoms, [], fn( let, list ) -> 
      if ( last_tup = List.first( list )) do
        new_last = encode_one( last_tup, let )
        new_last ++ tl( list )
      else
        [{ let, 1 }] ++ list
      end
    end
  end

  ### 

  @spec decode(String.t) :: String.t
  def decode( string ) do
    string |> raw_pairs() |> pairs() |> decode_pairs() |> concat_strs()
  end

  defp concat_strs( strs ) do 
    # IO.puts "\nstrs: #{strs}"
    List.foldl strs, "", fn( str, acc ) -> acc <> str end 
  end

  defp decode_pair( { count_let, let } ) do 
    # IO.puts "\ncount_let: #{count_let}"
    # IO.puts "\nlet: #{let}"
    count_let = String.to_integer( count_let )
    range = 1..count_let
    Enum.reduce range, "", fn( i, str ) ->
      str <> let
    end
  end

  defp decode_pairs( pairs ) do 
    Enum.reduce pairs, [], fn( pair, list ) -> list ++ [decode_pair( pair )] end 
  end

  defp pairs( raw_pairs ) do 
    # IO.puts "\nraw_pairs: #{raw_pairs}"
    List.foldl raw_pairs, [], fn( [cp1, cp2], list ) -> 
      list ++ [String.split_at( cp1, -1 )] 
    end
  end

  defp raw_pairs( string ) do 
    # IO.puts "\nstring: #{string}"
    Regex.scan( ~r/(\d+\w)/, string )
  end
end
