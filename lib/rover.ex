defmodule Rover do
  @moduledoc """
  Rover defines how to create and command a single rover.
  """

  @enforce_keys [:x, :y, :heading, :commands, :max_x, :max_y]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          x: integer(),
          y: integer(),
          heading: heading(),
          commands: commands(),
          max_x: integer(),
          max_y: integer()
        }

  @type heading :: :north | :west | :south | :east
  @type commands :: :left | :right | :forward

  @spec new(integer, integer, heading, [commands], integer, integer) ::
          %__MODULE__{}
  def new(
        x,
        y,
        heading,
        commands,
        max_x,
        max_y
      ) do
    %__MODULE__{
      x: x,
      y: y,
      heading: heading,
      commands: commands,
      max_x: max_x,
      max_y: max_y
    }
  end

  @spec navigate(%__MODULE__{}) :: %__MODULE__{}
  def navigate(%__MODULE__{commands: commands} = rover)
      when length(commands) > 0 do
    rover |> command |> navigate
  end

  def navigate(rover), do: rover

  @spec command(%__MODULE__{}) :: %__MODULE__{}
  def command(%__MODULE__{commands: commands} = rover)
      when length(commands) > 0 do
    [command | commands] = rover.commands

    case command do
      :left ->
        %__MODULE__{rover | heading: __MODULE__.left(rover), commands: commands}

      :right ->
        %__MODULE__{
          rover
          | heading: __MODULE__.right(rover),
            commands: commands
        }

      :forward ->
        [x, y] = __MODULE__.forward(rover)

        %__MODULE__{
          rover
          | x: x,
            y: y,
            commands: commands
        }
    end
  end

  def command(rover), do: rover

  @spec left(%__MODULE__{}) :: heading
  def left(%__MODULE__{heading: heading}) do
    case heading do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
    end
  end

  @spec right(%__MODULE__{}) :: heading
  def right(%__MODULE__{heading: heading}) do
    case heading do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  # TODO better spec for return
  @spec forward(%__MODULE__{}) :: [integer]
  def forward(%__MODULE__{
        heading: heading,
        x: x,
        y: y,
        max_x: max_x,
        max_y: max_y
      }) do
    case heading do
      :north when y == max_y -> [x, 0]
      :north -> [x, y + 1]
      :south when y == 0 -> [x, max_y]
      :south -> [x, y - 1]
      :east when x == max_x -> [0, y]
      :east -> [x + 1, y]
      :west when x == 0 -> [max_x, y]
      :west -> [x - 1, y]
    end
  end
end
