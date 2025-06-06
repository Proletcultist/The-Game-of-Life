BIN_DIR = ./bin
LIB_DIR = $(BIN_DIR)/libs
SRC_DIR = ./src
DBG_DIR = ./debug
MACROS_DIR = $(SRC_DIR)/macro

TESTS_BIN_DIR = $(BIN_DIR)/Tests
TESTS_SRC_DIR = $(SRC_DIR)/Tests

ASS_INCLUDE = -I ./src/headers

MACROS = $(wildcard $(MACROS_DIR)/*.mlb)

TESTS_SOURCES = $(notdir $(wildcard $(TESTS_SRC_DIR)/*))
LIB_NAMES = matrixLib parserLib uartLib core mathLib strLiterals
LIBS = $(addprefix $(LIB_DIR)/, $(addsuffix .lib, $(LIB_NAMES)))

main: $(BIN_DIR)/main.img
libs: $(LIBS)
tests: $(addprefix $(TESTS_BIN_DIR)/, $(patsubst %.asm, %.img, $(TESTS_SOURCES)))
all: libs main tests

# TODO: Create generic rules for libs (% doesn't work idk why)
$(LIB_DIR)/matrixLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/matrixLib/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^
$(LIB_DIR)/parserLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/parserLib/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^
$(LIB_DIR)/uartLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/uartLib/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^
$(LIB_DIR)/core.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/core/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^
$(LIB_DIR)/mathLib.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/mathLib/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^
$(LIB_DIR)/strLiterals.lib: $(addsuffix .obj, $(basename $(wildcard $(SRC_DIR)/strLiterals/*.asm))) | $(LIB_DIR)
	@echo "Merging object files: \033[36;1m$(notdir $^)\033[0m into \033[36;1m$(notdir $@)\033[0m"
	@cocas -m -o $@ $^


%.debug: $(TESTS_SRC_DIR)/%.asm $(wildcard $(addprefix $(SRC_DIR)/, $(addsuffix /*.asm, $(LIB_NAMES)))) $(MACROS) $(TEMP_FILES) | $(LIB_DIR) $(TESTS_BIN_DIR) $(DBG_DIR)
	@echo "Building debug version of \033[36;1m$*\033[0m test"
	@cocas $(ASS_INCLUDE) -o $(TESTS_BIN_DIR)/$*.img --debug $(DBG_DIR)/$*.dbg.json $^ 

$(TESTS_BIN_DIR)/%.img: $(TESTS_SRC_DIR)/%.asm $(LIBS) $(MACROS) $(TEMP_FILES) | $(TESTS_BIN_DIR)
	@echo "Building \033[36;1m$(notdir $@)\033[0m"
	@cocas $(ASS_INCLUDE) -o $@ $^

$(BIN_DIR)/main.img: $(SRC_DIR)/main.asm $(LIBS) $(MACROS) $(TEMP_FILES) | $(BIN_DIR)
	@echo "Building \033[36;1mmain.img\033[0m"
	@cocas $(ASS_INCLUDE) -o $@ $^

%.obj: %.asm $(MACROS)
	@echo "Assembling \033[36;1m$(patsubst %.obj, %.asm, $(notdir $@))\033[0m"
	@cocas $(ASS_INCLUDE) -c -o $@ $^ 

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(TESTS_BIN_DIR):
	@mkdir -p $(TESTS_BIN_DIR)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

$(DBG_DIR):
	@mkdir -p $(DBG_DIR)

clean:
	@rm -f $(BIN_DIR)/*.img
	@rm -f $(TESTS_BIN_DIR)/*.img
	@rm -f $(LIB_DIR)/*.lib
	@rm -f $(DBG_DIR)/*.dbg.json
	@find . -name "*.obj" -type f -delete
	@echo "Cleaned"
