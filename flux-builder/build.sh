cd /go/src/github.com/weaveworks/ && \
git clone https://github.com/weaveworks/flux.git && \
cd flux && \
git checkout 1.7.1 && \
cp checkpoint/checkpoint_linux.go checkpoint/checkpoint_linux_arm.go
mv checkpoint/checkpoint_linux.go checkpoint/checkpoint_linux_amd64.go
sed -i 's#int8)#uint8)#g' checkpoint/checkpoint_linux_arm.go
sed -i "s/amd64/arm/g" Makefile && \
dep ensure && \
make