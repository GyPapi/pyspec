#!/bin/bash
PYSPEC=pyspec
PYTHON=`which python`
DIST=pyspec-0.2
CWD=`pwd`
function upload_package {	
cd $PYSPEC

if [ -d "dist" ]; then
	echo "*** Removing dist directory ***"
	rm -rf dist
fi

if [ -e "setup.cfg" ]; then
	mv setup.cfg setup.cfg.insttmp
fi

$PYTHON setup.py build_sphinx upload_sphinx
$PYTHON setup.py sdist --formats=gztar,zip upload
scp dist/* stuwilkins,pyspec@frs.sourceforge.net:/home/frs/project/p/py/pyspec/$DIST

if [ -e "setup.cfg.inst" ]; then
	mv setup.cfg.inst setup.cfg
fi

}

function upload_docs {
	cd $CWD
	scp -r $PYSPEC/doc/_build/html/* stuwilkins,pyspec@web.sourceforge.net:/home/groups/p/py/pyspec/htdocs
}

upload_package