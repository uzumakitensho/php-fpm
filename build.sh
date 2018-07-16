#!/bin/bash

REPO="hafid11afridian"
PROJECT=$(pwd | rev | cut -d / -f 1 | rev)

declare -a PIPELINE

while IFS= read -r -d $'\0' BUILD_DIR; do
    COUNT=$(grep -o / <<< "$BUILD_DIR" | wc -l | xargs printf "%03d")
    PIPELINE+=("$COUNT $BUILD_DIR")
done < <(find . -type f -name "Dockerfile" -print0)

printf '%s\0' "${PIPELINE[@]}" | sort -z | while IFS= read -r -d $'\0' SORTED; do
    BUILD_DIR=$(echo "$SORTED" | cut -sd ' ' -f 2- | cut -sd / -f 2- | rev | cut -sd / -f 2- | rev)
    TAG=$(echo "$BUILD_DIR" | tr / -)
    NAME="$REPO/$PROJECT:$TAG"
    echo "Processing $NAME"
    pushd "$BUILD_DIR" > /dev/null
    docker build . -t "$NAME" || exit 1
    docker push "$NAME"
    popd > /dev/null
done
