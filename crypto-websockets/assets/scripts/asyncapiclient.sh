echo "Creating asyncapi yaml file on your client directory."
echo 'asyncapi: 3.0.0
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
  /price:
    address: /price
    messages:
      index.message:
        $ref: '#/components/messages/indexGraph'
    bindings:
      ws:
        bindingVersion: 0.1.0
operations:
  index:
    action: receive
    channel:
      $ref: '#/channels/~1price'
    messages:
      - $ref: '#/components/messages/indexGraph'
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
  - websockets' > asyncapi.yaml