# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
NPM_VER=8.19.4

sudo apt update

# ----------------------------------------#
#      Step 1/3: Installing nodejs        #
# ----------------------------------------#

sudo apt install -y nodejs
npm install -g npm@v${NPM_VER}

# ----------------------------------------#
#      Step 2/3: Installing asyncapi cli  #
# ----------------------------------------#

npm install -g @asyncapi/cli
# asyncapi generate fromTemplate asyncapi.yaml @asyncapi/nodejs-template -o output -p server=websockets --force-write