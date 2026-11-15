#!/bin/bash
# Run only in the course's preconfigured Linux Code Engine CLI.
set -euo pipefail
cd /home/project
: "${SN_ICR_NAMESPACE:?Open the course Code Engine CLI first}"

record() {
    printf 'set -e\n%s\nexit\n' "$2" |
        script -q -e -c 'bash --noprofile --norc -i' "/home/project/$1"
}

record deploy-getpic-1 'ibmcloud ce project current'
if [ ! -d Back-End-Development-Pictures ]; then
    git clone https://github.com/igiiaw/Back-End-Development-Pictures.git
fi
docker build -t "us.icr.io/$SN_ICR_NAMESPACE/pictures:1" Back-End-Development-Pictures
docker push "us.icr.io/$SN_ICR_NAMESPACE/pictures:1"
record deploy-getpic-2 'ibmcloud ce app create --name pictures --image us.icr.io/${SN_ICR_NAMESPACE}/pictures:1 --registry-secret icr-secret --port 3000'

unset KUBECONFIG
oc project "$SN_ICR_NAMESPACE"
if ! oc get deployment mongo >/dev/null 2>&1; then
    oc new-app --name=mongo --docker-image=docker.io/library/mongo:8.0
    oc set volume deployment/mongo --add --name=mongo-data --type=emptyDir --mount-path=/data/db --overwrite
fi
oc rollout status deployment/mongo --timeout=300s
record deploy-getsong-3 'oc new-app https://github.com/igiiaw/Back-End-Development-Songs --strategy=docker --name=songs --env=MONGODB_SERVICE=mongo'
oc rollout status deployment/songs --timeout=600s
record deploy-getsong-4 'oc expose service/songs'
oc get route songs
printf '\nEvidence files are saved in /home/project.\n'
