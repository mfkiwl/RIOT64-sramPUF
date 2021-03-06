.PHONY: buildtest

BUILDTEST_MAKE_REDIRECT ?= >/dev/null 2>&1
BUILDTEST_MAKE_TARGET ?= clean all
BUILDTEST_CLEAN ?= $(MAKE) clean-intermediates

ifdef BUILDTEST_NPROC
  NPROC = $(BUILDTEST_NPROC)
endif

ifeq ($(BUILD_IN_DOCKER),1)
buildtest: ..in-docker-container
else
buildtest:
	@ \
	RESULT=true ; \
	for board in $(BOARDS); do \
		if BOARD=$${board} $(MAKE) check-toolchain-supported > /dev/null 2>&1; then \
			$(COLOR_ECHO) -n "Building for $$board ... " ; \
			BOARD=$${board} RIOT_CI_BUILD=1 RIOT_VERSION_OVERRIDE=buildtest \
				$(MAKE) $(BUILDTEST_MAKE_TARGET) -j $(NPROC) $(BUILDTEST_MAKE_REDIRECT); \
			RES=$$? ; \
			if [ $$RES -eq 0 ]; then \
				$(COLOR_ECHO) "$(COLOR_GREEN)success.$(COLOR_RESET)" ; \
			else \
				$(COLOR_ECHO) "$(COLOR_RED)failed!$(COLOR_RESET)" ; \
				RESULT=false ; \
			fi ; \
			BOARD=$${board} $(BUILDTEST_CLEAN) >/dev/null 2>&1 || true; \
		fi; \
	done ; \
	$${RESULT}
endif # BUILD_IN_DOCKER
