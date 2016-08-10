defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate( String.t()) :: String.t()
  def abbreviate( string ) do
    match_terms = Regex.scan( ~r/\s(\w)|([A-Z])/u, string )
    Enum.reduce match_terms, "", fn( term, acc ) -> 
      letter = String.upcase( List.last( term ))
      acc <> letter
    end
  end
end
