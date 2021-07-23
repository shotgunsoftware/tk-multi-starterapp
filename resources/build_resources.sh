#!/usr/bin/env bash
#
# Copyright (c) 2013 Shotgun Software Inc.
#
# CONFIDENTIAL AND PROPRIETARY
#
# This work is provided "AS IS" and subject to the Shotgun Pipeline Toolkit
# Source Code License included in this distribution package. See LICENSE.
# By accessing, using, copying or modifying this work you indicate your
# agreement to the Shotgun Pipeline Toolkit Source Code License. All rights
# not expressly granted therein are reserved by Shotgun Software Inc.

# The path to output all built .py files to:
UI_PYTHON_PATH=../python/app/ui


# Helper functions to build UI files
function build_qt {
    echo " > Building " $2

    # compile ui to python
    $1 $2 > $UI_PYTHON_PATH/$3.py

    # replace PySide imports with tank.platform.qt and remove line containing Created by date
    sed -i -e "s/PySide2.QtCore/tank.platform.qt.QtCore/g" -e "s/PySide2.QtGui/tank.platform.qt.QtGui/g" $UI_PYTHON_PATH/$3.py
    sed -i -e "13,15d" $UI_PYTHON_PATH/$3.py
}

function build_qt_res {
    echo " > Building " $2

    # compile ui to python
    $1 $2 > $UI_PYTHON_PATH/$3.py

    # replace PySide imports with tank.platform.qt and remove line containing Created by date
    sed -i -e "s/PySide2/tank.platform.qt/g" $UI_PYTHON_PATH/$3.py
    
}

function build_ui {
    build_qt "pyside2-uic --from-imports" "$1.ui" "$1"
}

function build_res {
    build_qt_res "pyside2-rcc" "$1.qrc" "$1_rc"
}


# build UI's:
echo "building user interfaces..."
build_ui dialog
# add any additional .ui files you want converted here!

# build resources
echo "building resources..."
build_res resources

read
