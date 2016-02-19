#!/bin/bash

mesos_master="192.168.122.11"

for i in task-data/marathon/*.json; do
  echo "Deploying ${i} to Marathon"
  curl -L -H "Content-Type: application/json" -X POST "http://${mesos_master}:8080/v2/apps?force=true" -d@${i} &> /dev/null
done

for i in task-data/chronos/*.json; do
  echo "Deploying ${i} to Chronos"
  curl -L -H "Content-Type: application/json" -X POST "http://${mesos_master}:4400/scheduler/iso8601" -d@${i} &> /dev/null 
done
