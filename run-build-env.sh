# Get the absolute path to where the script is (--mount needs the full path)
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
docker run -it --rm --entrypoint /bin/bash \
  --mount type=bind,src=$DIR,dst=/home/node/disguise \
  node:12.22.12-buster-slim
