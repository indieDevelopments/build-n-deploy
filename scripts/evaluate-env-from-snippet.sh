#!/bin/sh -ex
EVAL_SNIPPET_PROVIDER=gitlab
if [[ ! $EVAL_SNIPPET_ID ]]; then >&2 echo "EVAL_SNIPPET_ID?!"; exit 1; fi
if [[ ! $EVAL_SNIPPET_PROVIDER ]]; then >&2 echo "EVAL_SNIPPET_PROVIDER?!"; exit 1; fi
if [[ ! $EVAL_SNIPPET_PROVIDER_TOKEN ]]; then >&2 echo "EVAL_SNIPPET_PROVIDER_TOKEN?!"; exit 1; fi

if [[ $EVAL_SNIPPET_PROVIDER == gitlab ]]; then

SNIPPET_DATA=$(curl --header "PRIVATE-TOKEN: ${EVAL_SNIPPET_PROVIDER_TOKEN}" https://gitlab.com/api/v4/snippets/${EVAL_SNIPPET_ID})
SNIPPET_CONTENT=$(curl --header "PRIVATE-TOKEN: ${EVAL_SNIPPET_PROVIDER_TOKEN}" https://gitlab.com/api/v4/snippets/${EVAL_SNIPPET_ID}/raw)

SNIPPET_NAME=$(echo ${SNIPPET_DATA} | jq -r .file_name)

echo "Evaluate '${SNIPPET_NAME}'..."

$(echo $SNIPPET_CONTENT | jq -r 'keys[] as $k | "export \($k)=\(.[$k])"')
fi
