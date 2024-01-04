Let's start by generating an AsyncAPI glee template by unleashing the power of asyncapi glee tool inside a folder `crypto-websockets` to describe your crypto-websockets client and server APIs executing the following command. It will help you generate the code and build server-side applications later.

```plain
asyncapi new glee
```{{exec}}

And transfer the `project` folder contents to a `crypto-websockets/client` directory and modify the `asyncapi.yaml` file with below content in the Editor tab.

```yaml
asyncapi: 3.0.0
info:
  title: asyncapicoin client
  version: 1.0.0
  description: >
    This app creates a client that subscribes to the server for the price
    change.
servers:
  websockets:
    host: 'localhost:3000'
    protocol: ws
    security:
      - $ref: '#/components/securitySchemes/token'
      - $ref: '#/components/securitySchemes/userPass'
      - $ref: '#/components/securitySchemes/apiKey'
      - $ref: '#/components/securitySchemes/cert'
channels:
  price:
    address: /price
    messages:
      indexGraph:
        $ref: '#/components/messages/indexGraph'
    bindings:
      ws:
        bindingVersion: 0.1.0
operations:
  index:
    action: receive
    channel:
      $ref: '#/channels/price'
    messages:
      - $ref: '#/channels/price/messages/indexGraph'
components:
  messages:
    indexGraph:
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
x-remoteServers:
  - websockets
```{{copy}}

Or you can directly run the below command to modify the yaml file for your project;

```plain
cd crypto-websockets/client
./asyncapiclient.sh
```{{exec}}

Configure a file named `package.json` in your template directory and save it. This file is used to define the dependencies for your template.
We will be using the following file to work with;

```json
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
```{{copy}}

Or you can just follow up with the below command;

```plain
./dep_client.sh
```{{exec}}

Next would be to configure a glee for your server i.e. websockets and save it as a `glee.config.js`.

```typescript
export default async function () {
  return {
    ws: {
      client: {
        auth: async ({serverName}) => {
          if(serverName === 'websockets') {
            return {
              token: process.env.TOKEN
            }
          }
        }
      }
    }
  };
}
```{{copy}}

Else you can execute the below script;

```plain
./glee_config_client.sh
```{{exec}}

For your application to update the data i.e. price and status over time, you need to create `db.json` file for temporary storage

```
[{"time":1704277182766,"price":140,"status":"started"},{"time":1704277183789,"price":150,"status":"intransit"},{"time":1704277183789,"price":150,"status":"intransit"},{"time":1704277184806,"price":180,"status":"intransit"},{"time":1704277184806,"price":180,"status":"intransit"},{"time":1704277185818,"price":210,"status":"intransit"},{"time":1704277185818,"price":210,"status":"intransit"},{"time":1704277186829,"price":220,"status":"intransit"},{"time":1704277186829,"price":220,"status":"intransit"},{"time":1704277187841,"price":260,"status":"intransit"},{"time":1704277187841,"price":260,"status":"intransit"},{"time":1704277188845,"price":250,"status":"intransit"},{"time":1704277188845,"price":250,"status":"intransit"},{"time":1704277189858,"price":290,"status":"intransit"},{"time":1704277189858,"price":290,"status":"intransit"},{"time":1704277190860,"price":310,"status":"intransit"},{"time":1704277190860,"price":310,"status":"intransit"}]
```{{copy}}

Or you can directly execute the below sh;

```plain
./db_client.sh
```{{exec}}

Now create a new dir `auth` inside `client` folder and configure the token for websockets asyncapi protocol. 

```javascript
export async function clientAuth({ parsedAsyncAPI, serverName }) {
    return {
      token: process.env.TOKEN,
      userPass: {
        user: process.env.USERNAME, password: process.env.PASSWORD
      }
    }
}
```{{copy}}

Similarly you can execute the below sh;

```plain
cd auth
./auth_client.sh
```{{exec}}

Then trace back to `client` directory by running `cd ..` and go to a dir `functions` and remove the existing file and add `index.ts` file like below;

```typescript
import path from 'path'
import fs from 'fs'
import asciichart from 'asciichart'

export default async function (event) {
    const payload = event.payload
    const dbPath = path.resolve('./db.json')
    const read = () => JSON.parse(fs.readFileSync(dbPath, 'utf-8'))
    const write = (data) => { fs.writeFileSync(dbPath, data, { encoding: 'utf-8' }) }
    let db
    switch (payload.status) {
        case 'started':
            write(JSON.stringify([payload]))
            break
        case 'intransit':
            db = read()
            write(JSON.stringify([...db, payload]))
            break
        case 'finished':
            db = read()
            const values = [...db, payload]
            console.log(asciichart.plot(values.map(v => v.price), {height: 8}))
    }
    return {
        send: []
    }
}
```{{copy}}

Or simply you can execute the below sh;

```plain
cd .. && cd functions
./func_client.sh
```{{exec}}

Again go back to client dir `cd ..` 

Set attributes in your `.env` file inside the client folder like below

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

> Now, wait until server's connection is established and then run the development following the `step 2`;

```
npm run dev
```{{exec}}
