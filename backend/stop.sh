#!/bin/bash
echo "Stopping Node.js application..."

PORT=3000  # <-- update if your app runs on another port
PID=$(lsof -t -i:$PORT)

if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Stopped process on port $PORT (PID: $PID)"
else
  echo "No process running on port $PORT"
fi

exit 0
