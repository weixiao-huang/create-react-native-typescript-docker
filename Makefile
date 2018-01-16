IMAGE     := rn
CONTAINER := rn-container
# V         := @

PROJ      := RNDemo

tsc-init = tsc --init --pretty --sourceMap --target es2015 --outDir ./lib --module commonjs --jsx react
yarn-dev = yarn add -D ts-jest typescript \
	@types/jest @types/react @types/react-native @types/react-test-renderer \
	enzyme @types/enzyme react-addons-test-utils react-dom \
	enzyme-adapter-react-16 @types/enzyme-adapter-react-16

tsc      = ./node_modules/.bin/tsc

rn-init: build
	$(V)docker run -it --rm -v $(CURDIR):/usr/src/app $(IMAGE) react-native init $(PROJ)
	$(V)cp .editorconfig $(PROJ)/

build:
	$(V)docker build -t $(IMAGE) .

ts:
	$(V)mkdir $(PROJ)/src
	$(V)mv $(PROJ)/index.js $(PROJ)/src/index.tsx
	$(V)mv $(PROJ)/App.js $(PROJ)/src/App.tsx
	$(V)mv $(PROJ)/__tests__/App.js $(PROJ)/__tests__/App.tsx
	$(V)mv $(PROJ)/__tests__/ $(PROJ)/src/__tests__/
	$(V)cp index.js $(PROJ)/
	$(V)cp -r components $(PROJ)/src/
	$(V)docker run -it --rm -v $(CURDIR):/usr/src/app -w /usr/src/app/$(PROJ) $(IMAGE) $(tsc-init)
	$(V)docker run -it --rm -v $(CURDIR):/usr/src/app -w /usr/src/app/$(PROJ) $(IMAGE) $(yarn-dev)

tsc:
	$(V)docker run -it --rm -v $(CURDIR):/usr/src/app -w /usr/src/app/$(PROJ) $(IMAGE) $(tsc)
