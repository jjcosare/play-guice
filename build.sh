#!/bin/bash
ORGANIZATION="play-guice"
MODULE="guice"
VERSION=`grep self conf/dependencies.yml | sed "s/.*$MODULE //"`
DESTINATION=/var/www/repo/$ORGANIZATION
TARGET=$DESTINATION/$MODULE-$VERSION.zip

rm -fr dist
play dependencies --sync || exit $?
play build-module || exit $?

if [ -d $DESTINATION ]; then
  if [ -e $TARGET ]; then
      echo "Not publishing, $MODULE-$VERSION already exists"
  else
      cp dist/*.zip $TARGET
      echo "Package is available at https://repo.codeborne.com/$ORGANIZATION/$MODULE-$VERSION.zip"
  fi
fi
