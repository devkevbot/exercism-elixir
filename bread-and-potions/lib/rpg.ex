defmodule RPG do
  defprotocol Edible do
    def eat(item, character)
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []

    defimpl Edible, for: LoafOfBread do
      def eat(_, character) do
        {nil, %Character{character | health: character.health + 5}}
      end
    end
  end

  defmodule ManaPotion do
    defstruct strength: 10

    defimpl Edible, for: ManaPotion do
      alias RPG.EmptyBottle

      def eat(potion, character) do
        {%EmptyBottle{}, %Character{character | mana: character.mana + potion.strength}}
      end
    end
  end

  defmodule Poison do
    defstruct []

    defimpl Edible, for: Poison do
      def eat(_, character) do
        {%EmptyBottle{}, %Character{character | health: 0}}
      end
    end
  end
end
