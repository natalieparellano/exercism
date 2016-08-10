defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
  	seconds / get_seconds_per_orbit( planet )
  end

  def get_seconds_per_orbit( planet ) do 
  	seconds_per_orbit[planet]
  end

  def seconds_per_orbit do 
  	%{  		
  		:mercury => 7_600_526,
  		:venus   => 19_411_026,
  		:earth   => 31_558_118,
  		:mars    => 59_359_777,
  		:jupiter => 374_222_565,
  		:saturn  => 929_386_587,
  		:uranus  => 2_652_994_592,
  		:neptune => 5_196_280_668,
  	}
  end
end
