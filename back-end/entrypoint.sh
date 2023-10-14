#!/bin/sh

# Start Ganache
ganache --port 7545 --networkId 5777 --host 0.0.0.0 &

# Wait for Ganache to start (adjust the sleep duration as needed)
sleep 5

# Run Truffle migration
truffle migrate

sleep 5

npm start

# Add any additional commands you need to start your Node.js application or perform other tasks.
# For example, to start your Node.js application:
# node your_app.js