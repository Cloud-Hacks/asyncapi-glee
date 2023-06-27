AsyncAPI is an open source initiative that seeks to improve the current state of Event-Driven Architectures (EDA). Our long-term goal is to make working with EDAs as easy as working with REST APIs. That goes from documentation to code generation, from discovery to event management, and beyond.

To make this happen, the first step is to create a specification that allows developers, architects, and product managers to define the interfaces of an async API. Much like OpenAPI (aka Swagger) does for REST APIs.

The AsyncAPI specification lays the foundation for a greater and better tooling ecosystem for EDAs.

# What's Glee?
Glee is a spec-first framework that helps you build server-side applications. It leverages the AsyncAPI specification to make you more productive:

It makes sure your code and AsyncAPI definition are on par. No more outdated documentation. Glee takes care of it for you, automatically.
Glee lets you focus on what matters and handles the rest for you. You only write the code for your business use-case. Glee takes care of performance, scalability, resilience, and everything you need to make your application production-ready.

In this tutorial, you get started with actual code and a (could-be) real-world use case. This example is to showcase how Glee could be used as a WebSocket client.

There is a server that streams the price change of a fake cryptocurrency (we can call it asyncapicoin) and the client subscribes to this stream and draws a graph in the terminal.