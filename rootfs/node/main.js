`use strict`;
const http = require(`http`);
const server = http.createServer(function(req, res){
    res.end(`Node: ${process.version}`);
});
server.listen(8080);