Let's start by creating an AsyncAPI file to describe your crypto-websockets client API. It will help you generate the code and build server-side applications later.

In the Editor tab, create `asyncapi.yaml` file for the client in the `client` directory and put below content inside. You can do it while the setup script is still running in Tab1 terminal tab:

```
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

Or you can directly run the below command to create the yaml file for your project

```
cd client
./asyncapiclient.sh
```{{exec}}

Create a new file named `package.json` in your template directory and save it. This file is used to define the dependencies for your template.
We will be using the following file to work with:

```
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

```
~/dep_client.sh
```{{exec}

Next would be to configure a glee for your server i.e. websockets and save it as a `glee.config.js`.

```
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

```
~/glee_config_client.sh
```{{exec}

Now create a new dir `auth` inside client folder and configure the token for websockets asyncapi protocol. 

```
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

```
cd auth
~/auth_client.sh
```{{exec}