# Install argocd on the cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Instal argocd cli utility to get the initial admin password
VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Obtain the initial password 
argocd admin initial-password -n argocd

# Temporary local portfoward the admin UI 
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Update the password from the UI and delete the original password secret
kubectl delete secrets argocd-initial-admin-secret -n argocd

# Create CRDS resources (applications, application-sets, etc..)
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable


# Update argocd ConfigMap for MetalLB
kubectl apply -f argocd-update-cm.yaml

Install kubeseal: https://github.com/bitnami-labs/sealed-secrets/releases

# Importare le chiavi RSA usate per la creazione dei vari secret nel cluster
kubectl -n sealed-secrets create secret tls "mycustomkeys" --cert="mytls.cert" --key="mytls.key"
kubectl -n sealed-secrets label secret "mycustomkeys" sealedsecrets.bitnami.com/sealed-secrets-key=active