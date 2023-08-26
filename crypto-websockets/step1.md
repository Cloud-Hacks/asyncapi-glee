Let's start by creating an AsyncAPI file to describe your crypto-websockets client API. It will help you generate the code and build server-side applications later.

In the Editor tab, create `asyncapi.yaml` file for the client in the `client` directory and put below content inside. You can do it while the setup script is still running in Tab1 terminal tab:

```yaml
asyncapi: 2.4.0
info: 
  title: asyncapicoin client
  version: 1.0.0
  description: |
    This app creates a client that subscribes to the server for the price change.
servers:
  websockets:
    url: ws://localhost:3000
    protocol: ws
x-remoteServers:
  - websockets
channels:
  /price:
    bindings:
      ws:
        bindingVersion: 0.1.0
    publish:
      operationId: index
      message:
        $ref: '#/components/messages/indexGraph'
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
```

Or you can directly run the below command to create the yaml file for your project;

```plain
cd client
./asyncapiclient.sh
```{{exec}}

Create a new file named `package.json` in your template directory and save it. This file is used to define the dependencies for your template.
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
    "@asyncapi/glee": "file:../../..",
    "asciichart": "^1.5.25"
  }
}
```

Or you can just follow up with the below command;

```plain
~/dep_client.sh
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
```

Else you can execute the below script;

```plain
./glee_config_client.sh
```{{exec}}

For your application to update the data i.e. price and status over time, you need add `db.json` file for temporary storage

```
[{"time":1692154441640,"price":130,"status":"started"},{"time":1692154442650,"price":140,"status":"intransit"},{"time":1692154442650,"price":140,"status":"intransit"},{"time":1692154443663,"price":180,"status":"intransit"},{"time":1692154443663,"price":180,"status":"intransit"},{"time":1692154444668,"price":180,"status":"intransit"},{"time":1692154444668,"price":180,"status":"intransit"},{"time":1692154445678,"price":160,"status":"intransit"},{"time":1692154445678,"price":160,"status":"intransit"},{"time":1692154446687,"price":120,"status":"intransit"},{"time":1692154446687,"price":120,"status":"intransit"},{"time":1692154447695,"price":110,"status":"intransit"},{"time":1692154447695,"price":110,"status":"intransit"},{"time":1692154448703,"price":130,"status":"intransit"},{"time":1692154448703,"price":130,"status":"intransit"},{"time":1692154449713,"price":130,"status":"intransit"},{"time":1692154449713,"price":130,"status":"intransit"}]
```

Or you can directly execute the below sh;

```plain
./db_client.sh
```{{exec}}

Now create a new dir `auth` inside client folder and configure the token for websockets asyncapi protocol. 

```javascript
export async function clientAuth({ parsedAsyncAPI, serverName }) {
    return {
      token: process.env.TOKEN,
      userPass: {
        user: "alec", password: "oviecodes"
      }
    }
}
```

Similarly you can execute the below sh;

```plain
cd auth
./auth_client.sh
```{{exec}}

And set `TOKEN` in your `.env` file inside the client folder like below

`TOKEN=arb-tokenValue`
