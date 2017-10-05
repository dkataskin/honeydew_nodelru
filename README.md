# Init
* Get dependencies `mix deps.get` and compile `mix compile`
* Start two nodes and connect them: `iex --name "node1@127.0.0.1" --cookie 123456 -S mix` and `iex --name "node2@127.0.0.1" --cookie 123456 -S mix`, then `Node.connect(:'node1@127.0.0.1')` on the second node.
* See only 10 tasks executed on the second node
* Queue status after 10 tasks executed looks like:

```
Honeydew.status({:global, :test_queue})

%{queue: %{count: 0, in_progress: 0, suspended: false},
  workers: %{#PID<18569.165.0> => nil, #PID<0.165.0> => nil,
    #PID<18569.166.0> => nil, #PID<0.166.0> => nil, #PID<18569.167.0> => nil,
    #PID<0.167.0> => nil, #PID<18569.168.0> => nil, #PID<0.168.0> => nil,
    #PID<18569.169.0> => nil, #PID<0.169.0> => nil, #PID<18569.170.0> => nil,
    #PID<0.170.0> => nil, #PID<18569.171.0> => nil, #PID<0.171.0> => nil,
    #PID<18569.172.0> => nil, #PID<0.172.0> => nil, #PID<18569.173.0> => nil,
    #PID<0.173.0> => nil, #PID<18569.174.0> => nil, #PID<0.174.0> => nil}}
```

# Scheduler 
Scheduler sends a task for execution each second and assings task monotonically increased integer Id, scheduler only starts if node name starts with "node1".
