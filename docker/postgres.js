const readline = require('readline-sync')

let password = readline.question("root Password : ");

const { Client } = require('pg')
const client = new Client({
	  user: 'postgres',
	  password: password,
	  database: 'postgres',
	  port: 5432,
})
client.connect()

client.query('SELECT version()', (err, {rows}) => {
	  console.log(err, rows[0].version)
	  client.end()
})

