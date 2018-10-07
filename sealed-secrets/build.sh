cd /go/src/github.com/bitnami-labs && \
git clone https://github.com/bitnami-labs/sealed-secrets.git && \
cd sealed-secrets && \
git checkout v0.7.0 && \
make controller.image