fs = require 'fs'

file_name = process.argv[2]
source = fs.readFileSync(file_name).toString()
console.log source
