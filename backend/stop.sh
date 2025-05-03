#!/bin/bash

echo "Stopping Node.js application..."

# Kill process running on your app port, e.g., 3000 (update if needed)
PORT=3000
PID=$(lsof -t -i:$PORT)

if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Stopped process on port $PORT (PID: $PID)"
else
  echo "No process running on port $PORT"
fi

exit 0
