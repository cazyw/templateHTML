# Buildkite

[Buildkite](https://buildkite.com) is "a platform for running fast, secure, and scalable continuous integration pipelines on your own infrastructure".

Currently I'm using it in one Github project (https://github.com/cazyw/shakespeare-quotes) in order to automatically run all the tests for any commits/pull requests made to the repository.

## Setup

### Buildkite

A pipeline was set up in the Buildkite console. This contained the single Step
* Run script or command: `buildkite-agent pipeline upload`

No other environment variables or settings were set in this pipeline.

The second step was stored inside a config file in the project repository itself in `.buildkite/pipeline.yml`

```yml
steps:
  - label: ':hammer: Tests'
    command: 'npm install && cd client && npm install && npm run build && cd .. && npm test'
```

The first step loads this config file and the second step runs the tests.

Currently Buildkite runs locally on my Windows PC.

1. Download the buildkite files from https://github.com/buildkite/agent/releases
1. Extract to `C:\buildkite-agent`
1. Edit the `buildkite-agent.cfg` so `token="<the token value from buildkite>"`. The token value is available in the Dashboard

In order to then run the agent (required in order to run the pipeline), navigate to `C:\buildkite-agent` and run

```Powershell
PS> .\buildkite-agent.exe start
```

Buildkite will run the commands in `cmd`. Start the build agent whenever the pipeline needs to be run. [There are alternatives to hosting the agent online e.g. on AWS so it's not reliant on the agent being started on the local PC]

### Github

In order to have Github use the Buildkite pipeline, some changes to the settings were made under the Settings section of the repo.

#### Branches

The following Branch Protection Rules were added:
* Require pull request reviews before merging
* Require status checks to pass before merging

#### Webhooks

This needs to be setup after the Buildhook pipeline is set
* Payload URL: https://webhook.buildkite.com/deliver/<buildkite token>
* Content type: application/json
* Which events would you like to trigger this webhook?
  * Deployments
  * Pull requests
  * Pushes
* Active

