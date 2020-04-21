const Server = require('./app/server');

const server = Server.getInstance();
const port = 3000;

server.start(port);