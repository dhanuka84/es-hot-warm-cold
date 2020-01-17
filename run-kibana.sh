#!/bin/sh
docker run -p 5601:5601 \
        --name kibana \
        --rm \
        --ulimit nofile=65536:65536 --ulimit memlock=-1:-1 \
        -e "ES_JAVA_OPTS=-Xms3g -Xmx3g" -e bootstrap.memory_lock=true  \
	-e "TAKE_FILE_OWNERSHIP=true" \
	-v  /home/dhanuka/research/elastic/docker2/es-hot-warm-cold/kibconfig:/usr/share/kibana/config/ \
        docker.elastic.co/kibana/kibana:6.8.6
