# Aliases for important directories
export repo='/google/src/cloud/nadeemm/switch_client/google3'

# Switch to the main Fig client.
alias swc='g4d switch_client'

# thefuck: Corrects console commands.
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# Bequt
alias bequt='/auto/build/static/projects/bequt/bequt.sh'

# GMon.
commitMonarchConfig() {
  blaze run $1 -- --mode=commit --skip_confirmation
}
diffMonarchConfig() {
  blaze run $1 -- --mode=diff
}
printMonarchConfig() {
  blaze run $1 -- --mode=print
}
alias mcprint=printMonarchConfig
alias mcdiff=diffMonarchConfig
alias mccommit=commitMonarchConfig

# Useful directories.
export CORE="java/com/google/lifescience/csp/frontend/core"
export SCHEMA="lifescience/csp/studies/schema"
export CONFIG="lifescience/csp/study/config"
export SUMMARYCARD="java/com/google/lifescience/csp/studies/spec/summarycard/data"

# Files affected by current CL. Turn off coloring to allow piping this.bs
fst() {
  hg status --change . -n --color=never
}

# Directories affected by current CL.
dst() {
  hg pstatus -n --color=never | xargs dirname | uniq
}

# Check ganpati membership.
# Arguments: group name (mdb/blah), ldap
alias aclcheck="/google/data/ro/projects/ganpati/aclcheck"

# Span SQL
alias spansql="span sql --max_output_width=-1 --max_value_lines=-1"

function scprint() {
  local gclfile=$1
  local clause=$2
  gcl $1 print --objtype=studyconfig $2
}

# Spanner Queue check
alias queuecheck="spansql /span/global/lifescience-csp:studies-prod \"SELECT FORMAT('%d,%d,%s', Q.RegionId, Q.AccountId, Q.MessageId) AS Key, Q.Payload, Q.DeliverTime FROM AccountsQueue AS Q WHERE Q.DeliverTime < CURRENT_TIMESTAMP();\""
alias queuecount="spansql /span/global/lifescience-csp:studies-prod 'SELECT count(*) from AccountsQueue where DeliverTime < CURRENT_TIMESTAMP()'"

function getdb() {
  local dbname
  local db=${1:-'studies'}
  local env=${2:-'prod'}
  case $env in
    "loadtest")
      dbname="/span/nonprod/lifescience-csp:$db-loadtest"
      ;;
    "dev")
      dbname="/span/nonprod/lifescience-csp:$db-dev"
      ;;
    "autopush")
      dbname="/span/nonprod/lifescience-csp:$db-autopush"
      ;;
    "staging")
      dbname="/span/global/lifescience-csp:$db-staging"
      ;;
    "preprod")
      dbname="/span/global/lifescience-csp:$db-preprod"
      ;;
    "prod")
      dbname="/span/global/lifescience-csp:$db-prod"
      ;;
  esac
  echo $dbname
}

# Quick database query.
function dbquery() {
  dbpath=$(getdb $1 $2)
  shift;
  shift;
  spansql $dbpath "$@"
}

# Break glass with a bug.
function breakglass() {
  grants add -r --reason=b/$1 lifescience-csp-oncall:4h
}

# Board release train.
alias board_release_train="lifescience/csp/tools/board_release_train/board_release_train.sh"

# Generate test data for new admin groups.
alias generate_testdata="javatests/com/google/lifescience/csp/study/config/generate_testdata.sh"

# Task id conversion.
alias task_id_converter="java/com/google/lifescience/csp/tools/task/task_id_converter.sh"

# Admin Session command line tool.
alias admin_session=/google/data/ro/projects/tonic/admin_session

# Local rpcStudio.
alias rpcstudio="/google/bin/releases/frameworks-rpc-studio/prod/run.sh"

# Run API with local study config.
alias run_api_with_config='boq run LifescienceCspStudiesV1Service LifescienceCspFrontendDataService LifescienceCspDebugService'

# Run FE with local API and config.
alias run_fe_with_config='java/com/google/lifescience/csp/frontend/core/runcspfe.sh -- --local=frontenddata --local=studies --local=debug'

# Get all PRT accounts.
function getaccounts() {
  blaze run //experimental/users/chrisso/java/com/google/lifescience/csp/tools/delete:check_registry_participant -- --spanner_db_studies=/span/global/lifescience-csp:studies-prod --participant_id=$1
}

# Delete PRT account.
alias delete_participant="java/com/google/lifescience/csp/tools/delete/delete_registry_participants.sh"

# RPC replay.
alias rpcreplay=/google/data/ro/teams/frameworks-test-team/rpcreplay-cli/live/rpcreplay
