#!/bin/bash
# Set up the STOL repositories to be used based on dev, feature and release branches

set -e

help()
{
    # Display Help
    echo "Set up the STOL repositories for apt package downloads"
    echo
    echo "Syntax: $0 [-r|t]"
    echo "options:"
    echo "r     Use the argument as the GITHUB_REF_NAME"
    echo "t     Indicates this is a tag"
    echo "h     Print this Help."
    echo
}

# Get the options
while getopts "hr:t" option; do
    case $option in
        r) # branch reference name
            GITHUB_REF_NAME=${OPTARG}
            ;;
        t) # GH tag
            GITHUB_REF_TYPE=tag
            ;;
        h) # display Help
            help
            exit;;
        *) # display Help
            help
            exit 1;;
    esac
done
shift $((OPTIND-1))

if [ $# -gt 0 ]; then
    help
    exit 1
fi

# don't start echoing output until now
#set -x

# default to use the develop repo
USE_DEVELOP=1

# use dashes instead of underscores in our repo code names
NO_UNDERSCORE_NAME=${GITHUB_REF_NAME//_/-}

# check for feature branches
if [[ ${GITHUB_REF_NAME} =~ feature/.* ]]; then
    APT_CODENAME=feature-${NO_UNDERSCORE_NAME##*/}

# check for release candidate branches, do not use develop for these
elif [[ ${GITHUB_REF_NAME} =~ release/.* ]]; then
    APT_CODENAME=candidate-${NO_UNDERSCORE_NAME##*/}
    USE_DEVELOP=0

# check for release tags, do not use develop for these
elif [[ $GITHUB_REF_TYPE = tag ]]; then
    APT_CODENAME=release-${NO_UNDERSCORE_NAME##*/}
    USE_DEVELOP=0

# default to pull from for all repos
else
    APT_CODENAME=develop
fi

STOL_APT_AWS_BUCKET_NAME=stol-apt-repository
STOL_APT_REPOSITORY=http://s3.amazonaws.com/${STOL_APT_AWS_BUCKET_NAME}

LIST_FILE=/etc/apt/sources.list.d/carma.list
PREFERENCE_FILE=/etc/apt/preferences.d/carma.pref
rm -f $LIST_FILE
rm -f $PREFERENCE_FILE
if [ $USE_DEVELOP -eq 1 ]; then
    echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} develop main" >> $LIST_FILE
fi
if [[ -n "$APT_CODENAME" && "$APT_CODENAME" != "develop" ]]; then
    echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} ${APT_CODENAME} main" >> $LIST_FILE
    # if using develop as a secondary repo then pin this one
    if [ $USE_DEVELOP -eq 1 ]; then
    # pin this repository
cat << EOF >> $PREFERENCE_FILE
Package: *
Pin: release o=${STOL_APT_AWS_BUCKET_NAME},n=${APT_CODENAME}
Pin-Priority: 999
EOF
    fi

fi

echo "GITHUB_REF_NAME=$GITHUB_REF_NAME APT_CODENAME=$APT_CODENAME USE_DEVELOP=$USE_DEVELOP"
echo "<----- List file below ----->"
cat $LIST_FILE
if [ -f $PREFERENCE_FILE ]; then
    echo "<----- Preference file below ----->"
    cat $PREFERENCE_FILE
fi