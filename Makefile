BIN_DIR = ./bin
SRC_DIR = ./src

main: $(BIN_DIR)/main.img
sample: $(BIN_DIR)/sample.img
all: main sample

$(BIN_DIR)/main.img: $(SRC_DIR)/main.asm $(SRC_DIR)/handlers.asm $(SRC_DIR)/IVT.asm $(SRC_DIR)/matrixDriver.asm | $(BIN_DIR)
	cocas -o $@ $^

$(BIN_DIR)/sample.img: $(SRC_DIR)/sample.asm $(SRC_DIR)/handlers.asm $(SRC_DIR)/IVT.asm $(SRC_DIR)/matrixDriver.asm | $(BIN_DIR)
	cocas -o $@ $^

$(BIN_DIR):
	mkdir ./bin

clean: | $(BIN_DIR)
	rm -f $(BIN_DIR)/*
