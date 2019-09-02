# dotnet-sonarscanner

[`dotnet-sonarscanner`](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-msbuild/) GitHub Action.

_Currently does not support username/password authentication and presumes you are using tokens. Open to changing this, if required._

## Usage example

```yaml
- name: Sonarscanner for dotnet
  uses: Secbyte/dotnet-sonarscanner@v1.0
  with:
    buildCommand: dotnet build .
    testCommand: dotnet test .
    projectKey: a-project-key
    projectName: a-project-name
    sonarOrganisation: an-org
    verbose: "true"
    openCoverPaths: "tests/coverage.opencover.xml"
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
verbose:
  default: "false"
  description: "Enable verbose logging"
  required: false
openCoverPaths:
  description: "Path(s) to coverage file(s)"
  required: false
```

## Environment variables

* `SONAR_TOKEN` - Token from SonarCloud with ExecuteAnalysis permissions
* `GITHUB_TOKEN` - GitHub Token
