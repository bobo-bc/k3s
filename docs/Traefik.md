# Traefik

here’s a complete ready-to-use setup for Traefik v3.5.1 in your homelab. This keeps your Cloudflare DNS-01 resolver, wildcard *.smeyer.ca certs, and also exposes the dashboard at traefik.smeyer.ca.

```bash 
## values.yaml

deployment:
  enabled: true

service:
  type: LoadBalancer
  loadBalancerIP: 10.0.0.20
  ports:
    web:
      port: 80
      expose: true
    websecure:
      port: 443
      expose: true
    traefik:
      port: 8080
      expose: true

envFrom:
  - secretRef:
      name: cloudflare-dns

persistence:
  enabled: true
  path: /data
  size: 1Gi

certificatesResolvers:
  letsencrypt:
    acme:
      email: you@smeyer.ca
      storage: /data/acme.json
      dnsChallenge:
        provider: cloudflare
        delayBeforeCheck: 0

additionalArguments:
  - "--api.dashboard=true"
  - "--api.insecure=false"  # Optional: keep false for security
 ```
 
 
## Cloudflare secret

```bash 
kubectl create secret generic cloudflare-dns \
  --from-literal=CLOUDFLARE_DNS_API_TOKEN="your-cloudflare-token" \
  -n traefik
```
Replace your-cloudflare-token with a token that has Zone.DNS → Edit and Zone.Zone → Read for smeyer.ca.
 
 
 
## Dashboard IngressRoute
```bash
# traefik-dashboard.yaml
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-dashboard
  namespace: traefik
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`traefik.smeyer.ca`)
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
  tls:
    certResolver: letsencrypt
 ```
 
 
## Deploy Traefik with Helm
```bash 
helm upgrade traefik traefik/traefik -n traefik -f values.yaml --skip-crds
kubectl -n traefik rollout restart deployment traefik
```
 
 
## Apply dashboard IngressRoute
```bash 
kubectl apply -f traefik-dashboard.yaml
```
 