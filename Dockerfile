FROM mcr.microsoft.com/dotnet/sdk:6.0

LABEL "com.github.actions.name"="dotnet-sonarscanner"
LABEL "com.github.actions.description"="sonarscanner for dotnet core"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/Secbyte/dotnet-sonarscanner"
LABEL "homepage"="https://github.com/Secbyte/dotnet-sonarscanner"
LABEL "maintainer"="Joshua Duffy <mail@joshuaduffy.org>"

# jre installation require man folder to exist 
RUN mkdir -p /usr/share/man/man1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    wget -q https://packages.microsoft.com/config/debian/10/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
    chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && \
    chown root:root /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends default-jre apt-transport-https aspnetcore-runtime-6.0 mono-complete && \
    apt-get install -y --no-install-recommends python3 python3-distutils python3-pip python3-setuptools && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    apt-get autoremove -y && \
    dotnet tool install dotnet-sonarscanner --tool-path . --version 5.5.3

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]