#!/bin/sh -l

# buildCommand = $1
# testCommand = $2
# projectKey = $3
# projectName = $4
# sonarHostname = $5
# sonarOrganisation = $6
# verbose = $7

set -eu

begin_cmd="/dotnet-sonarscanner begin"
end_cmd="/dotnet-sonarscanner end"

if [ -n "$3" ]
then
    begin_cmd="$begin_cmd /k:\"$3\""
fi

if [ -n "$4" ]
then
    begin_cmd="$begin_cmd /n:\"$4\""
fi

if [ -n "$5" ]
then
    begin_cmd="$begin_cmd /d:sonar.host.url=\"$5\""
fi

if [ -n "$6" ]
then
    begin_cmd="$begin_cmd /o:\"$6\""
fi

if [ -n "${SONAR_TOKEN}" ]
then
    begin_cmd="$begin_cmd /d:sonar.login=\"${SONAR_TOKEN}\""
    end_cmd="$end_cmd /d:sonar.login=\"${SONAR_TOKEN}\""
fi

sh -c "$begin_cmd"

if [ -n "$1" ]
then
    sh -c "$1"
fi

if [ -n "$2" ]
then
    sh -c "$2"
fi

sh -c "$end_cmd"
