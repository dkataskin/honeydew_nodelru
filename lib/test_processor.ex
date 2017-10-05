defmodule HoneydewNodeLRU.TestProcessor do
  require Logger

  def init(args) do
    {:ok, args}
  end

  def process(id, _state) do
    Logger.debug "#{node()}: processed job id=#{id}"
  end
end
