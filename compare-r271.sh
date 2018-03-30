#!/usr/bin/env bash

function pushd() { builtin pushd "$@" > /dev/null; }

function popd() { builtin popd "$@" > /dev/null; }

# -----------------------------------------------------------------------------
#
# clm
#
# -----------------------------------------------------------------------------

GIT_REMOTE=${PWD}/../clm-final
SVN_ROOT_URL=https://svn-ccsm-models.cgd.ucar.edu/clm2

TAGS=(
    clm4_5_18_r271
    clm4_5_18_r272
)

GIT_REPO=clm-git
SVN_REPO=clm-svn

ROOT_DIR=${PWD}
GIT_OUTPUT=${ROOT_DIR}/output-git.txt
SVN_OUTPUT=${ROOT_DIR}/output-svn.txt

RESULTS=results.txt
FILTERED=filtered-results.txt
FINAL_RESULTS=final-results.txt

rm -rf ${GIT_REPO} ${SVN_OUTPUT}
rm -rf ${SVN_REPO} ${GIT_OUTPUT}
rm ${RESULTS} ${FILTERED} ${FINAL_RESULTS}

git clone ${GIT_REMOTE} ${GIT_REPO} >> ${GIT_OUTPUT} 2>&1
REMAP=components/clm
svn checkout --ignore-externals --quiet ${SVN_ROOT_URL}/trunk_tags/${TAGS[0]}/${REMAP} ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1


for tag in ${TAGS[@]}; do
    echo "Working on tag: ${tag}" >> ${RESULTS}

    if [ "${tag}" == "clm3_5_19" ]; then
        REMAP=models/lnd/clm
        rm -rf ${SVN_REPO}
        svn checkout --ignore-externals --quiet ${SVN_ROOT_URL}/trunk_tags/${tag}/${REMAP} ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1
    elif [ "${tag}" == "clm4_5_1_r105" ]; then
        REMAP=components/clm
        rm -rf ${SVN_REPO}
        svn checkout --ignore-externals --quiet ${SVN_ROOT_URL}/trunk_tags/${tag}/${REMAP} ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1
    fi

    pushd ${SVN_REPO}
    svn switch --accept theirs-full --ignore-externals --quiet ${SVN_ROOT_URL}/trunk_tags/${tag}/${REMAP} >> ${SVN_OUTPUT} 2>&1
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

# -----------------------------------------------------------------------------
#
# ptclm
#
# -----------------------------------------------------------------------------

GIT_REMOTE=${PWD}/../ptclm-final
SVN_ROOT_URL=https://svn-ccsm-models.cgd.ucar.edu/PTCLM

TAGS=(
    PTCLM1_110504
    PTCLM1_110726
    PTCLM1_110902
    PTCLM1_111114
    PTCLM1_111129
    PTCLM1_120125
    PTCLM1_130111
    PTCLM1_130130
    PTCLM1_130216
    PTCLM1_130529
    PTCLM1_130724
    PTCLM1_130910
    PTCLM1_130920
    PTCLM1_130923
    PTCLM1_130929
    PTCLM2_131119
    PTCLM2_131122
    PTCLM2_131122b
    PTCLM2_131122c
    PTCLM2_140204
    PTCLM2_140216
    PTCLM2_140423
    PTCLM2_140521
    PTCLM2_140816
    PTCLM2_150126
    PTCLM2_150410
    PTCLM2_150413
    PTCLM2_150414
    PTCLM2_150826
    PTCLM2_151009
    PTCLM2_160127
    PTCLM2_160127a
    PTCLM2_160818
    PTCLM2_170302
    PTCLM2_170706
    PTCLM2_171016
    PTCLM2_171016b
    PTCLM2_171016c
    PTCLM2_171016d
    PTCLM2_171024
    PTCLM2_171024b
)

GIT_REPO=ptclm-git
SVN_REPO=ptclm-svn

GIT_OUTPUT=output-git.txt
SVN_OUTPUT=output-svn.txt

RESULTS=results.txt
FILTERED=filtered-results.txt
FINAL_RESULTS=final-results.txt

rm -rf ${GIT_REPO} ${SVN_OUTPUT}
rm -rf ${SVN_REPO} ${GIT_OUTPUT}
rm ${RESULTS} ${FILTERED} ${FINAL_RESULTS}

git clone ${GIT_REMOTE} ${GIT_REPO} >> ${GIT_OUTPUT} 2>&1
svn checkout --quiet ${SVN_ROOT_URL}/trunk ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1

for tag in ${TAGS[@]}; do
    pushd ${GIT_REPO}
    git checkout ${tag} >> ../${GIT_OUTPUT} 2>&1
    popd
    pushd ${SVN_REPO}
    svn switch --quiet ${SVN_ROOT_URL}/trunk_tags/${tag} >> ../${SVN_OUTPUT} 2>&1
    popd
    diff --exclude-from=conversion-ignore.txt --recursive ${SVN_REPO} ${GIT_REPO} >> ${RESULTS}
done

# filter some noise from the diff
grep -v \
     -e svnurl \
     -e conversion-ignore.txt \
     -e '\-\-\-' \
     -e "[[:digit:]]c[[:digit:]]" \
     ${RESULTS} > ${FILTERED}
#
# expected differences
#

# PTCLM2_140204/test/compdirs/std_1850_US-Me - empty dir in all svn revisions.
# PTCLM2_140204/test/compdirs/std_DE_Tha - empty dir in all svn revisions
grep -v \
     -e 'Only in ptclm-svn/test/compdirs: std_1850_US-Me' \
     -e 'Only in ptclm-svn/test/compdirs: std_DE_Tha' \
     ${FILTERED}

# Only in ptclm-svn: mydatafiles - added as empty dir PTCLM1_130920, empty in PTCLM1_130923, first file in PTCLM1_130929

# Only in ptclm-svn/mydatafiles: 1x1pt_US-UMB - added as empty dir in PTCLM2_131122b, first file in PTCLM2_131122c

exit

# -----------------------------------------------------------------------------
#
# rtm
#
# -----------------------------------------------------------------------------

ROOT_URL=https://svn-ccsm-models.cgd.ucar.edu/rivrtm/trunk_tags

TAGS=(
    rtm1_0_01
    rtm1_0_02
    rtm1_0_03
    rtm1_0_04
    rtm1_0_05
    rtm1_0_06
    rtm1_0_07
    rtm1_0_08
    rtm1_0_09
    rtm1_0_10
    rtm1_0_11
    rtm1_0_12
    rtm1_0_13
    rtm1_0_14
    rtm1_0_15
    rtm1_0_16
    rtm1_0_17
    rtm1_0_18
    rtm1_0_19
    rtm1_0_20
    rtm1_0_21
    rtm1_0_22
    rtm1_0_23
    rtm1_0_24
    rtm1_0_25
    rtm1_0_26
    rtm1_0_27
    rtm1_0_28
    rtm1_0_29
    rtm1_0_30
    rtm1_0_31
    rtm1_0_32
    rtm1_0_33
    rtm1_0_34
    rtm1_0_35
    rtm1_0_36
    rtm1_0_37
    rtm1_0_38
    rtm1_0_39
    rtm1_0_40
    rtm1_0_41
    rtm1_0_42
    rtm1_0_43
    rtm1_0_44
    rtm1_0_45
    rtm1_0_46
    rtm1_0_47
    rtm1_0_48
    rtm1_0_49
    rtm1_0_50
    rtm1_0_51
    rtm1_0_52
    rtm1_0_53
    rtm1_0_54
    rtm1_0_55
    rtm1_0_56
    rtm1_0_57
    rtm1_0_58
    rtm1_0_59
    rtm1_0_60
    rtm1_0_61
    rtm1_0_62
    rtm1_0_63
)

rm -rf rtm-git output-svn.txt
rm -rf rtm-svn output-git.txt

git clone git@github.com:escomp/rtm.git rtm-git >> output-git.txt 2>&1
svn checkout --quiet https://svn-ccsm-models.cgd.ucar.edu/rivrtm/trunk rtm-svn >> output-svn.txt 2>&1

for tag in ${TAGS[@]}; do
    pushd rtm-git
    git checkout ${tag} >> ../output-git.txt 2>&1
    popd
    pushd rtm-svn
    svn switch --quiet ${ROOT_URL}/${tag} >> ../output-svn.txt 2>&1
    popd
    diff --exclude-from=conversion-ignore.txt --recursive rtm-svn rtm-git
done

exit

# -----------------------------------------------------------------------------
#
# mosart
#
# -----------------------------------------------------------------------------

ROOT_URL=https://svn-ccsm-models.cgd.ucar.edu/mosart/trunk_tags/

TAGS=(
    mosart1_0_00
    mosart1_0_01
    mosart1_0_02
    mosart1_0_03
    mosart1_0_04
    mosart1_0_05
    mosart1_0_06
    mosart1_0_07
    mosart1_0_08
    mosart1_0_09
    mosart1_0_10
    mosart1_0_11
    mosart1_0_12
    mosart1_0_13
    mosart1_0_14
    mosart1_0_15
    mosart1_0_16
    mosart1_0_17
    mosart1_0_18
    mosart1_0_19
    mosart1_0_20
    mosart1_0_21
    mosart1_0_22
    mosart1_0_23
    mosart1_0_24
    mosart1_0_25
    mosart1_0_26
    mosart1_0_27
    mosart1_0_28
)

rm -rf mosart-svn output-svn.txt
rm -rf mosart-git output-git.txt

git clone git@github.com:escomp/mosart.git mosart-git >> ../output-git.txt 2>&1
svn checkout https://svn-ccsm-models.cgd.ucar.edu/mosart/trunk mosart-svn >> ../output-svn.txt 2>&1

for tag in ${TAGS[@]}; do
    pushd mosart-git
    git checkout ${tag} >> ../output-git.txt 2>&1
    popd
    pushd mosart-svn
    svn switch --quiet ${ROOT_URL}/${tag} >> ../output-svn.txt 2>&1
    popd
    diff --exclude-from=conversion-ignore.txt --recursive rtm-svn rtm-git
done
