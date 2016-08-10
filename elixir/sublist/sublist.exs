defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare( a, b ) do
    { shorter, s_length, longer, l_length, switched } = order_lists( a, b )
    is_sublist = traverse_lists( { shorter, s_length, longer, l_length }, 0, 0, 0 )

    case is_sublist do
      true -> 
        cond do 
          ( s_length === l_length ) -> :equal
          ( switched === true )     -> :superlist
          true                     -> :sublist
        end
      false -> :unequal
    end
  end

  def traverse_lists( { shorter, s_length, longer, l_length }, pointer_s, pointer_l, cached_l ) do     
    cond do 
      ( pointer_s >= s_length ) -> true
      ( pointer_l >= l_length ) -> false
      true -> 
        cond do 
          Enum.at( longer, pointer_l ) === Enum.at( shorter, pointer_s ) -> 
            pointer_l = pointer_l + 1 # npa: look for a better way to do this
            pointer_s = pointer_s + 1
          true -> 
            cached_l = cached_l + 1
            pointer_l = cached_l
            pointer_s = 0            
        end
        traverse_lists( { shorter, s_length, longer, l_length }, pointer_s, pointer_l, cached_l )    
    end
  end

  def order_lists( a, b ) do # npa: can this be done more efficiently?
    a_length = length( a )
    b_length = length( b )
    if a_length <= b_length do 
      { a, a_length, b, b_length, false }
    else
      { b, b_length, a, a_length, true }
    end   
  end
end
