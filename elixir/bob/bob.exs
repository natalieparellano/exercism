defmodule Bob do
  def hey( input ) do
    cond do
      Regex.match?( ~r/.+\?$/, input ) -> "Sure."      

      Regex.match?( ~r/.*\p{Lu}{2,}.*/u, input ) -> "Whoa, chill out!"

      Regex.match?( ~r/\w+/, input ) -> "Whatever."

      true -> "Fine. Be that way!"
    end
  end
end
