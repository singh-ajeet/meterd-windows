FROM buzzy:base-ltsc2019

# copy the newer app source from the local app directory
COPY app "C:/app"

# Set the working directory
WORKDIR "C:/app"

# falling back to the npm http registry overcomes some issues with proxy servers
RUN npm config set strict-ssl false
RUN npm config set registry "http://registry.npmjs.org/"
RUN npm install

ENV PORT 8675
CMD ["node", "C:/app/index.js"]

