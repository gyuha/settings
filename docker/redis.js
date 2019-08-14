#!/usr/bin/node
const readline = require('readline-sync')

let password = readline.question("Input redis Password : ");

var redis = require("redis"),

client = redis.createClient();
if (password)
	client.auth(password)

client.on("error", function (err) {
	console.log("Error " + err);
});

client.set("string key", "string val", redis.print);
client.hset("hash key", "hashtest 1", "some value", redis.print);
client.hset(["hash key", "hashtest 2", "some other value"], redis.print);
client.hkeys("hash key", function (err, replies) {
	console.log(replies.length + " replies:");
	replies.forEach(function (reply, i) {
		console.log("    " + i + ": " + reply);
	});
	client.quit();
});
