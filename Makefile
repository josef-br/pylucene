
# Makefile for building PyLucene
#
# Supported operating systems: Mac OS X, Linux and Windows.
# See INSTALL file for requirements.
# See jcc/INSTALL for information about --shared.
# 
# Steps to build
#   1. Edit the sections below as documented
#   2. Edit the JARS variable to add optional contrib modules not defaulted
#   3. make
#   4. make install
#
# The install target installs the lucene python extension in python's
# site-packages directory.
#

### NOTICE: This file has been heavily adapted from its original implementation https://www.apache.org/dyn/closer.lua/lucene/pylucene/

VERSION=9.4.1
LUCENE_VER=9.4.1
PYLUCENE:=$(shell pwd)
LUCENE_SRC=pylucene
LUCENE=$(LUCENE_SRC)/target

# 
# You need to uncomment and edit the variables below in the section
# corresponding to your operating system.
#
# Windows drive-absolute paths need to be expressed cygwin style.
#
# PREFIX: where programs are normally installed on your system (Unix).
# PREFIX_PYTHON: where your version of python is installed.
# JCC: how jcc is invoked, depending on the python version:
#  - python 3.x:
#      $(PYTHON) -m jcc
#  - python 2.7:
#      $(PYTHON) -m jcc
#  - python 2.6:
#      $(PYTHON) -m jcc.__main__
#  - python 2.5:
#      $(PYTHON) -m jcc
#  - python 2.4:
#      $(PYTHON) $(PREFIX_PYTHON)/lib/python2.4/site-packages/jcc/__main__.py
# NUM_FILES is the number of wrapper files to generate. By default, jcc
# generates all C++ classes into one single file. This may exceed a compiler
# limit.
#

# M2 Mac OS X 12.6 (64-bit intel Python 3.11, Java 17)
#PREFIX_PYTHON=/home/josef/workspace/ma-experiments/tmp/venv
#PYTHON=$(PREFIX_PYTHON)/bin/python
#JCC=$(PYTHON) -m jcc --shared --arch aarch64 --wheel
#NUM_FILES=16

# Linux     (Debian Bullseye 64-bit, Python 3.9.2, Temurin Java 17
PYTHON=python # just assume that the calling environment is correct
JCC=$(PYTHON) -m jcc --shared
NUM_FILES=16

# Mac OS X 11.4 (64-bit Python 2.7, Java 17)
#PREFIX_PYTHON=/Users/vajda/apache/pylucene/_install2
#PYTHON=$(PREFIX_PYTHON)/bin/python
#JCC=$(PYTHON) -m jcc.__main__ --shared --arch x86_64
#NUM_FILES=16

# Linux     (Debian Jessie 64-bit, Python 2.7.9, Oracle Java 1.8
#PREFIX_PYTHON=/opt/apache/pylucene/_install
#PYTHON=$(PREFIX_PYTHON)/bin/python
#JCC=$(PYTHON) -m jcc --shared
#NUM_FILES=16

# FreeBSD
#PREFIX_PYTHON=/usr
#PYTHON=$(PREFIX_PYTHON)/bin/python
#JCC=$(PYTHON) -m jcc
#NUM_FILES=16

# Windows   (Win32, Python 2.7, Java 1.6, ant 1.8.1, Java not on PATH)
#PREFIX_PYTHON=/cygdrive/c/Python27
#PYTHON=$(PREFIX_PYTHON)/python.exe
#JCC=$(PYTHON) -m jcc --shared --find-jvm-dll client
#NUM_FILES=16

JARS=$(LUCENE_JAR)

# comment/uncomment the desired/undesired optional contrib modules below
JARS+=$(ANALYSIS_JAR)           # many language analyzers
JARS+=$(BACKWARD_CODECS_JAR)    # backward codecs
JARS+=$(CLASSIFICATION_JAR)     # classification module
JARS+=$(CODECS_JAR)             # codecs
JARS+=$(EXPRESSIONS_JAR)        # expressions module
JARS+=$(EXTENSIONS_JAR)         # python extensions module, needs highlighter
JARS+=$(FACET_JAR)              # facet module
JARS+=$(GROUPING_JAR)           # grouping module
JARS+=$(HIGHLIGHTER_JAR)        # highlighter module, needs memory contrib
JARS+=$(JOIN_JAR)               # join module
JARS+=$(KUROMOJI_JAR)           # japanese analyzer module
JARS+=$(MEMORY_JAR)             # single-document memory index
JARS+=$(MISC_JAR)               # misc
JARS+=$(MORFOLOGIK_JAR)         # morfologik analyzer module
JARS+=$(NORI_JAR)               # korean analyzer module
#JARS+=$(PHONETIC_JAR)           # phonetic analyzer module
JARS+=$(QUERIES_JAR)            # regex and other contrib queries
JARS+=$(QUERYPARSER_JAR)        # query parsers
JARS+=$(SANDBOX_JAR)            # needed by query parser
#JARS+=$(SMARTCN_JAR)            # smart chinese analyzer
JARS+=$(SPATIAL3D_JAR)          # spatial3d lucene
#JARS+=$(SPATIAL_EXTRAS_JAR)     # spatial-extras
JARS+=$(STEMPEL_JAR)            # polish analyzer and stemmer
JARS+=$(SUGGEST_JAR)            # suggest/spell module


#
# No edits required below
#

ifeq ($(DEBUG),1)
  DEBUG_OPT=--debug
endif

DEFINES=-DPYLUCENE_VER="\"$(VERSION)\"" -DLUCENE_VER="\"$(LUCENE_VER)\""

LUCENE_JAR=$(LUCENE)/lucene-core.jar

ANALYSIS_JAR=$(LUCENE)/lucene-analysis-common.jar
BACKWARD_CODECS_JAR=$(LUCENE)/lucene-backward-codecs.jar
CLASSIFICATION_JAR=$(LUCENE)/lucene-classification.jar
CODECS_JAR=$(LUCENE)/lucene-codecs.jar
EXPRESSIONS_JAR=$(LUCENE)/lucene-expressions.jar
EXTENSIONS_JAR=$(LUCENE)/pylucene-extensions-9.4.1.jar
FACET_JAR=$(LUCENE)/lucene-facet.jar
GROUPING_JAR=$(LUCENE)/lucene-grouping.jar
HIGHLIGHTER_JAR=$(LUCENE)/lucene-highlighter.jar
JOIN_JAR=$(LUCENE)/lucene-join.jar
KUROMOJI_JAR=$(LUCENE)/lucene-analysis-kuromoji.jar
MEMORY_JAR=$(LUCENE)/lucene-memory.jar
MISC_JAR=$(LUCENE)/lucene-misc.jar
NORI_JAR=$(LUCENE)/lucene-analysis-nori.jar
PHONETIC_JAR=$(LUCENE)/lucene-analysis-phonetic.jar
QUERIES_JAR=$(LUCENE)/lucene-queries.jar
QUERYPARSER_JAR=$(LUCENE)/lucene-queryparser.jar
SANDBOX_JAR=$(LUCENE)/lucene-sandbox.jar
SMARTCN_JAR=$(LUCENE)/lucene-analysis-smartcn.jar
SPATIAL3D_JAR=$(LUCENE)/lucene-spatial3d.jar
SPATIAL_EXTRAS_JAR=$(LUCENE)/lucene-spatial-extras.jar
STEMPEL_JAR=$(LUCENE)/lucene-analysis-stempel.jar
SUGGEST_JAR=$(LUCENE)/lucene-suggest.jar

ANTLR_JAR=$(LUCENE)/antlr4-runtime.jar
ASM_JAR=$(LUCENE)/asm.jar
ASM_COMMONS_JAR=$(LUCENE)/asm-commons.jar
HPPC_JAR=$(LUCENE)/hppc.jar

ICUPKG:=$(shell which icupkg)

.PHONY: generate compile install default all clean realclean \
	sources lucene test jars distrib now

default: all


sources: $(LUCENE_SRC)

lucene:
	(cd $(LUCENE_SRC); mvn clean package)


JCCFLAGS?=

jars: $(JARS) $(ANTLR_JAR) $(ASM_JAR) $(ASM_COMMONS) $(HPPC_JAR)


ifneq ($(ICUPKG),)

ICURES= $(LUCENE)/resources
RESOURCES=--resources $(ICURES)

ifneq ($(PYTHON),)
ENDIANNESS:=$(shell $(PYTHON) -c "import struct; print(struct.pack('h', 1) == '\000\001' and 'b' or 'l')")
endif

resources: $(ICURES)/org/apache/lucene/analysis/icu/utr30.dat

$(ICURES)/org/apache/lucene/analysis/icu/utr30.dat: $(ICURES)/org/apache/lucene/analysis/icu/utr30.nrm
	rm -f $@
	cd $(dir $<); $(ICUPKG) --type $(ENDIANNESS) --add $(notdir $<) new $(notdir $@)

else

RESOURCES=

resources:
	@echo ICU not installed

endif

GENERATE=$(JCC) $(foreach jar,$(JARS),--jar $(jar)) \
           $(JCCFLAGS) --use_full_names \
           --include $(ANTLR_JAR) \
           --include $(ASM_JAR) \
           --include $(ASM_COMMONS_JAR) \
           --include $(HPPC_JAR) \
           --package java.lang java.lang.System \
                               java.lang.Runtime \
           --package java.util java.util.Arrays \
                               java.util.Collections \
                               java.util.HashMap \
                               java.util.HashSet \
                               java.util.TreeSet \
                               java.lang.IllegalStateException \
                               java.lang.IndexOutOfBoundsException \
                               java.util.NoSuchElementException \
                     java.text.SimpleDateFormat \
                     java.text.DecimalFormat \
                     java.text.Collator \
           --package java.util.concurrent java.util.concurrent.Executors \
           --package java.util.function \
           --package java.util.regex \
           --package java.io java.io.StringReader \
           --package java.nio.file java.nio.file.Path \
                                   java.nio.file.Files \
                                   java.nio.file.Paths \
           --package org.antlr.v4.runtime \
           --package org.antlr.v4.runtime.atn \
           --exclude org.apache.lucene.sandbox.queries.regex.JakartaRegexpCapabilities \
           --exclude org.apache.regexp.RegexpTunnel \
           --exclude org.apache.lucene.misc.store.WindowsDirectory \
           --exclude org.apache.lucene.misc.store.NativePosixUtil \
           --exclude 'module-info' \
           --python lucene \
           --mapping org.apache.lucene.document.Document 'get:(Ljava/lang/String;)Ljava/lang/String;' \
           --mapping java.util.Properties 'getProperty:(Ljava/lang/String;)Ljava/lang/String;' \
           --sequence java.util.AbstractCollection 'size:()I' '-:-' \
           --sequence java.util.AbstractList '-:-' 'get:(I)Ljava/lang/Object;' \
           org.apache.lucene.index.IndexWriter:getReader \
           org.apache.lucene.analysis.Tokenizer:input \
           --version $(LUCENE_VER) \
           --module python/collections.py \
           --module python/ICUNormalizer2Filter.py \
           --module python/ICUFoldingFilter.py \
           --module python/ICUTransformFilter.py \
           $(RESOURCES) \
           --files $(NUM_FILES)

generate: jars
	$(GENERATE)

compile: jars resources
	$(GENERATE) --build $(DEBUG_OPT)

install: jars
	$(GENERATE) --install $(DEBUG_OPT) $(INSTALL_OPT)

now:
	$(GENERATE) --build --install --debug

bdist: jars
	$(GENERATE) --bdist

wininst: jars
	$(GENERATE) --wininst

all: sources lucene jars resources compile
	@echo build of pylucene $(LUCENE_VER) complete

clean:
	(cd $(LUCENE_SRC); mvn clean)

realclean:
	rm -rf $(LUCENE_SRC) lucene.egg-info
	rm -rf build

OS=$(shell uname)
BUILD_TEST:=$(PYLUCENE)/build/test

ifeq ($(findstring CYGWIN,$(OS)),CYGWIN)
  BUILD_TEST:=`cygpath -aw $(BUILD_TEST)`
else
  ifeq ($(findstring MINGW,$(OS)),MINGW)
    BUILD_TEST:=`$(PYTHON) -c "import os, sys; print(os.path.normpath(sys.argv[1]).replace(chr(92), chr(92)*2))" $(BUILD_TEST)`
  endif
endif

TEST_DIR:=`$(PYTHON) -c "import sys; print('test%s' %(sys.version_info[0]))"`

test: install
	find $(TEST_DIR) -name 'test_*.py' | xargs -t -n 1 $(PYTHON)

ARCHIVE=pylucene-$(VERSION)-src.tar.gz

distrib:
	mkdir -p distrib
	/opt/local/bin/svn export --force . distrib/pylucene-$(VERSION)
	tar -cf - --disable-copyfile --exclude build --exclude gradle.properties --exclude '.[a-z]*' `find $(LUCENE_SRC) -type l | xargs -n 1 echo --exclude` $(LUCENE_SRC) | tar -C distrib/pylucene-$(VERSION) -xvf -
	cd distrib; tar --disable-copyfile -cvzf $(ARCHIVE) pylucene-$(VERSION)
	cd distrib; /opt/local/bin/gpg --armor --output $(ARCHIVE).asc --detach-sig $(ARCHIVE)
	cd distrib; shasum -a 256 $(ARCHIVE) > $(ARCHIVE).sha256

stage:
	cd distrib; cp -p $(ARCHIVE) $(ARCHIVE).asc $(ARCHIVE).sha256 ../../dist/dev/pylucene/

print-%:
	@echo $* = $($*)
