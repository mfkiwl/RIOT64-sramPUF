include ../Makefile.tests_common

BOARD_INSUFFICIENT_MEMORY := arduino-duemilanove \
                             arduino-uno \
                             arduino-mega2560 \
                             arduino-nano \
                             mega-xplained \
                             nucleo-f031k6 \
                             nucleo-f042k6 \
                             #

TEST_ON_CI_WHITELIST += native native64

CFLAGS += -DTHREAD_STACKSIZE_MAIN=\(5*THREAD_STACKSIZE_DEFAULT\)

USEPKG += tweetnacl
USEMODULE += embunit

include $(RIOTBASE)/Makefile.include
