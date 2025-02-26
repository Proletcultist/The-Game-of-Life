all: ./bin/out.img

./bin/out.img: ./src/main.asm ./src/handlers.asm ./src/IVT.asm
	cocas -o ./bin/out.img ./src/main.asm ./src/handlers.asm ./src/IVT.asm

clear:
	rm ./bin/*
