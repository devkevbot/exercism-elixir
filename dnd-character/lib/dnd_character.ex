defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((score - 10) / 2) |> floor()
  end

  @spec ability :: pos_integer()
  def ability do
    rolls = [
      Enum.random(1..6),
      Enum.random(1..6),
      Enum.random(1..6),
      Enum.random(1..6)
    ]

    rolls |> Enum.sort(:asc) |> tl() |> Enum.sum()
  end

  @spec character :: t()
  def character do
    constitution = ability()

    %DndCharacter{
      constitution: constitution,
      hitpoints: 10 + modifier(constitution),
      strength: ability(),
      dexterity: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }
  end
end
