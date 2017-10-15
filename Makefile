IMAGE     := rn
CONTAINER := rn-container
V         := @

PROJ      := RNDemo

rn-init: build
	$(V)docker run -it --rm -v $(CURDIR):/usr/src/app $(IMAGE) react-native init $(PROJ)

build:
	$(V)docker build -t $(IMAGE) .

