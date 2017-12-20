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
    clm3_expa_48
    clm3_expa_49
    clm3_expa_50
    clm3_expa_51
    clm3_expa_52
    clm3_expa_53
    clm3_expa_54
    clm3_expa_55
    clm3_expa_56
    clm3_expa_57
    clm3_expa_58
    clm3_expa_59
    clm3_expa_60
    clm3_expa_61
    clm3_expa_62
    clm3_expa_63
    clm3_expa_64
    clm3_expa_65
    clm3_expa_66
    clm3_expa_67
    clm3_expa_68
    clm3_expa_69
    clm3_expa_70
    clm3_expa_71
    clm3_expa_72
    clm3_expa_73
    clm3_expa_74
    clm3_expa_75
    clm3_expa_76
    clm3_expa_77
    clm3_expa_78
    clm3_expa_79
    clm3_expa_80
    clm3_expa_81
    clm3_expa_82
    clm3_expa_83
    clm3_expa_84
    clm3_expa_85
    clm3_expa_86
    clm3_expa_87
    clm3_expa_88
    clm3_expa_89
    clm3_expa_90
    clm3_expa_91
    clm3_expa_92
    clm3_expa_93
    clm3_expa_94
    clm3_expa_95
    clm3_expa_96
    clm3_expa_97
    clm3_expa_98
    clm3_expa_99
    clm3_4_1
    clm3_4_2
    clm3_5_00
    clm3_5_01
    clm3_5_02
    clm3_5_03
    clm3_5_04
    clm3_5_05
    clm3_5_06
    clm3_5_07
    clm3_5_08
    clm3_5_09
    clm3_5_10
    clm3_5_11
    clm3_5_12
    clm3_5_13
    clm3_5_14
    clm3_5_15
    clm3_5_16
    clm3_5_17
    clm3_5_18
    clm3_5_19
    clm3_5_20
    clm3_6_00
    clm3_6_01
    clm3_6_02
    clm3_6_03
    clm3_6_04
    clm3_6_05
    clm3_6_06
    clm3_6_07
    clm3_6_08
    clm3_6_09
    clm3_6_10
    clm3_6_11
    clm3_6_12
    clm3_6_13
    clm3_6_14
    clm3_6_15
    clm3_6_16
    clm3_6_17
    clm3_6_18
    clm3_6_19
    clm3_6_20
    clm3_6_21
    clm3_6_23
    clm3_6_24
    clm3_6_25
    clm3_6_26
    clm3_6_27
    clm3_6_28
    clm3_6_29
    clm3_6_30
    clm3_6_31
    clm3_6_32
    clm3_6_33
    clm3_6_34
    clm3_6_35
    clm3_6_36
    clm3_6_37
    clm3_6_38
    clm3_6_39
    clm3_6_40
    clm3_6_41
    clm3_6_42
    clm3_6_43
    clm3_6_44
    clm3_6_45
    clm3_6_46
    clm3_6_47
    clm3_6_48
    clm3_6_49
    clm3_6_50
    clm3_6_51
    clm3_6_52
    clm3_6_53
    clm3_6_54
    clm3_6_55
    clm3_6_56
    clm3_6_57
    clm3_6_58
    clm3_6_59
    clm3_6_60
    clm3_6_61
    clm3_6_62
    clm3_6_63
    clm3_6_64
    clm3_7_00
    clm3_7_01
    clm3_7_02
    clm3_7_03
    clm3_7_04
    clm3_7_05
    clm3_7_06
    clm3_7_07
    clm3_7_08
    clm3_7_09
    clm3_7_10
    clm3_7_11
    clm3_7_12
    clm3_7_13
    clm3_7_14
    clm3_7_15
    clm3_8_00
    clm4_0_00
    clm4_0_01
    clm4_0_02
    clm4_0_03
    clm4_0_04
    clm4_0_05
    clm4_0_06
    clm4_0_07
    clm4_0_08
    clm4_0_09
    clm4_0_10
    clm4_0_11
    clm4_0_12
    clm4_0_13
    clm4_0_14
    clm4_0_15
    clm4_0_16
    clm4_0_17
    clm4_0_18
    clm4_0_19
    clm4_0_20
    clm4_0_21
    clm4_0_22
    clm4_0_23
    clm4_0_24
    clm4_0_25
    clm4_0_26
    clm4_0_27
    clm4_0_28
    clm4_0_29
    clm4_0_30
    clm4_0_31
    clm4_0_32
    clm4_0_33
    clm4_0_34
    clm4_0_35
    clm4_0_36
    clm4_0_37
    clm4_0_38
    clm4_0_39
    clm4_0_40
    clm4_0_41
    clm4_0_42
    clm4_0_43
    clm4_0_44
    clm4_0_45
    clm4_0_46
    clm4_0_47
    clm4_0_48
    clm4_0_49
    clm4_0_50
    clm4_0_51
    clm4_0_52
    clm4_0_53
    clm4_0_54
    clm4_0_55
    clm4_0_56
    clm4_0_57
    clm4_0_58
    clm4_0_59
    clm4_0_60
    clm4_0_61
    clm4_0_62
    clm4_0_63
    clm4_0_64
    clm4_0_65
    clm4_0_66
    clm4_0_67
    clm4_0_68
    clm4_0_69
    clm4_0_70
    clm4_0_71
    clm4_0_72
    clm4_0_73
    clm4_0_74
    clm4_0_75
    clm4_0_76
    clm4_0_77
    clm4_0_77
    clm4_0_78
    clm4_0_79
    clm4_0_80
    clm4_0_81
    clm4_5_00
    clm4_5_01
    clm4_5_02
    clm4_5_03
    clm4_5_04
    clm4_5_05
    clm4_5_06
    clm4_5_07
    clm4_5_08
    clm4_5_09
    clm4_5_10
    clm4_5_11
    clm4_5_12
    clm4_5_13
    clm4_5_14
    clm4_5_15
    clm4_5_16
    clm4_5_17
    clm4_5_18
    clm4_5_19
    clm4_5_20
    clm4_5_21
    clm4_5_22
    clm4_5_23
    clm4_5_24
    clm4_5_25
    clm4_5_26
    clm4_5_27
    clm4_5_28
    clm4_5_29
    clm4_5_30
    clm4_5_31
    clm4_5_32
    clm4_5_33
    clm4_5_34
    clm4_5_35
    clm4_5_36
    clm4_5_37
    clm4_5_38
    clm4_5_39
    clm4_5_40
    clm4_5_41
    clm4_5_42
    clm4_5_43
    clm4_5_44
    clm4_5_45
    clm4_5_46
    clm4_5_47
    clm4_5_48
    clm4_5_49
    clm4_5_50
    clm4_5_51
    clm4_5_52
    clm4_5_53
    clm4_5_54
    clm4_5_55
    clm4_5_56
    clm4_5_57
    clm4_5_58
    clm4_5_59
    clm4_5_60
    clm4_5_61
    clm4_5_62
    clm4_5_63
    clm4_5_64
    clm4_5_65
    clm4_5_66
    clm4_5_67
    clm4_5_68
    clm4_5_69
    clm4_5_70
    clm4_5_71
    clm4_5_72
    clm4_5_73
    clm4_5_74
    clm4_5_75
    clm4_5_1_r076
    clm4_5_1_r077
    clm4_5_1_r078
    clm4_5_1_r079
    clm4_5_1_r080
    clm4_5_1_r081
    clm4_5_1_r082
    clm4_5_1_r083
    clm4_5_1_r084
    clm4_5_1_r085
    clm4_5_1_r086
    clm4_5_1_r087
    clm4_5_1_r088
    clm4_5_1_r089
    clm4_5_1_r090
    clm4_5_1_r091
    clm4_5_1_r092
    clm4_5_1_r093
    clm4_5_1_r094
    clm4_5_1_r095
    clm4_5_1_r096
    clm4_5_1_r097
    clm4_5_1_r098
    clm4_5_1_r099
    clm4_5_1_r100
    clm4_5_1_r101
    clm4_5_1_r102
    clm4_5_1_r103
    clm4_5_1_r104
    clm4_5_1_r105
    clm4_5_1_r106
    clm4_5_1_r107
    clm4_5_1_r108
    clm4_5_1_r109
    clm4_5_1_r110
    clm4_5_1_r111
    clm4_5_1_r112
    clm4_5_1_r113
    clm4_5_1_r114
    clm4_5_1_r115
    clm4_5_1_r116
    clm4_5_1_r117
    clm4_5_1_r118
    clm4_5_1_r119
    clm4_5_1_r120
    clm4_5_2_r121
    clm4_5_2_r122
    clm4_5_2_r123
    clm4_5_2_r124
    clm4_5_2_r125
    clm4_5_2_r126
    clm4_5_2_r127
    clm4_5_2_r128
    clm4_5_3_r129
    clm4_5_3_r130
    clm4_5_3_r131
    clm4_5_3_r132
    clm4_5_3_r133
    clm4_5_3_r134
    clm4_5_3_r135
    clm4_5_3_r136
    clm4_5_3_r137
    clm4_5_3_r138
    clm4_5_3_r139
    clm4_5_3_r140
    clm4_5_3_r141
    clm4_5_3_r142
    clm4_5_3_r143
    clm4_5_3_r144
    clm4_5_3_r145
    clm4_5_3_r146
    clm4_5_3_r147
    clm4_5_3_r148
    clm4_5_3_r149
    clm4_5_4_r150
    clm4_5_4_r151
    clm4_5_5_r152
    clm4_5_6_r153
    clm4_5_6_r154
    clm4_5_6_r155
    clm4_5_6_r156
    clm4_5_6_r157
    clm4_5_6_r158
    clm4_5_6_r159
    clm4_5_6_r160
    clm4_5_6_r161
    clm4_5_7_r162
    clm4_5_7_r163
    clm4_5_7_r164
    clm4_5_7_r165
    clm4_5_7_r166
    clm4_5_7_r167
    clm4_5_8_r168
    clm4_5_8_r169
    clm4_5_8_r170
    clm4_5_8_r171
    clm4_5_8_r172
    clm4_5_8_r173
    clm4_5_8_r174
    clm4_5_8_r175
    clm4_5_8_r176
    clm4_5_8_r177
    clm4_5_8_r178
    clm4_5_8_r179
    clm4_5_8_r180
    clm4_5_8_r181
    clm4_5_8_r182
    clm4_5_9_r183
    clm4_5_9_r184
    clm4_5_9_r185
    clm4_5_9_r186
    clm4_5_10_r187
    clm4_5_11_r188
    clm4_5_11_r189
    clm4_5_12_r190
    clm4_5_12_r191
    clm4_5_12_r192
    clm4_5_12_r193
    clm4_5_12_r194
    clm4_5_12_r195
    clm4_5_12_r196
    clm4_5_12_r197
    clm4_5_12_r198
    clm4_5_12_r199
    clm4_5_12_r200
    clm4_5_12_r201
    clm4_5_12_r202
    clm4_5_12_r203
    clm4_5_13_r204
    clm4_5_13_r205
    clm4_5_13_r206
    clm4_5_13_r207
    clm4_5_13_r208
    clm4_5_13_r209
    clm4_5_13_r210
    clm4_5_13_r211
    clm4_5_14_r212
    clm4_5_14_r213
    clm4_5_14_r214
    clm4_5_14_r215
    clm4_5_14_r216
    clm4_5_14_r217
    clm4_5_14_r218
    clm4_5_14_r219
    clm4_5_14_r220
    clm4_5_14_r221
    clm4_5_14_r222
    clm4_5_14_r223
    clm4_5_14_r224
    clm4_5_14_r225
    clm4_5_14_r226
    clm4_5_14_r227
    clm4_5_14_r228
    clm4_5_14_r229
    clm4_5_14_r230
    clm4_5_14_r231
    clm4_5_15_r232
    clm4_5_15_r233
    clm4_5_15_r234
    clm4_5_15_r235
    clm4_5_15_r236
    clm4_5_16_r237
    clm4_5_16_r238
    clm4_5_16_r239
    clm4_5_16_r240
    clm4_5_16_r241
    clm4_5_16_r242
    clm4_5_16_r243
    clm4_5_16_r244
    clm4_5_16_r245
    clm4_5_16_r246
    clm4_5_16_r247
    clm4_5_16_r248
    clm4_5_16_r249
    clm4_5_16_r250
    clm4_5_16_r251
    clm4_5_16_r252
    clm4_5_16_r253
    clm4_5_16_r254
    clm4_5_16_r255
    clm4_5_16_r256
    clm4_5_16_r257
    clm4_5_16_r258
    clm4_5_16_r259
    clm4_5_16_r260
    clm4_5_16_r261
    clm4_5_16_r262
    clm4_5_17_r263
    clm4_5_17_r264
    clm4_5_17_r265
    clm4_5_17_r266
    clm4_5_18_r267
    clm4_5_18_r268
    clm4_5_18_r269
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
svn checkout --ignore-externals --quiet ${SVN_ROOT_URL}/trunk_tags/${TAGS[0]} ${SVN_REPO} >> ${SVN_OUTPUT} 2>&1

REMAP=

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
