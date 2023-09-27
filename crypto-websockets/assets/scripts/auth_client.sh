echo "Creating websocket typescript file on your client/auth directory."
cat << EOF > websockets.ts
export async function clientAuth({ parsedAsyncAPI, serverName }) {
    return {
      token: process.env.TOKEN,
      userPass: {
        user: process.env.USERNAME, password: process.env.PASSWORD
      }
    }
}
EOF
