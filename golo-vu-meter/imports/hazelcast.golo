module Distributed

import com.hazelcast.core
import com.hazelcast.config
import java.lang.invoke.MethodHandles

let instance = Hazelcast.newHazelcastInstance()

let adapter_fabric = AdapterFabric()

function item_listener = |added, removed| {
  let conf = map[
    ["interfaces", ["com.hazelcast.core.ItemListener"]],
    ["implements", map[
      ["itemAdded", added],
      ["itemRemoved", removed]
    ]]
  ]
  return adapter_fabric: maker(conf): newInstance()
}

function distributed_list = |name| -> instance: getList(name)

function topic = |name| -> instance: getTopic(name)

function queue = |name| -> instance: getQueue(name)
