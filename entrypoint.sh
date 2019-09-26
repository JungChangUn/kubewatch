#!/bin/bash

# CONF_FILE="${KW_CONFIG:-${HOME}}/.kubewatch.yaml";
CONF_FILE="/.kubewatch.yaml";

if [ ! -e ${CONF_FILE} ]; then
    echo "==> Writing config file..."
    cat > ${CONF_FILE} << EOF
handler:
  webhook:
    url: "${KW_WEBHOOK_URL}"
resource:
  deployment: true
  replicationcontroller: false
  replicaset: false
  daemonset: false
  services: true
  pod: true
  job: false
  persistentvolume: false
  namespace: true
  secret: false
  ingress: false
EOF
else
    echo "==> Config file exists..."
fi

# Required until the PR gets released
# https://github.com/bitnami-labs/kubewatch/pull/157
export HOME="${KW_CONFIG}"

exec kubewatch "$@"