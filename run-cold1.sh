#!/bin/sh
docker run -p 9205:9205 -p 9305:9305 \
	--name cold1  --hostname cold1 \
	--rm \
	--ulimit nofile=65536:65536 --ulimit memlock=-1:-1 \
	-e "ES_JAVA_OPTS=-Xms3g -Xmx3g" -e cluster.name=docker_cluster -e bootstrap.memory_lock=true \
	-e "node.master=false" -e "node.data=true" -e "node.ingest=false"  -e "node.attr.my_node_type=cold" \
	-e "node.name=cold1" -e "discovery.zen.ping.unicast.hosts=192.168.0.114:9300" \
        -e "search.remote.connect=true"  -e "discovery.zen.minimum_master_nodes=1" \
        -e "network.publish_host=192.168.0.114" \
        -e "transport.publish_host=192.168.0.114" -e "http.port=9205" -e "transport.tcp.port=9305"  \
	-e "TAKE_FILE_OWNERSHIP=true" \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/colddata:/usr/share/elasticsearch/data \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/coldlog:/usr/share/elasticsearch/logs \
	docker.elastic.co/elasticsearch/elasticsearch:6.8.6
