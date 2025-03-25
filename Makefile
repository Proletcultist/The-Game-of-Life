BIN_DIR = ./bin
SRC_DIR = ./src

TESTS_BIN_DIR = ./bin/Tests
TESTS_SRC_DIR = ./src/Tests

CORE_SOURCES = start.asm handlers.asm IVT.asm matrixDriver.asm
TESTS_SOURCES = $(notdir $(wildcard $(TESTS_SRC_DIR)/*))

main: $(BIN_DIR)/main.img
tests: $(addprefix $(TESTS_BIN_DIR)/, $(patsubst %.asm, %.img, $(TESTS_SOURCES)))
all: main tests

$(TESTS_BIN_DIR)/%.img: $(addprefix $(SRC_DIR)/, $(CORE_SOURCES)) $(TESTS_SRC_DIR)/%.asm | $(TESTS_BIN_DIR)
	cocas -o $@ $^	

$(BIN_DIR)/main.img: $(SRC_DIR)/main.asm $(addprefix $(SRC_DIR)/, $(CORE_SOURCES)) | $(BIN_DIR)
	cocas -o $@ $^

$(BIN_DIR):
	mkdir ./bin

$(TESTS_BIN_DIR): | $(BIN_DIR)
	mkdir ./bin/Tests

clean: | $(BIN_DIR)
	rm -f $(BIN_DIR)/*.img
	rm -f $(TESTS_BIN_DIR)/*.img
