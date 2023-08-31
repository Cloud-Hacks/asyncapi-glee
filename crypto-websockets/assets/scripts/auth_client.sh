echo "Creating websocket typescript file on your client directory."
cat << EOF > websockets.ts
export async function clientAuth({ parsedAsyncAPI, serverName }) {
    return {
      token: process.env.TOKEN,
      userPass: {
        user: "alec", password: "oviecodes"
      }
    }
}
EOF
