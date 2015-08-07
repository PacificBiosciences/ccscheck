#!/bin/sh
rm -rf build; mkdir build
cd build

### Build Bio dependency
git clone https://github.com/dotnetbio/bio.git
cd bio
nuget restore src/Bio.Mono.sln
xbuild /p:Configuration=Release src/Bio.Mono.sln
cp src/Source/Framework/Bio.Desktop/bin/Release/* ../
cp src/Source/Framework/Shims/Bio.Platform.Helpers.Desktop/bin/Release/Bio.Platform.Helpers.* ../
cd ..
rm -rf bio/


## Build BWA Sharp dependency
git clone https://github.com/evolvedmicrobe/BWA-Sharp.git
cd BWA-Sharp
make
cp build/Bio.BWA.dll ../
cp build/libbwacsharp.so ../
cd ../
rm -rf BWA-Sharp

# Now make a bundled executable
cd ..
cp build/* lib/
xbuild /p:Configuration=Release src/ccscheck.sln
mv src/bin/Release/* build/
cd build
python ../makeExecutable.py
rm temp.*
cd ../
rm -rf bin; mkdir bin
cp build/ccscheck bin/
cp build/libbwacsharp.so bin/
#rm -rf build/

