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