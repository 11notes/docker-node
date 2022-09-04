`use strict`;
const http = require(`http`);
const server = http.createServer(function(req, res){
    res.setHeader('Content-Type', 'text/html; charset=UTF-8');
    res.end(`<!DOCTYPE html>
        <html>
            <head>
                <title>11notes/nginx:stable</title>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inconsolata" />
            <style>
                html,
                body {
                    height: 100%;
                }
        
                body {
                    margin: 0;
                }
        
        
                .container {
                    height: 100%;
                    padding: 0;
                    margin: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    flex-direction: column;
                }
        
                .content {
                    align-self: center;
                }
        
                .text {
                    font-size:1em; cursor:default;
                    font-family:'Inconsolata';
                }
        
                .comment {
                    font-size:1em; cursor:default;
                    font-family:'Inconsolata';
                    color:darkgreen;
                    font-style:italic;
                }
        
            </style>
            </head>
            <body>
                    <div class="container">
                        <div class="content">
                            <div class="text">
                                Node ${process.version}
                            </div>
                        </div>
                    </div>
            </body>
        </html>`);
});
server.listen(8080);