#!/bin/sh

#  Move-And-Sign.sh
#  Clutch-SL
#
#  Created by SweetLoser on 2017/11/14.
#  Copyright © 2017年 SweetLoser. All rights reserved.


cd "$PROJECT_DIR"

#判断该目录下是否存在`build`目录，如果不存在，则用mkdir 创建
! [ -d build ] && mkdir build
echo "$BUILT_PRODUCTS_DIR"
cp -rf "$BUILT_PRODUCTS_DIR/$EXECUTABLE_PATH" "build/"
codesign -fs- --entitlements "$CODE_SIGN_ENTITLEMENTS" "build/$EXECUTABLE_NAME"
