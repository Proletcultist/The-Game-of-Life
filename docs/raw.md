# General design

This project is a realization of Conways' Game Of Life, built on:
- CdM-16 as a konzertmeister of all work, language processor, which translates human-readable command lines from terminal to some instructions for theese devices (or prints an error to terminal with understandable explanation of an error).
- [UART](https://github.com/cdm-processors/logisim-uart) (and UART controller built around it) as a main way of communicating with external terminal for implementation of the CLI.
- Matrix controller as a device, that makes game work and implements a low-level interface for modification of rules, speed of game, game field and controling game flow (run game, pause it or make one itaration)

The core idea behind the division of responsibilities between CdM-16 and peripheral devices is ability of each peripheral device to work independatly, parallel to each other:
- Matrix controller can run game, while processor is always ready to receive and parse users' input without stopping the game, write an error, saying that processor cannot modify some part of game state while game is running, or actually modify some part of state, which can be modified anytime (like speed of game or pausing it).
- UART can receive and store data in its' own buffer without any actions from processor, independently, and hold it until processor read it.
# Hardware
## Memory mapped I/O
## Interrupt Arbiter
## Interrupt bus
## Matrix controller

Matrix controller consist of two main parts:
- Matrix buffer - main sequential unit, which stores current game field state and can be modified by processor or by game processor.
- Game processor - main combinatory unit, which calculates next field state based on current and on rules.
Other auxiliary devices, will be described later.
### Matrix buffer row

![](./pictures/bufferRow.png)

Here we have 32-bit register, holding state of one row of field and infrasctructure for modifying it and for reading its' data. 

This register is enabled only if this row is **selected** as a distination of writing act of processor or if the game is **running**. Reasons of it is obvious, we don't need to change anything when the game paused and if processor isn't writing to this row.

Act of writing to this register can be triggered by rising edge of **clock** (so it will be synchronized with processor) or by rising edge of **cc** (counter clock) either (so it will be synchronized with game processor).

Also, because two sources of new state of this row (processor and game processor) changes different amount of bits in state at time (processor changes only first or second 16 bits of state due to size of data bus, game processor can change all 32 bits at time) there is two inputs in this circuit:
- **Narrow in** - input from data bus of processor. This source is closed (by controlled buffer) when it's not needed (when there is no writing to this row from processor) same as **self** - current state of row, which needed for replacing one half of it while keeping another half unchanged (depends on **block** input, 0 - most significant bits, 1 - least significant bits).
- **Wide in** - input from game processor (new state of this row, calculated by game processor). This source goes straight to the multiplexer.
Which source of new state to use selects multiplexe in the west of register. It's disabled, when register is disabled, and when it's enabled, it select source by watching **sel** input, if **sel** is high, it's mean, that we need to take new state from processor, from **narrow in** combined with current state, when **sel** is low, we need to take new state from game processor, from **wide in**.

Respectively, in the east side of circuit we have two outputs:
- **Narrow out** - output to data bus of processor. Row will pass its' first or second half on this buss (depends on **block** again) if processor reads data from this row, otherwise it won't pass anything.
- **Wid out** - output to game processor. Row always pass its' current state to let game processor calculate its' new state if game is running.

Also, in the west side of circuit we can see, that some of inputs goes straight to output, named same as an input. This needed to pass some siggnals through all of rows, then they stay one above another (we will see it in next section).

This is how this circuit looks in other circuits:

![](./pictures/bufferRowAppearence.png)

Here we have all of described inputs and outputs labeled.
### Matrix buffer

![](./pictures/buffer.png)

Here we have 32 **matrix buffer rows**, connected with each other in one big block - matrix buffer. All **narrow ins** connected to one narrow in input in the south of circuit, which connected to data bus. Also, all **narrow outs** connected to one narrow out output, connected to data bus.

Where is decoder for selecting appropriate row by addres and demultiplexer to pass clock signal only to the row, which selected.

All of wide inputs connected to 32 separate 32 bit inputs and all of wide outputs connected to 32 separate 32 bit outputs.

Here is matrix buffer appearence:

![](./pictures/bufferAppearence.png)

### Cell

![](./pictures/cell.png)

Cell is a single calculator, which calculates new state of single cell, based on its' neighbours (actually on amount of alive neighbours), current status of cell and rules.

This is done by two multiplexers, selecting if cell should survive or should it become alive, and CNF, which represents following truth table:

| surv | born | state | new |
| ---- | ---- | ----- | --- |
| 0    | 0    | 0     | 0   |
| 0    | 0    | 1     | 0   |
| 0    | 1    | 0     | 1   |
| 0    | 1    | 1     | 1   |
| 1    | 0    | 0     | 0   |
| 1    | 0    | 1     | 1   |
| 1    | 1    | 0     | 1   |
| 1    | 1    | 1     | 1   |

#### Counter

Circuit in the west side is counter, simple circuit which counts amount of its' high inputs:

![](./pictures/counter.png)

### Game processor row

![](./pictures/gameProcessorRow.png)

This circuit is just 32 cells connectend with each other in one row. This circuit have 3 inputs for rows:
1. Row **above** this
2. Row **below** this
3. **This** row
All of this inputs is **current** state of this rows.
Also, there is 2 inputs for rules, mentioned before: **surv** and **born**.

All of cells' 8 **neighbour** inputs connected to appropriate wires with their neighbours statuses (except leftmost and rightmost cells, which don't have neighbours on the left and on the right respectively).

All of calculated **new** states of cells goes in single 32 bit wide wire, which goes to the only one output of game processor row - **new state of this row**.
### Game processor
### Speed controller
### Status register
### One iteration trigger
## UART controller
# Software
## Memory layout

- Addresses 0xff00-0xffff - I/O devices address space
	- Addresses 0xff80-0xffff - game field (for reading and writing of current field state 16 bits at a time) 
	- Address 0xff7e - matrix controller state register №1
	- Address 0xff7c - matrix controller state register №2
	- Address 0xff7a - UART controller (for reading and writing data via UART) 
	- Address 0xff78 - address for controlling of interrupts throwing from UART controller
	- Address 0xff76 - address for triggering one game tick
- Addresses 0xfee1 - 0xfeff - input buffer
## Interrupt Vector Table (IVT)
## Start section
## Matrix Driver
## Interrupt handlers
## Main section
## Commands list
## Commands parsing
# User guide



Перевести и распределить по разделам
|
V


# Регистры состояния поля

- Регистр 1
	- 0-8 биты битовая строка настройки survive
- Регистр 2
	- 0-8 биты битовая строка настройки born
	- 9 бит play
	- 10 бит reset
	- 11-12 биты speed, 0 самая быстра, 3 - самая медленная
