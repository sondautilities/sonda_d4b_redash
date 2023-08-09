
mkdir certs
cd certs

echo "
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = root_ca

[dn]
C=US
ST=RandomState
L=RandomCity
O=RandomOrganization
OU=RandomOrganizationUnit
emailAddress=hello@example.com
CN=https://developersonda.tech/

[root_ca]
basicConstraints = critical, CA:true
" > openssl.cnf

echo "
subjectAltName = @alt_names
extendedKeyUsage = serverAuth

[alt_names]
IP.1 = 127.0.0.1
DNS.1 = https://developersonda.tech/" > opensslserver.ext

echo "
subjectAltName = @alt_names
extendedKeyUsage = clientAuth

[alt_names]
IP.1 = 127.0.0.1
DNS.1 = https://developersonda.tech/
" > opensslclient.ext

openssl req -x509 -newkey rsa:2048 -out ca.crt -outform PEM -keyout ca.key -days 1024 -verbose -config openssl.cnf -nodes -sha256 -subj "/CN=developersonda.tech" && \
# Server
openssl req -newkey rsa:2048 -keyout server.key -out server.csr -subj "/CN=developersonda.tech" -sha256 -nodes && \
openssl x509 -req -CA ca.crt -CAkey ca.key -in server.csr -out server.crt -days 365 -extfile opensslserver.ext -sha256 -set_serial 0x1111 && \
# Client
openssl req -newkey rsa:2048 -keyout client.key -out client.csr -subj "/CN=developersonda.tech" -sha256 -nodes && \
openssl x509 -req -CA ca.crt -CAkey ca.key -in client.csr -out client.crt -days 365 -extfile opensslclient.ext -sha256 -set_serial 0x1111