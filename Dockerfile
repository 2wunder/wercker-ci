FROM circleci/ruby:2.5.3-browsers
RUN sudo apt-get update \
    && sudo apt-get install -y curl wget \
    && sudo apt-get -y autoclean
RUN sudo apt install -y -q libpangocairo-1.0-0 libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxi6 libxtst6 libnss3 libcups2 libxss1 libxrandr2 libgconf2-4 libasound2 libatk1.0-0 libgtk-3-0 wget xvfb unzip cmake
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash && \
    sudo apt-get install -y nodejs build-essential
RUN sudo npm install -g yarn

# # Set up the Chrome PPA
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# RUN sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# # Update the package list and install chrome
# RUN sudo apt-get update -y
# RUN sudo apt-get install -y google-chrome-stable
# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 2.46
ENV CHROMEDRIVER_DIR /chromedriver
RUN sudo mkdir $CHROMEDRIVER_DIR
# Download and install Chromedriver
RUN sudo wget -q --continue -P $CHROMEDRIVER_DIR "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN sudo unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Install Xvfb init script
ENV DISPLAY :99
ADD xvfb_init /etc/init.d/xvfb
RUN sudo chmod a+x /etc/init.d/xvfb
ADD xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN sudo chmod a+x /usr/bin/xvfb-daemon-run

RUN gem install bundler --version=">=1.17.3"