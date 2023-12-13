echo "Creating asyncapi yaml file on your server directory."
echo 'asyncapi: 3.0.0
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
  /price:
    address: /price
    messages:
      subscribe.message:
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
      $ref: '#/channels/~1price'
    messages:
      - $ref: '#/components/messages/indexGraph'
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
      in: user' > asyncapi.yaml