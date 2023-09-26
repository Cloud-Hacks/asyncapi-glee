echo "Creating asyncapi yaml file on your server directory."
echo 'asyncapi: 2.6.0
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
      in: user' > asyncapi.yaml