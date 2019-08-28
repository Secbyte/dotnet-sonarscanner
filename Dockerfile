FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch

LABEL "com.github.actions.name"="dotnet-sonarscanner"
LABEL "com.github.actions.description"="sonarscanner for dotnet core"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/Secbyte/dotnet-sonarscanner"
LABEL "homepage"="https://github.com/Secbyte/dotnet-sonarscanner"
LABEL "maintainer"="Joshua Duffy <mail@joshuaduffy.org>"

RUN echo "deb http://http.us.debian.org/debian/ testing contrib main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends default-jre && \
    apt-get -t testing install -y --no-install-recommends python3.7 python3-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.7 get-pip.py && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    apt-get autoremove -y && \
    dotnet tool install dotnet-sonarscanner --tool-path . --version 4.6.2

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
