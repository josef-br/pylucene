# Pylucene
> No idea how the licensing stuff works... Just read this

This is a modified distribution of [PyLucene](https://lucene.apache.org/pylucene/index.html).
The original sources were downloaded from [here](https://www.apache.org/dyn/closer.lua/lucene/pylucene/) (Version 9.4.1)

The most notable adaptations are:
- The original source contains all the source files of the lucene packages. Instead, the directory `pylucene` contains a maven project that loads the precompiled .jar-Files from an official maven repository.
- The original defined custom code in the directory `extensions`. These were modev to the directory `pylucene` and are part of the maven project. The .jar file is built via `mvn package` (This command also downloads the .jars for all other dependencies)
- The `Makefile` was adapted to match the adjustments. Also it is fixed to a linus environment (I resent developing in Windows).