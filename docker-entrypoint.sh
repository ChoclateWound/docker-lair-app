#!/bin/bash
#
source /scripts/env_secrets_expand.sh
cd /root/app/bundle/programs/server && meteor npm start
