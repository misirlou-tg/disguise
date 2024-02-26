# Usage: run-build-env.sh [volume-name]
#   if volume-name is omitted $DISGUISE_VOL or 'disguise-master' is used
#
# Run a container where Disguise can be built
# - Mounts the git workspace (as read-only) in /home/node/disguise-ro
# - Also mounts/creates a docker volume in /home/node/artifacts
#
# Typical commands to build & copy the artifacts to the volume:
# cd /home/node
# mkdir disguise
# cp -r disguise-ro/* disguise
# rm -fr disguise/docs
# cd disguise
# npm install -g @angular/cli@9.0.7
# npm install
# ng build -c=production
# cp -r docs/* ../artifacts

# Get the absolute path to where the script is (--mount needs the full path)
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
DISGUISE_VOL=${DISGUISE_VOL:-${1:-disguise-master}}
echo Volume $DISGUISE_VOL will be mounted in /home/node/artifacts
docker run -it --rm --entrypoint /bin/bash \
  --mount type=bind,src=$DIR,dst=/home/node/disguise-ro,readonly \
  --mount src=$DISGUISE_VOL,dst=/home/node/artifacts \
  node:12.22.12-buster-slim
