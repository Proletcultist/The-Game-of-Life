main: ./bin/out.img
sample: ./bin/sample.img

./bin/main.img: ./src/main.asm ./src/handlers.asm ./src/IVT.asm
	cocas -o ./bin/out.img ./src/main.asm ./src/handlers.asm ./src/IVT.asm

./bin/sample.img: ./src/sample.asm ./src/handlers.asm ./src/IVT.asm
	cocas -o ./bin/sample.img ./src/handlers.asm ./src/IVT.asm ./src/sample.asm

clear:
	rm ./bin/*
