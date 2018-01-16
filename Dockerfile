FROM library/node:9.3.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN npm i -g yarn --registry=https://registry.npm.taobao.org 
RUN yarn config set registry https://registry.npm.taobao.org --global
RUN yarn config set disturl https://npm.taobao.org/dist --global
RUN yarn global add react-native-cli typescript

CMD ["react-native", "init"]