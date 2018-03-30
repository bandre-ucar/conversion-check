#!/usr/bin/env bash

function pushd() { builtin pushd "$@" > /dev/null; }

function popd() { builtin popd "$@" > /dev/null; }

# -----------------------------------------------------------------------------
#
# hillslope branch
#
# -----------------------------------------------------------------------------

GIT_REMOTE=${PWD}/../fan-final
SVN_ROOT_URL=https://svn-ccsm-models.cgd.ucar.edu/clm2

TAGS=(
    FAN_n05_clm4_5_18_r272
)

SVN_TAG_ROOT=branch_tags/FAN_tags

GIT_REPO=clm-git
SVN_REPO=clm-svn

ROOT_DIR=${PWD}
GIT_OUTPUT=${ROOT_DIR}/output-git.txt
SVN_OUTPUT=${ROOT_DIR}/output-svn.txt

RESULTS=results.txt
FILTERED=filtered-results.txt
FINAL_RESULTS=final-results.txt

rm -rf ${GIT_REPO} ${GIT_OUTPUT}
rm -rf ${SVN_REPO} ${SVN_OUTPUT}
rm ${RESULTS} ${FILTERED} ${FINAL_RESULTS}

REMAP=components/clm

git clone ${GIT_REMOTE} ${GIT_REPO} >> ${GIT_OUTPUT} 2>&1
svn checkout --ignore-externals --quiet ${SVN_ROOT_URL}/${SVN_TAG_ROOT}/${TAGS[0]}/${REMAP} ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1

for tag in ${TAGS[@]}; do
    echo "Working on tag: ${tag}" >> ${RESULTS}

    pushd ${SVN_REPO}
    svn switch --accept theirs-full --ignore-externals --quiet ${SVN_ROOT_URL}/${SVN_TAG_ROOT}/${tag}/${REMAP} >> ${SVN_OUTPUT} 2>&1
    popd
    
    pushd ${GIT_REPO}
    git checkout ${tag} >> ${GIT_OUTPUT} 2>&1
    popd

    diff --exclude-from=conversion-ignore.txt --recursive ${SVN_REPO} ${GIT_REPO} >> ${RESULTS}
#    if [ $? -ne 0 -a ${tag} != 'clm3_expa_50' ]; then
#        exit
#    fi
done

# filter some noise from the diff
grep -v \
     -e '\$Id' \
     -e '\$HeadURL' \
     -e '\$URL' \
     -e conversion-ignore.txt \
     -e '\-\-\-' \
     -e "[[:digit:]]c[[:digit:]]" \
     ${RESULTS} > ${FILTERED}
#
# expected differences
#


# Only in ptclm-svn: mydatafiles - added as empty dir PTCLM1_130920, empty in PTCLM1_130923, first file in PTCLM1_130929

# Only in ptclm-svn/mydatafiles: 1x1pt_US-UMB - added as empty dir in PTCLM2_131122b, first file in PTCLM2_131122c

exit
