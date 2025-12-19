.PHONY: all clean

all: classicslive-ultra-test.z64

CFLAGS += \
	-O2 -funroll-loops \
	-std=c89 -Wall -Wextra \
	-DCL_TEST_REGION_SIZE=0x80000 \
	-DCL_SEARCH_CHUNK_SIZE=0x4000 \
	-DCL_TESTS=1 \
	-DCL_URL_HOSTNAME=\"fake-website\" \
	-Ilibretro-common/include

CL_OMIT_VFS := 1

SRC_DIR = .
BUILD_DIR = build

CFLAGS += -Wno-error
CPPFLAGS += -Wno-error

CLASSICS_LIVE_DIR = classicslive-integration

include classicslive-integration/classicslive-integration.mk
include $(N64_INST)/include/n64.mk

src = \
	main.c \
	classicslive-integration/cl_test.c \
	$(CLASSICS_LIVE_SOURCES)

$(BUILD_DIR)/classicslive-ultra-test.elf: $(src:%.c=$(BUILD_DIR)/%.o)

# Get the current git version
GIT_VERSION := $(shell git rev-parse --short=8 HEAD)

# Define the N64 ROM title with the git version
N64_ROM_TITLE_WITH_VERSION := "CLUT $(GIT_VERSION)"

classicslive-ultra-test.z64: N64_ROM_TITLE = $(N64_ROM_TITLE_WITH_VERSION)
classicslive-ultra-test.z64: $(BUILD_DIR)/classicslive-ultra-test.dfs

clean:
	rm -rf $(BUILD_DIR) *.z64
	find . -name '*.o' -delete
	find . -name '*.a' -delete

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: clean
