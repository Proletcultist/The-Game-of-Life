BIN_DIR = ./bin
LIB_DIR = $(BIN_DIR)/libs
SRC_DIR = ./src
DBG_DIR = ./debug
MACROS_DIR = $(SRC_DIR)/macro

TESTS_BIN_DIR = $(BIN_DIR)/Tests
TESTS_SRC_DIR = $(SRC_DIR)/Tests

ASS_INCLUDE = -I ./src/headers

MACROS = $(wildcard $(MACROS_DIR)/*.mlb)

# TODO: Replace all temp files content to some libs
TEMP_FILES = $(SRC_DIR)/strLiterals.asm $(SRC_DIR)/handlers.asm $(SRC_DIR)/writer.asm

TESTS_SOURCES = $(notdir $(wildcard $(TESTS_SRC_DIR)/*))
LIB_NAMES = matrixLib parserLib core mathLib
LIBS = $(addprefix $(LIB_DIR)/, $(addsuffix .lib, $(LIB_NAMES)))

main: $(BIN_DIR)/main.img
libs: $(LIBS)
tests: $(addprefix $(TESTS_BIN_DIR)/, $(patsubst %.asm, %.img, $(TESTS_SOURCES)))
all: libs main tests

# TODO: Create generic rules for libs (% doesn't work idk why)
$(LIB_DIR)/matrixLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/matrixLib/*.asm))) | $(LIB_DIR)
	cocas -m -o $@ $^
$(LIB_DIR)/parserLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/parserLib/*.asm))) | $(LIB_DIR)
	cocas -m -o $@ $^
$(LIB_DIR)/core.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/core/*.asm))) | $(LIB_DIR)
	cocas -m -o $@ $^
$(LIB_DIR)/mathLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/mathLib/*.asm))) | $(LIB_DIR)
	cocas -m -o $@ $^


%.debug: $(TESTS_SRC_DIR)/%.asm $(wildcard $(addprefix $(SRC_DIR)/, $(addsuffix /*.asm, $(LIB_NAMES)))) $(MACROS) | $(LIB_DIR) $(TESTS_BIN_DIR) $(DBG_DIR)
	cocas $(ASS_INCLUDE) -o $(TESTS_BIN_DIR)/$*.img --debug $(DBG_DIR)/$*.dbg.json $^ $(TEMP_FILES)

$(TESTS_BIN_DIR)/%.img: $(TESTS_SRC_DIR)/%.asm $(LIBS) $(MACROS) | $(TESTS_BIN_DIR)
	cocas $(ASS_INCLUDE) -o $@ $^ $(TEMP_FILES)

$(BIN_DIR)/main.img: $(SRC_DIR)/main.asm $(LIBS) $(MACROS) | $(BIN_DIR)
	cocas $(ASS_INCLUDE) -o $@ $^ $(TEMP_FILES)

%.obj: %.asm $(MACROS)
	cocas $(ASS_INCLUDE) -c -o $@ $^ 

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(TESTS_BIN_DIR):
	mkdir -p $(TESTS_BIN_DIR)

$(LIB_DIR):
	mkdir -p $(LIB_DIR)

$(DBG_DIR):
	mkdir -p $(DBG_DIR)

clean:
	rm -f $(BIN_DIR)/*.img
	rm -f $(TESTS_BIN_DIR)/*.img
	rm -f $(LIB_DIR)/*.lib
	rm -f $(DBG_DIR)/*.dbg.json
	find . -name "*.obj" -type f -delete
