BIN_DIR = ./bin
SRC_DIR = ./src

all: $(BIN_DIR)/main.img $(BIN_DIR)/sample.img

$(BIN_DIR)/main.img: $(SRC_DIR)/main.asm $(SRC_DIR)/handlers.asm $(SRC_DIR)/IVT.asm $(SRC_DIR)/matrixDriver.asm | $(BIN_DIR)
	cocas -o $@ $^

$(BIN_DIR)/sample.img: $(SRC_DIR)/sample.asm $(SRC_DIR)/handlers.asm $(SRC_DIR)/IVT.asm $(SRC_DIR)/matrixDriver.asm | $(BIN_DIR)
	cocas -o $@ $^

clean:
	rm -f $(BIN_DIR)/*