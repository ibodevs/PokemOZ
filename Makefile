SRCS = Battle.oz Enem.oz Introduction.oz Items.oz Keys.oz Load.oz Map.oz Objects.oz PokemOZ.oz Selection.oz Text.oz Title.oz Btl/Fight.oz Btl/PrintBtl.oz
OBJS = $(SRCS:.oz=.ozf)
MAIN = PokemOZ.oz
EXECUTABLE = PokemOZ
FIGHT = Btl/Fight.ozf
PRINT = Btl/PrintBtl.ozf

.PHONY: clean

$(EXECUTABLE): $(OBJS) $(MAIN)
	ozc -c $(MAIN)

Objects.ozf: Objects.oz
	ozc -c Objects.oz -o Objects.ozf

Load.ozf: Load.oz
	ozc -c Load.oz -o Load.ozf
	
Text.ozf: Text.oz
	ozc -c Text.oz -o Text.ozf
	
Introduction.ozf: Introduction.oz Text.ozf
	ozc -c Introduction.oz -o Introduction.ozf
	
Title.ozf: Title.oz Introduction.ozf
	ozc -c Title.oz -o Title.ozf
	
Map.ozf: Map.oz Introduction.ozf Selection.ozf Enem.ozf
	ozc -c Map.oz -o Map.ozf

Enem.ozf: Enem.oz Battle.ozf Map.ozf Text.ozf Objects.ozf
	ozc -c Enem.oz -o Enem.ozf

Selection.ozf: Selection.oz Introduction.ozf Enem.ozf Text.ozf
	ozc -c Selection.oz -o Selection.ozf

Btl/Fight.ozf: Btl/Fight.oz Battle.ozf Introduction.ozf Text.ozf $(PRINT)
	ozc -c Fight.oz -o Fight.ozf

Btl/PrintBtl.ozf: Btl/PrintBtl.oz Battle.ozf Introduction.ozf Text.ozf Map.ozf $(FIGHT)
	ozc -c PrintBtl.oz -o PrintBtl.ozf

Battle.ozf: Battle.oz $(FIGHT) $(PRINT) Introduction.ozf Text.ozf
	ozc -c Battle.oz -o Battle.ozf

Items.ozf: Items.oz Battle.ozf Text.ozf
	ozc -c Items.oz -o Items.ozf

Keys.ozf: Keys.oz Battle.ozf Enem.ozf Items.ozf Text.ozf
	ozc -c Keys.oz -o Keys.ozf
	
PokemOZ.ozf: PokemOZ.oz Load.ozf Keys.ozf Introduction.ozf Map.ozf Objects.ozf Selection.ozf Title.ozf
	ozc -c PokemOZ.oz -o PokemOZ.ozf
	

all: $(EXECUTABLE)

clean:
	rm -f $(OBJS) $(EXECUTABLE)
