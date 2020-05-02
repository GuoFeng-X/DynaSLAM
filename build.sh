echo "============================================"
echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
rm build -rf
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j  3

echo "============================================"
echo "Configuring and building Thirdparty/g2o ..."
cd ../../g2o
rm build -rf
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j 3

echo "============================================"
cd ../../../
echo "Uncompress vocabulary ..."

cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "============================================"
echo "Configuring and building DynaSLAM ..."

rm build -rf
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j 3

