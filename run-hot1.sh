#!/bin/sh
docker run -p 9201:9201 -p 9301:9301 \
	--name hot1  --hostname hot1 \
	--rm \
	--ulimit nofile=65536:65536 --ulimit memlock=-1:-1 \
	-e "ES_JAVA_OPTS=-Xms6g -Xmx6g" -e cluster.name=docker_cluster -e bootstrap.memory_lock=true \
	-e "node.master=false" -e "node.data=true" -e "node.ingest=false"  -e "node.attr.my_node_type=hot" \
	-e "node.name=hot1" -e "discovery.zen.ping.unicast.hosts=192.168.0.114:9300" \
        -e "search.remote.connect=true"  -e "discovery.zen.minimum_master_nodes=1" \
        -e "network.publish_host=192.168.0.114" \
        -e "transport.publish_host=192.168.0.114" -e "http.port=9201" -e "transport.tcp.port=9301"  \
	-e "TAKE_FILE_OWNERSHIP=true" \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/hotdata:/usr/share/elasticsearch/data \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/hotlog:/usr/share/elasticsearch/logs \
	docker.elastic.co/elasticsearch/elasticsearch:6.8.6
