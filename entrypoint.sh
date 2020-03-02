#!/bin/bash -l

# buildCommand = $1
# testCommand = $2
# projectKey = $3
# projectName = $4
# sonarHostname = $5
# sonarOrganisation = $6
# beginArguments = $7
# endArguments = $8

set -eu

begin_cmd="/dotnet-sonarscanner begin \\
    /k:\"${3//[$'\t\r\n']:?Please set the projectKey.}\" \\
    /n:\"${4//[$'\t\r\n']:?Please set the projectName.}\" \\
    /o:\"${6//[$'\t\r\n']:?Please set the sonarOrganisation.}\" \\
    /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\""


end_cmd="/dotnet-sonarscanner end \\
     /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\""

if [ -n "$5" ]
then
    begin_cmd="$begin_cmd /d:sonar.host.url=\"${5//[$'\t\r\n']}\""
fi

if [ -n "$7" ]
then
    begin_cmd="$begin_cmd $7"
fi

if [ -n "$8" ]
then
   end_cmd="$end_cmd $8"
fi

sh -c "$begin_cmd"

sh -c "${1//[$'\t\r\n']:?Please set the buildCommand.}"

if [ -n "$2" ]
then
    sh -c "${2//[$'\t\r\n']}"
fi

sh -c "$end_cmd"
