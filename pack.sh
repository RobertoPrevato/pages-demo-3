#! /bin/bash
folders=(
    one
    two
    three
)

rm -rf site
rm -rf ./site.zip
mkdir -p site

for folder in "${folders[@]}" ; do
    echo "$folder 🏗️"
    mkdir site/$folder

    cd $folder

    GIT_CONTRIBS_ON=True mkdocs build

    mv site/* ../site/$folder
    rm -rf site
    cd ../
done

# The home is special...
echo "home"
cd home
mkdocs build
mv site/* ../site/
rm -rf site
cd ../

echo "All done! ✨ 🍰 ✨"
