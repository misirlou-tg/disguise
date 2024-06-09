#!/bin/sh

# So npm & ng tools won't stop and ask for permission
# https://github.com/angular/angular-cli/issues/16295
export NG_CLI_ANALYTICS=false

npm install -g @angular/cli@9.0.7
npm install
ng build -c=production
