#!/bin/bash
# Set up the STOL repositories to be used based on dev, feature and release branches

# check for the branch name as as argument if not already set as environment varaible
if [ -z "${BRANCH_NAME}" ]; then
    BRANCH_NAME=$1
fi

STOL_APT_AWS_BUCKET_NAME=stol-apt-repository
STOL_APT_REPOSITORY=http://s3.amazonaws.com/${STOL_APT_AWS_BUCKET_NAME}
# default to use the develop repo
USE_DEVELOP=1

if [ ! -z "${BRANCH_NAME}" ]; then
    if [[ ${BRANCH_NAME} =~ feature/.* ]]; then
        APT_CODENAME=feature-$(echo ${BRANCH_NAME} | sed -E -e 's/feature\/(.*)/\1/g')
    fi
    if [[ ${BRANCH_NAME} =~ candidate/.* ]]; then
        APT_CODENAME=candidate-$(echo ${BRANCH_NAME} | sed -E -e 's/candidate\/(.*)/\1/g')
        USE_DEVELOP=0
    fi
    if [[ ${BRANCH_NAME} =~ release/.* ]]; then
        APT_CODENAME=release-$(echo ${BRANCH_NAME} | sed -E -e 's/release\/(.*)/\1/g')
        USE_DEVELOP=0
    fi
fi

LIST_FILE=/etc/apt/sources.list.d/carma.list
PREFERENCE_FILE=/etc/apt/preferences.d/carma.pref
rm -f $LIST_FILE
rm -f $PREFERENCE_FILE
if [ $USE_DEVELOP -eq 1 ]; then
    echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} develop main" >> $LIST_FILE
fi
if [ ! -z "$APT_CODENAME" ]; then
    echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} ${APT_CODENAME} main" >> $LIST_FILE
    # pin this repository
cat << EOF >> $PREFERENCE_FILE
    Package: *
    Pin: ${APT_CODENAME} o=${STOL_APT_AWS_BUCKET_NAME
    Pin-Priority: 999
EOF

fi

echo "BRANCH_NAME=$BRANCH_NAME APT_CODENAME=$APT_CODENAME USE_DEVELOP=$USE_DEVELOP"
echo "<----- List file below ----->"
cat $LIST_FILE
if [ -f $PREFERENCE_FILE ]; then
    echo "<----- Preference file below ----->"
    cat $PREFERENCE_FILE
fi