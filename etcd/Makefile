#https://github.com/etcd-io/etcd/releases/

DOWNLOAD_DIR=/tmp/etcd-download-test
IP_ADDR=192.168.1.155

download: GOOGLE_URL=https://storage.googleapis.com/etcd
download: GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
download: ETCD_VER=v3.4.14
download: DOWNLOAD_URL=$(GOOGLE_URL)
download:
	rm -f /tmp/etcd-$(ETCD_VER)-linux-amd64.tar.gz
	rm -rf $(DOWNLOAD_DIR)  && mkdir -p $(DOWNLOAD_DIR)
	curl -L $(DOWNLOAD_URL)/$(ETCD_VER)/etcd-$(ETCD_VER)-linux-amd64.tar.gz -o /tmp/etcd-$(ETCD_VER)-linux-amd64.tar.gz
	tar xzvf /tmp/etcd-$(ETCD_VER)-linux-amd64.tar.gz -C /tmp/etcd-download-test --strip-components=1
	rm -f /tmp/etcd-$(ETCD_VER)-linux-amd64.tar.gz

member-list:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 member list -w table

status:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 endpoint status -w table

keys:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 get --prefix f

perf:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 check perf

datascale:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 check datascale


put: KEY=foo
put: VAL=bar
put:
	@$(DOWNLOAD_DIR)/etcdctl --endpoints=$(IP_ADDR):2371,$(IP_ADDR):2372,$(IP_ADDR):2373 put $(KEY) $(VAL)


instance-%: DATA_DIR=/tmp/etcd
instance-run-%: export ETCD_INITIAL_CLUSTER=node1=http://$(IP_ADDR):2381,node2=http://$(IP_ADDR):2382,node3=http://$(IP_ADDR):2383
instance-run-%: export ETCD_NAME=node$(INSTANCE)
instance-run-%: export ETCD_INITIAL_CLUSTER_STATE=new
instance-run-%: export ETCD_INITIAL_CLUSTER_TOKEN=etcd-cluster-1
instance-run-%: export ETCD_INITIAL_ADVERTISE_PEER_URLS=http://$(IP_ADDR):238$(INSTANCE)
instance-run-%: export ETCD_LISTEN_PEER_URLS=http://$(IP_ADDR):238$(INSTANCE)
instance-run-%: export ETCD_DATA_DIR=$(DATA_DIR)-$(INSTANCE)/data 
instance-run-%: export ETCD_WAL_DIR=$(DATA_DIR)-$(INSTANCE)/wal
instance-run-%: export ETCD_LISTEN_CLIENT_URLS=http://$(IP_ADDR):237$(INSTANCE)
instance-run-%: export ETCD_ADVERTISE_CLIENT_URLS=$(ETCD_LISTEN_CLIENT_URLS)

clean: DATA_DIR=/tmp/etcd
clean:
	rm -frv  $(DATA_DIR)-?



instance-run-1: INSTANCE=1
instance-run-1:
	mkdir -p $(DATA_DIR)-$(INSTANCE)/data
	mkdir -p $(DATA_DIR)-$(INSTANCE)/wal
	$(DOWNLOAD_DIR)/etcd -debug


instance-run-2: INSTANCE=2
instance-run-2:
	mkdir -p $(DATA_DIR)-$(INSTANCE)/data
	mkdir -p $(DATA_DIR)-$(INSTANCE)/wal
	$(DOWNLOAD_DIR)/etcd -debug

instance-run-3: INSTANCE=3
instance-run-3:
	mkdir -p $(DATA_DIR)-$(INSTANCE)/data
	mkdir -p $(DATA_DIR)-$(INSTANCE)/wal
	$(DOWNLOAD_DIR)/etcd -debug
