`use strict`;
const http = require(`http`);

const requestHandler = function(req, res){
    res.end(`hello world!`);
};

const server = http.createServer(requestHandler);

server.listen(8080, function(err){
    console.log(`HTTP server started at port 8080`);
});