  # -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
NODE_VER=18.17.1

sudo apt update

# ----------------------------------------#
#      Step 1/3: Installing nodejs        #
# ----------------------------------------#

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install ${NODE_VER}

# ----------------------------------------#
#      Step 2/3: Installing asyncapi cli  #
# ----------------------------------------#

npm install -g @asyncapi/cli
# asyncapi generate fromTemplate asyncapi.yaml @asyncapi/nodejs-template -o output -p server=websockets --force-write