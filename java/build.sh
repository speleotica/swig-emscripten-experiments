#!/usr/bin/env bash
UNITIZEDSRC="../unitized/src"
PKGDIR="src/main/java/org/speleotica/unitized"
CLASSESDIR="target/classes"
LIBDIR="target/lib"
OBJDIR="target/obj"

rm "${PKGDIR}"/*
mkdir -p "${PKGDIR}"
rm -rf "${LIBDIR}"
mkdir -p "${LIBDIR}"
rm -rf "${OBJDIR}"
mkdir -p "${OBJDIR}"
rm -rf "${CLASSESDIR}"
mkdir -p "${CLASSESDIR}"

swig -java -c++ -package org.speleotica.unitized -o "${PKGDIR}/unitized_wrap.cpp" "${UNITIZEDSRC}/unitized.i"
for file in $(cd "${UNITIZEDSRC}"; ls *.cpp); do
  g++ -g -fPIC -c "${UNITIZEDSRC}/${file}" -o "${OBJDIR}/${file%.*}.o"
done
g++ -g -fPIC -c "${PKGDIR}/unitized_wrap.cpp" "-I${JAVA_HOME}/include" "-I${JAVA_HOME}/include/darwin" "-I${UNITIZEDSRC}" -o "${OBJDIR}/unitized_wrap.o"
g++ -shared "${OBJDIR}"/*.o -o "${LIBDIR}/libunitized.jnilib"

shopt -s globstar

javac src/**/*.java -d "${CLASSESDIR}"