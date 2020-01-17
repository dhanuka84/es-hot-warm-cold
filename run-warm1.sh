#!/bin/sh
docker run -p 9202:9202 -p 9302:9302 \
	--name warm1  --hostname warm1 \
	--rm \
	--ulimit nofile=65536:65536 --ulimit memlock=-1:-1 \
	-e "ES_JAVA_OPTS=-Xms2g -Xmx2g" -e cluster.name=docker_cluster -e bootstrap.memory_lock=true \
	-e "node.master=false" -e "node.data=true" -e "node.ingest=false"  -e "node.attr.my_node_type=warm" \
	-e "node.name=warm1" -e "discovery.zen.ping.unicast.hosts=192.168.0.114:9300" \
        -e "search.remote.connect=true"  -e "discovery.zen.minimum_master_nodes=1" \
        -e "network.publish_host=192.168.0.114" \
        -e "transport.publish_host=192.168.0.114" -e "http.port=9202" -e "transport.tcp.port=9302"  \
	-e "TAKE_FILE_OWNERSHIP=true" \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/warmdata:/usr/share/elasticsearch/data \
        -v /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/warmlog:/usr/share/elasticsearch/logs \
	docker.elastic.co/elasticsearch/elasticsearch:6.8.6
