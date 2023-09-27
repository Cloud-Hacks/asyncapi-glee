echo "Creating websocket typescript file on your server/auth directory."
cat << EOF > websocket.ts
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
EOF