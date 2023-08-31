echo "Configure a glee for your servere on your client directory."
cat << EOF > glee.config.js
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
EOF