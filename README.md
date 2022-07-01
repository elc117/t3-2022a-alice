# t3-2022a-alice
Terceiro trabalho da disciplina de Paradigmas de Programação. Alice Zeferino Marques.

# Gerador de personagens de Dungeons and Dragons 5e em Haskell
A idea desse projeto é escrever um programa em haskell que gere uma ficha de personagem de 1º nível para o TTRPG Dungeons and Dragons em um arquivo texto, dado certos parâmetros recebido do usuário sobre o personagem.

No momento o programa gera um resumo das características do personagem e seus ability scores, usando o método standard array, ordenados baseado no que seria útil para a classe escolhida para o personagem, e com bônus baseados na raça escolhida.

Dungeons and Dragons é um tabletop roleplaying game ou jogo de interpretação de papéis criado por Gary Gygax e Dave Arneson em 1974.Esse projeto se baseia na 5ª edição do jogo, lançada em 2014, e em particular nas [Basic Rules](https://www.dndbeyond.com/sources/basic-rules), disponíveis gratuitamente online.

## Porque escolhi esse trabalho
Eu escolhi fazer esse projeto porque me interessei bastante por Haskell quando estudamos a linguagem, e queria me aprofundar mais nela, e isso parecia um desafio interessante, e não é o tipo de coisa para qual a linguagem é geralmente utilizada.

Eu queria fazer algo com Dungeons & Dragons porque o jogo é uma grande paixão minha. Jogo a mais de 5 anos, e tive experiências muito boas nesse tempo.

## Processo de desenvolvimento
Eu tive dificuldade em voltar a haskell durante esse projeto, então revisei os materias disponibilizados da disciplina e o livro Learn You a Haskell for Great Good. Durante o projeto, eu frequentemente me perguntava "como que faço X em Haskell?", nessa sitação eu iria começar a pesquisar, tanto nos materiais discutidos anteriormente como na internet em geral. Já aprendi muitos recursos que não conhecia da linguagem, como as funções unwords/words e zipWith3. Os sites StackOverflow e zvon.org tem sido particularmente úteis.

## Como executar o programa
O arquivo Main.hs pode ser executado com o comando runhaskell. O comando deve incluir os argumentos que fornecem os detalhes do personagem.

` runhaskell Main.hs [nome] [raça] [classe] >[redirecionamento da saída padrão]`

**nome** é o nome do personagem, que pode ser qualquer string. A seção de cada raça nas regras do jogo inclui exemplos de nomes típos para aquela raça.

**raça** provavelmente seria melhor descrita por "espécie". O mundo de fantasia onde a história de D&D acontece inclui várias espécies inteligentes além de humanos, como elfos ou anões.

As raças atualmente suportadas são:
``` Hill Dwarf
 Mountain Dwarf
 High Elf
 Wood Elf
 Lightfoot Halfling
 Stout Halfling
 Human 
```

Você pode ler mais sobre as caractéristicas de cada raça [na respectiva seção das Basic Rules.](https://www.dndbeyond.com/sources/basic-rules/races)

**classe** descreve que tipo de herói seu personagem é, um poderoso guerreiro (Fighter), um sábio mago (Wizard) ou outro arquétipo da fantasia.

As classes atualmente suportadas são:
``` Barbarian
 Bard
 Cleric
 Druid
 Fighter
 Monk
 Paladin
 Ranger
 Rogue
 Sorcerer
 Warlock
 Wizard
```
**>[redirecionamento da saída padrão]** - um endereço de arquivo aqui (ex: >exemplo.txt) fará o programa gerar a ficha em um arquivo com aquele nome em vez a imprimir na saída padrão.

## Exemplo
O arquivo bruenor.txt contém um exemplo de sáida do programa, nesse caso executado com o comando `runhaskell Main.hs "Bruenor" "Mountain Dwarf" "Figther" >bruenor.txt`
