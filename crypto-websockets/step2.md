Let's dive into creating server side application to make interactions with client one. First create a folder `project` with `asyncapi` cli tool in the `Tab 2`.

```plain
asyncapi new glee
```{{exec}}

And transfer the `project` folder contents to a new directory `server` and modify the `asyncapi.yaml` file with below content in the Editor tab.

```yaml
asyncapi: 3.0.0
info:
  title: asyncapicoin server
  version: 1.0.0
  description: >
    This app is a dummy server that would stream the price of a fake
    cryptocurrency
servers:
  websocket:
    host: 'localhost:3000'
    protocol: ws
    security:
      - $ref: '#/components/securitySchemes/token'
      - $ref: '#/components/securitySchemes/userPass'
      - $ref: '#/components/securitySchemes/apiKey'
      - $ref: '#/components/securitySchemes/cert'
  ws-websocket:
    host: 'localhost:4000'
    protocol: ws
channels:
  price:
    address: /price
    messages:
      indexGraph:
        $ref: '#/components/messages/indexGraph'
    bindings:
      ws:
        bindingVersion: 0.1.0
        headers:
          type: object
          properties:
            token:
              type: string
operations:
  /price.subscribe:
    action: send
    channel:
      $ref: '#/channels/price'
    messages:
      - $ref: '#/channels/price/messages/indexGraph'
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

Or you can directly run the below command to modify the yaml file for your project in the `Tab 2`;

```plain
cd crypto-websockets/server
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
    "@asyncapi/glee": "^0.33.2",
    "axios" :"^1.5.1"
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
./auth_server.sh
```{{exec}}

Then trace back to `server` directory by running `cd ..` and create a dir `lifecycle` and remove the existing file `functions` and add `updateCryptoPrice.ts` file like below;

```javascript
import { Message } from '@asyncapi/glee'

export default async function ({ glee, connection }) {
    let status = 'transit'
    let currentPrice = 100
    const count = 10
    ;(function priceChange(i) {
        if (i === count) {
            status = 'started'
        }else if (i === 1) {
            status = 'finished'
        }else {
            status = 'intransit'
        }
        const date = new Date()
        setTimeout(() => {
            glee.send(new Message({
                channel: '/price',
                connection,
                payload: {time: date.getTime(), price: getPrice(), status}
            }))
            if (--i) priceChange(i)
        }, 1000)
    }(count))

    const between = (min, max) => {
        return Math.floor(
            Math.random() * (max - min) + min
        )
    }

    const getPrice = () => {
        const HighOrLow = between(1,10)
        if (HighOrLow >= 4) {
            currentPrice = currentPrice + (between(0,5) * 10)
        }else {
            currentPrice = currentPrice - (between(0,5) * 10)
        }
        return currentPrice
    }
}


export const lifecycleEvent = 'onServerConnectionOpen'

```{{copy}}

Or simply you can execute the below sh;

```plain
cd .. && cd lifecycle
./lifecyc_server.sh
```{{exec}}

Again go back to server dir `cd ..` 

Set attributes in your `.env` file inside the server folder in order to authenticate client like below

```
TOKEN=my-tokenValue
USERNAME=con1
PASSWORD=connect@123
```{{copy}}

And install the dependencies for your application;

```
cd ..
npm install
```{{exec}}

Now, run the development locally and wait until client's connection is successful;

```
npm run dev
```{{exec}}
