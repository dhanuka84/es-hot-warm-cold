#!/bin/sh
docker run -p 9200:9200 -p 9300:9300  \
	--name master1 --hostname master1 \
	--rm \
	--ulimit nofile=65536:65536 --ulimit memlock=-1:-1 \
	-e "ES_JAVA_OPTS=-Xms2g -Xmx2g -Xloggc:/usr/share/elasticsearch/logs/gc.log" -e cluster.name=docker_cluster -e bootstrap.memory_lock=true \
	-e "node.name=master1" -e "node.master=true" -e "node.data=false" -e "node.ingest=true" -e "search.remote.connect=true" -e "discovery.zen.minimum_master_nodes=1" \
	-e "network.publish_host=192.168.0.114" \
   	-e "transport.publish_host=192.168.0.114"  \
	-e "xpack.monitoring.collection.enabled=false" \
	-e "TAKE_FILE_OWNERSHIP=true" \
	-v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/masdata:/usr/share/elasticsearch/data \
	-v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/maslog:/usr/share/elasticsearch/logs \
	docker.elastic.co/elasticsearch/elasticsearch:6.8.6
