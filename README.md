# dotnet-sonarscanner

[`dotnet-sonarscanner`](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-msbuild/) GitHub Action.

_Currently does not support username/password authentication and presumes you are using tokens. Open to changing this, if required._

## Usage example

```yaml
- name: Sonarscanner for dotnet
  uses: Secbyte/dotnet-sonarscanner@v2.3
  with:
    buildCommand: dotnet build .
    testCommand: dotnet test .
    projectKey: a-project-key
    projectName: a-project-name
    sonarOrganisation: an-org
    beginArguments: >
        /d:sonar.verbose="true"
        /d:sonar.cs.opencover.reportsPaths='"/path/to/coverage.xml","/path/to/coverage.2.xml"'
        /d:sonar.coverage.exclusions='"**/*.cs","**/*.md"'
  env:
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

```yaml
buildCommand:
  description: "Command to invoke build"
  required: true
testCommand:
  description: "Command to invoke tests"
  required: false
projectKey:
  description: "Specifies the key of the analyzed project in SonarQube"
  required: true
projectName:
  description: "Specifies the name of the analyzed project in SonarQube"
  required: true
sonarHostname:
  description: "The server URL"
  default: "https://sonarcloud.io"
  required: false
sonarOrganisation:
  description: "Organisation"
  required: true
beginArguments:
  description: "Arguments to append to the begin command"
  required: false
endArguments:
  description: "Arguments to append to the end command"
  required: false
```

## Environment variables

* `SONAR_TOKEN` - Token from SonarCloud with ExecuteAnalysis permissions
* `GITHUB_TOKEN` - GitHub Token

## Release new version

1. Specify new version number in image parameter in [`action.yml`](https://github.com/dodopizza/dotnet-sonarscanner/blob/master/action.yml);
2. Create and publish new release with the same version number;
3. `default.yml` workflow starts and publishes new `GitHub Package` with specified version.