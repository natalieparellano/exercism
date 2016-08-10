defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count( strand, nucleotide ) do
    dict = get_dict( strand )
    get_from_dict( nucleotide, dict )
  end

  def get_from_dict( el, dict ) do 
    if valid?( el ) do 
      Map.get( dict, el, 0 )
    else
      raise ArgumentError
    end    
  end

  def add_to_dict( el, dict ) do
    # IO.puts "El is #{el}"
    if valid?( el ) do
      val = Map.get( dict, el, 0 ) + 1
      Map.put( dict, el, val )
    else
      raise ArgumentError
    end
  end

  def default_dict do
    %{ ?A => 0, ?T => 0, ?C => 0, ?G => 0 }
  end

  def get_dict( strand ) do # 'CCCCCC'
    List.foldl( strand, %{}, fn( nuc, dict ) -> # 67
      add_to_dict( nuc, dict )
    end )    
  end

  def valid?( el ) do 
    Enum.member?( ["A", "T", "C", "G"], <<el :: utf8>> ) # ??? possible to cast to char instead of string?
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.merge( default_dict, get_dict( strand ))
  end
end
