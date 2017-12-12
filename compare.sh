#!/usr/bin/env bash

function pushd() { builtin pushd "$@" > /dev/null; }

function popd() { builtin popd "$@" > /dev/null; }

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
