echo "Creating package dependency file for your client app."
cat << EOF > package.json
{
  "name": "client",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev": "glee dev"
  },
  "type": "module",
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@asyncapi/glee": "^0.33.2",
    "asciichart": "^1.5.25"
  }
}
EOF