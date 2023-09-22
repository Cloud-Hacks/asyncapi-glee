Let's dive into creating server side application to make interactions with client one. First create a folder `server` with `asyncapi` command tool.

```plain
mkdir server && cd server
asyncapi new glee
```{{exec}}

And transfer the `project` folder contents to a `server` directory and modify the `asyncapi.yaml` file with below content in the Editor tab.

```yaml
asyncapi: 2.6.0
info:
  title: asyncapicoin server
  version: 1.0.0
  description: |
    This app is a dummy server that would stream the price of a fake cryptocurrency
servers:
  websocket:
    url: ws://localhost:3000
    protocol: ws
    security:
      - token: []
      - userPass: []
      - apiKey: []
      - cert: []
  ws-websocket:
    url: ws://localhost:4000
    protocol: ws
channels:
  /price:
    bindings:
      ws:
        bindingVersion: 0.1.0
        headers:
          type: object
          properties:
            token:
              type: string
    subscribe:
      message:
        $ref: '#/components/messages/indexGraph'
components:
  messages:
    indexGraph:
      summary: Data required for drawing index graph
      payload:
        type: object
        properties:
          status:
            type: string
          time:
            type: number
          price:
            type: number
  securitySchemes:
    token:
      type: http
      scheme: bearer
      bearerFormat: JWT
    userPass:
      type: userPassword
    apiKey:
      type: httpApiKey
      name: api_key
      in: header
    cert:
      type: apiKey
      in: user
```{{copy}}

Or you can directly run the below command to modify the yaml file for your project;

```plain
cd server
./asyncapiserver.sh
```{{exec}}

Configure a file named `package.json` in your template directory and save it. We will be using the following file to work with;

```json
{
  "name": "server",
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
    "@asyncapi/glee": "^0.26.1"
  }
}
```{{copy}}

Or you can just follow up with the below command;

```plain
./dep_server.sh
```{{exec}}

Now create a new dir `auth` inside `server` folder and configure the token for websockets asyncapi protocol. 

```javascript
import axios from "axios"

export async function serverAuth({ authProps, done }) {
  await axios.get("https://jsonplaceholder.typicode.com/todos/1", {
    timeout: 5000,
  })

  console.log("token", authProps.getToken())
  console.log("userpass", authProps.getUserPass())

  done(false)
}

export async function clientAuth({ parsedAsyncAPI, serverName }) {
    return {
      token: process.env.TOKEN,
      username: process.env.USERNAME,
      password: process.env.PASSWORD,
    }
}
```{{copy}}

Similarly you can execute the below sh;

```plain
cd auth
./auth_client.sh
```{{exec}}