const http = require('http');
const server = http.createServer(function(req, res){
    res.end(`Hello from Nodejs ${process.version}`);
});
server.listen(8080);