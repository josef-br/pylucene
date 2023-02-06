export JCC_JDK=~/.local/lib/jvm/temurin-jdk-17.0.6

pushd jcc
python setup.py build
python setup.py install

popd

make
make test
make install