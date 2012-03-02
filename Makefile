#
# Copyright (c) 2012, Joyent, Inc. All rights reserved.
#
# Makefile: basic Makefile for template API service
#
# This Makefile is a template for new repos. It contains only repo-specific
# logic and uses included makefiles to supply common targets (javascriptlint,
# jsstyle, restdown, etc.), which are used by other repos as well. You may well
# need to rewrite most of this file, but you shouldn't need to touch the
# included makefiles.
#
# If you find yourself adding support for new targets that could be useful for
# other projects too, you should add these to the original versions of the
# included Makefiles (in eng.git) so that other teams can use them too.
#

#
# Tools
#
TAP		:= ./node_modules/.bin/tap

#
# Files
#
DOC_FILES	 = index.restdown boilerplateapi.restdown
JS_FILES	:= $(shell ls *.js) $(shell find lib test -name '*.js')
JSL_CONF_NODE	 = tools/jsl.node.conf
JSL_FILES_NODE   = $(JS_FILES)
JSSTYLE_FILES	 = $(JS_FILES)
JSSTYLE_FLAGS    = -o indent=4,doxygen,unparenthesized-return=0
SMF_MANIFESTS_IN = smf/manifests/bapi.xml.in

include ./Makefile.defs
include ./Makefile.node.defs
include ./Makefile.smf.defs

#
# Repo-specific targets
#
.PHONY: all
all: $(SMF_MANIFESTS) | $(TAP)
	$(NPM) rebuild

$(TAP): | $(NPM)
	$(NPM) install

.PHONY: test
test: $(TAP)
	TAP=1 $(TAP) test/*.test.js

include ./Makefile.deps
include ./Makefile.node.targ
include ./Makefile.smf.targ
include ./Makefile.targ
