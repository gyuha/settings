const readline = require('readline-sync')

let databaseName = readline.question("Input database name: ");
let password = readline.question("Input admin Password : ");

const MongoClient = require('mongodb').MongoClient;
const test = require('assert');

// Connection url
let url = 'mongodb://localhost:27017';
if (password) {
  url = 'mongodb://admin:'+password+'@localhost:27017/' + databaseName;
}

console.log("connect to : " + url)

// Database Name
const dbName = 'test';

// Connect using MongoClient
MongoClient.connect(url, {useNewUrlParser: true}, function(err, client) {
  client.db(dbName).admin().serverInfo().then(info => {
    console.log(info.version)
    client.close()
  })
});
