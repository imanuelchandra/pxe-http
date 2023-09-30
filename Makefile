AUTHOR?=imanuelchandra
REPOSITORY?=pxe-http

.PHONY: build
build_pxe_http:
	docker build -t ${AUTHOR}/${REPOSITORY}:${PXE_HTTP_VERS}  . \
			--progress=plain \
			--no-cache
	@echo
	@echo "Build finished. Docker image name: \"${AUTHOR}/${REPOSITORY}:${PXE_HTTP_VERS}\"."

.PHONY: run
run_pxe_http:
	docker run -it --rm --init --user 6565:6565 --net host \
	    	-v ./etc/apache2/sites-available/pxelocal.conf:/pxelocal.conf \
			-v ./etc/apache2/apache2.conf:/apache2.conf \
			--mount 'type=volume,dst=${NFS_LOCAL_MNT}:nocopy,volume-driver=local,volume-opt=type=nfs,volume-opt=device=:${NFS_SHARE},"volume-opt=o=addr=${NFS_SERVER},${NFS_OPTS}"' \
			${AUTHOR}/${REPOSITORY}:${PXE_HTTP_VERS} eth0