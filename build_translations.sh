#!/bin/bash

#
# Requirements:
#
# ensure language packs are installed. e.g. for French
#> sudo apt-get install language-pack-fr
#

# perform all actions relative to the path of this script
SCRIPT_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPT_DIR" ]]; then
  SCRIPT_DIR="$PWD"
else
  cd $SCRIPT_DIR
  SCRIPT_DIR="$PWD"
fi

# include helper functions
. "$SCRIPT_DIR/lib/doc_functions.sh"

# build localised versions
if [ ${LOCALISE} -eq 1  ]; then

    # for l in fr,fr_FR pt,pt_PT   # this is where you add new languages
    for l in fr,fr_FR es_419,es_419 pt,pt_PT cs,cs_CZ
    do

        lang=${l%,*};
        locale=${l#*,};
        echo "translating: $lang [ $locale ]";

        tmp="$TMPBASE/$lang"
        rm -rf $tmp
        mkdir -p $tmp


        # comment as you wish
        # format:
        #$> translate <doc name> <chapters subfolder> ["html","pdf","both"]
        # mkdir $tmp
        cp -a $src/resources/mkdocs/* $tmp/
        myml=$tmp/mkdocs.yml

        echo "    - User:" >> $myml
        translate "dhis2_user_manual_en" "user" "both" $lang $locale
        translate "dhis2_end_user_manual" "end-user" "both" $lang $locale
        translate "dhis2_action_tracker_manual" "at-app" "both" $lang $locale
        translate "dhis2_bottleneck_analysis_manual" "bna-app" "both" $lang $locale
        translate "dhis2_scorecard_manual" "scorecard-app" "both" $lang $locale
        translate "dhis2_who_data_quality_tool_guide" "dq-app" "both" $lang $locale

        echo "    - Implementer:" >> $myml
        translate "dhis2_implementation_guide" "implementer" "both" $lang $locale
        translate "dhis2_tracker_implementation_guide" "implementer" "both" $lang $locale
        translate "dhis2_android_implementation_guideline" "implementer" "both" $lang $locale
        translate "dhis2_android_capture_app" "android-app" "both" $lang $locale
        translate "dhis2_android_MDM" "mdm" "both" $lang $locale
        translate "user_stories_book" "user-stories" "both" $lang $locale

        echo "    - Developer:" >> $myml
        translate "dhis2_developer_manual" "developer" "both" $lang $locale
        echo "        DHIS2 API Javadocs: https://docs.dhis2.org/<version>/javadoc/" >> $myml
        translate "dhis2_android_sdk_developer_guide" "android-sdk" "both" $lang $locale

        echo "    - Sysadmin:" >> $myml
        translate "dhis2_system_administration_guide" "sysadmin" "both" $lang $locale

        echo "    - Metadata:" >> $myml
        translate "dhis2_who_digital_health_data_toolkit" "metadata" "both" $lang $locale
        translate "dhis2_COD" "packages" "both" $lang $locale
        translate "dhis2_covid19_surveillance" "packages" "both" $lang $locale
        translate "dhis2_IDSR" "packages" "both" $lang $locale
        translate "dhis2_immunisation" "packages" "both" $lang $locale
        translate "dhis2_malaria" "packages" "both" $lang $locale
        translate "dhis2_RMNCAH" "packages" "both" $lang $locale
        translate "dhis2_tb_surveillance" "packages" "both" $lang $locale


        make_mkdocs

        translate "dhis2_draft_chapters" "draft" "both" $lang $locale

    done
fi

# rm -rf $TMPBASE
