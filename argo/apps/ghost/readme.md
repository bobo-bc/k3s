kubectl create secret generic ghost-mail-secret \
  --from-literal=gmail-app-password='YOUR_APP_PASSWORD' \
  -n post
