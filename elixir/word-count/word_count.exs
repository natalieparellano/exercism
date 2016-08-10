defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count( String.t ) :: map
  def count( sentence ) do
    words = String.split( sentence, [" ", "_"] )

    Enum.reduce words, %{}, fn( word, acc ) -> 
      if ( match_term = Regex.run( ~r/[\w\-]+/u, word )) do 
        word_part = String.downcase( hd( match_term ))
        val = Map.get( acc, word_part, 0 ) + 1
        Map.put( acc, word_part, val )
      else
        acc
      end
    end
  end
end
