#!/usr/bin/node
const readline = require('readline-sync')
const mysql = require('mysql2')

let password = readline.question("root Password : ");

const connection = mysql.createConnection({
	  host: 'localhost',
	  user: 'root',
	  password: password
})

connection.query(
	  'SELECT VERSION() as version',
	  (err, results) => {
		      if (err) throw err
		      console.log(results)
		      connection.end()
		    }
)
