.PHONY: all clean

CFLAGS += \
	-O2 -funroll-loops \
	-std=c89 -Wall -Wextra \
	-DCL_TEST_REGION_SIZE=0x4000 \
	-DCL_SEARCH_CHUNK_SIZE=0x400

SRC_DIR = .
BUILD_DIR = build

include $(N64_INST)/include/n64.mk
include classicslive-integration/classicslive-integration.mk

src = \
	main.c \
	CLASSICS_LIVE_SOURCES \

$(BUILD_DIR)/classicslive-ultra-test.elf: $(src:%.c=$(BUILD_DIR)/%.o)

# Get the current git version
GIT_VERSION := $(shell git rev-parse --short=8 HEAD)

# Define the N64 ROM title with the git version
N64_ROM_TITLE_WITH_VERSION := "CLUT $(GIT_VERSION)"

classicslive-ultra-test.z64: N64_ROM_TITLE = $(N64_ROM_TITLE_WITH_VERSION)
classicslive-ultra-test.z64: $(BUILD_DIR)/classicslive-ultra-test.dfs

clean:
	rm -rf $(BUILD_DIR) *.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: clean
