'use strict';

const app = require('express')();
const server = require('http').Server(app)
const io = require('socket.io')(server);

const PORT = 3000;


app.get('/', function (req, res) {
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
  });
});


server.listen(PORT, function(){
  console.log('listening on http://localhost:' + PORT);
});