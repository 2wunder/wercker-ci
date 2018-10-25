FROM ruby:2.5.1
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean
RUN apt install -y -q libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs build-essential
RUN npm install -g yarn
RUN cd /tmp \
	&& wget "https://github.com/Medium/phantomjs/releases/download/v2.1.1/phantomjs-2.1.1-linux-x86_64.tar.bz2" \
	&& tar xfj phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& cp /tmp/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
RUN gem install bundler --no-rdoc --no-ri --version=">=1.5.2"
WORKDIR /