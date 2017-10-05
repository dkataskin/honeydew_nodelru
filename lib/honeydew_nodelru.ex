defmodule HoneydewNodeLRU do
  use Application
  import Supervisor.Spec
  require Logger

  def start(_type, _args) do
    Logger.info "app starting..."

    name = node() |> to_string()

    queue_job_specs = queue_job_specs()

    workers =
      if String.contains?(name, "node1") do
        [worker(HoneydewNodeLRU.TestScheduler, [[]], [])]
      else
        []
      end

    children = queue_job_specs ++ workers
    res = Supervisor.start_link(children, strategy: :one_for_one)

    Logger.info "app started..."
    res
  end

  defp queue_job_specs() do
    [
       Honeydew.queue_spec({:global, :test_queue}),
       Honeydew.worker_spec({:global, :test_queue},
                            {HoneydewNodeLRU.TestProcessor, []},
                            num: 10,
                            init_retry_secs: 10,
                            shutdown: 60_000)
    ]
  end
end
