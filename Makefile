# Makefile

IMAGE=rel/jupyterlab

build: build-nogpu build-nogpu-colab build-cuda10 build-cuda11

build-nogpu: Dockerfile-nogpu
	docker build -t ${IMAGE}:nogpu -f Dockerfile-nogpu .

build-cuda10: Dockerfile-cuda10
	docker build -t ${IMAGE}:cuda10 -f Dockerfile-cuda10 --build-arg BASE=${IMAGE}:colab .

build-cuda11: Dockerfile-cuda11
	docker build -t ${IMAGE}:cuda11 -f Dockerfile-cuda11 --build-arg BASE=${IMAGE}:colab .

build-nogpu-colab: Dockerfile-nogpu-colab
	docker build -t ${IMAGE}:colab -f Dockerfile-nogpu-colab .

clean:
	docker images | grep ${IMAGE} | awk '{print $$3}' | xargs docker rmi
