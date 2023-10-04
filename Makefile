AUTHOR?=imanuelchandra
REPOSITORY?=pxe-http

.PHONY: build
build_pxe_http:
	docker build -t ${AUTHOR}/${REPOSITORY}:${PXE_HTTP_SERVER_VERS}  . \
			--progress=plain \
			--no-cache
	@echo
	@echo "Build finished. Docker image name: \"${AUTHOR}/${REPOSITORY}:${PXE_HTTP_SERVER_VERS}\"."

.PHONY: run
run_pxe_http:
	docker run -it --rm --privileged=True --init --user 6565:6565 --net host \
	    	-v ./config:/config \
			-v ./log:/log \
			-v ./scripts:/scripts \
			--mount 'type=volume,dst=${NFS_LOCAL_MNT},volume-driver=local,volume-opt=type=nfs,volume-opt=device=:${NFS_SHARE},"volume-opt=o=addr=${NFS_SERVER},${NFS_OPTS}"' \
			${AUTHOR}/${REPOSITORY}:${PXE_HTTP_SERVER_VERS} eth0