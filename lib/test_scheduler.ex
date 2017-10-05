defmodule HoneydewNodeLRU.TestScheduler do
  use GenServer

  require Logger

  @poll_interval 1000

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    Logger.info "test scheduler is starting..."

    send_self()

    {:ok, 0}
  end

  def handle_cast(_request, state), do: {:noreply, state}

  def handle_info(:process, num) do
    send_self(:delay)

    Honeydew.async({:process, [num + 1]}, {:global, :test_queue})

    {:noreply, num + 1}
  end

  def handle_info(_info, state), do: {:noreply, state}

  def terminate(_reason, _state), do: :ok

  def code_change(_old_vsn, state, _extra), do: {:ok, state}

  defp send_self(), do: send(self(), :process)
  defp send_self(:delay), do: Process.send_after(self(), :process, 1 * @poll_interval)
end
