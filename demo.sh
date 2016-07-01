#!/bin/bash
#
#database name
#repository
#module name

echo "Enter repository name:"
#read repoPath
repoPath=http://products.git.devoffice.com/magento/magento2-read-only.git

repo=${repoPath#http://}
repo=${repo%.git}
repoName=${repo##*/}

echo "*** Repository name: $repoName"

if [ ! -d "$repoName" ]; then
    git clone $repoPath $repoName
    cd $repoName
    ver=$(git describe --tags)
    ver=${ver#v}
    echo $ver
    cd ../ #exit to root
    rm -Rf $repoName/.git
fi

echo "Enter module name:"
#read moduleName
moduleName=ReadOnly

tmpDirSuffix='__tmp'
tmpDir=$repoName$tmpDirSuffix
codeDir="/granter/app/code/TemplateMonster/"

# mysql -u root -e "DROP DATABASE IF EXISTS demo"
# mysql -u root -e "CREATE DATABASE demo"

echo "*** Building files structure"

mkdir -p $tmpDir
mkdir -p $tmpDir/granter/app/code/TemplateMonster/$moduleName
mkdir -p $tmpDir/marketplace

echo "*** Copying module files"

cp -R -v $repoName/* $tmpDir/granter/app/code/TemplateMonster/$moduleName/
cp -R -v $repoName/* $tmpDir/marketplace

echo "*** Preparing marketplace archive"

cd $tmpDir/marketplace
zip -r ../../marketplace_TemplateMonster_$moduleName_$ver.zip .
cd ../ #exit to __tmp dir


echo "*** Preparing granter archive"

cd granter/
zip -r ../../granter_TemplateMonster_$moduleName_$ver.zip .
cd ../../ #exit to root

echo "*** Removing directories"
rm -Rf $repoName
rm -Rf $tmpDir

read