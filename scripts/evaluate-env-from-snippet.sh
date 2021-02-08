#!/bin/sh -ex

# cd <path_to_repo>/scripts
# export PATH=${PATH}:<path_to_repo>/scripts;

EVAL_SNIPPET_PROVIDER=${EVAL_SNIPPET_PROVIDER:-gitlab}

if [[ ! $EVAL_SNIPPET_ID ]]; then >&2 echo "EVAL_SNIPPET_ID?!"; exit 1; fi
if [[ ! $EVAL_SNIPPET_PROVIDER ]]; then >&2 echo "EVAL_SNIPPET_PROVIDER?!"; exit 1; fi
if [[ ! $EVAL_SNIPPET_PROVIDER_TOKEN ]]; then >&2 echo "EVAL_SNIPPET_PROVIDER_TOKEN?!"; exit 1; fi

if [[ $EVAL_SNIPPET_PROVIDER == gitlab ]]; then

SNIPPET_DATA=$(curl --header "PRIVATE-TOKEN: ${EVAL_SNIPPET_PROVIDER_TOKEN}" https://gitlab.com/api/v4/snippets/${EVAL_SNIPPET_ID})
SNIPPET_NAME=$(echo ${SNIPPET_DATA} | jq -r .file_name)

  echo "Try to evaluate '${SNIPPET_NAME}'..."

  if [[ ! -z $EVAL_SNIPPET_NAME && $EVAL_SNIPPET_NAME != $SNIPPET_NAME ]]; then >&2 echo "Evaluating wrong snippet. Expect '${EVAL_SNIPPET_NAME}'"; exit 1; fi

  $(curl --header "PRIVATE-TOKEN: ${EVAL_SNIPPET_PROVIDER_TOKEN}" https://gitlab.com/api/v4/snippets/${EVAL_SNIPPET_ID}/raw | jq -r 'keys[] as $k | "export \($k)=\(.[$k])"')

else
  echo "Unknown provider" >&2; exit;
fi
