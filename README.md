# Pylucene

This is a modified distribution of [PyLucene](https://lucene.apache.org/pylucene/index.html).
The original sources were downloaded from [here](https://www.apache.org/dyn/closer.lua/lucene/pylucene/) (Version 9.4.1)

The most notable adaptations are:
- The original source contains all the source files of the lucene packages. Instead, here the directory `pylucene` contains a maven project that loads the precompiled .jar-Files from an official maven repository.
- The original version defines custom code in the directory `extensions`. Here these custom code files were moved to the directory `pylucene` and are part of the maven project. The .jar file is built via `mvn package` (This command also downloads the .jars for all other dependencies)
- The `Makefile` was adapted to match the adjustments. Also it is fixed to a linux environment (I resent developing in Windows).

To install this you need the [Temurin JDK](https://adoptium.net/de/). Download it, store it somewhere and make sure that the name `temurin` is actually contained in the directory name. Set the environment variable `JCC_JDK` to the location of this directory. Then run the installation scripts:

```bash
export JCC_JDK=/path/to/temurin-jdk

cd jcc
python setup.py build
python setup.py install

cd ..

make
make test
make install
```
