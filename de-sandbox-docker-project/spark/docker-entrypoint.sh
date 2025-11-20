#!/usr/bin/env bash
set -e

# Simple entrypoint to start master / worker / history depending on SPARK_MODE env var
if [ "$SPARK_MODE" = "master" ]; then
  echo "Starting Spark Master..."
  $SPARK_HOME/sbin/start-master.sh -h 0.0.0.0
  tail -f /dev/null
elif [ "$SPARK_MODE" = "worker" ]; then
  if [ -z "$SPARK_MASTER_URL" ]; then
    echo "SPARK_MASTER_URL not set. Exiting."
    exit 1
  fi
  echo "Starting Spark Worker connecting to $SPARK_MASTER_URL ..."
  $SPARK_HOME/sbin/start-worker.sh "$SPARK_MASTER_URL"
  tail -f /dev/null
elif [ "$SPARK_MODE" = "history" ]; then
  echo "Starting Spark History Server..."
  $SPARK_HOME/sbin/start-history-server.sh
  tail -f /dev/null
else
  exec "$@"
fi
