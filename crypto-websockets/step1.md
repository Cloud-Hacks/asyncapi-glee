Let's start by creating an AsyncAPI file to describe your crypto-websockets client API. It will help you generate the code and build server-side applications later.

In the Editor tab, create `asyncapi.yaml` file in the root and put below content inside. You can do it while the setup script is still running in Tab1 terminal tab:

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