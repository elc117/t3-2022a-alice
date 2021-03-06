import Text.Printf
import Data.Char
import System.Environment
import System.CPUTime
import Data.List


--3 argumentos, todos strings: nome do personagem, raça do personagem, classe do personagem
--Ex: runhaskell Main.hs "Bruenor" "Mountain Dwarf" "Fighter" >bruenor.txt
main :: IO()
main = do
  args <- getArgs
  seed <- getCPUTime
  let charName = args !! 0
  let charRace = upperFstLetters $ args !! 1
  let charClass = upperFstLetters $ args !! 2
  let abilityScoreArray = raceASIs charRace (orderStatsByClass charClass (generateScores (fromInteger seed)))
  let abilityModArray = map (\x -> floor ((fromIntegral x-10)/2)) abilityScoreArray

  let summary = printf "%s %s 1\n" charRace charClass
  let abilityScores = writeAbilityScores abilityScoreArray abilityModArray
  let characterSheet = charName ++ "\n" ++ summary ++ abilityScores
  putStr characterSheet

--recebe uma string e deixa ela toda minúscula, com a primeira letra de cada palavra maiuscula
upperFstLetters :: String -> String
upperFstLetters input = unwords $ map (\(x:xs) -> toUpper x : map toLower xs) $ words input

--gera os 6 ability scores do personagem, ordenados em ordem ascendente. Simula a geração aleatória tipo 4d6k3.
generateScores :: Int -> [Int]
generateScores seed = sort $ sum4d6k3 $map (`mod` 6) $ take 24 $ meuBSD seed
--soma elementos de uma lista em grupos de 4, ignorando o menor do grupo. Uma lista de 24 elementos vai retornar uma lista de 6.
sum4d6k3 :: [Int] -> [Int]
sum4d6k3 (x:y:z:w:rolls) = sum (tail (sort [x,y,z,w])) : sum4d6k3 rolls
sum4d6k3 _ = []
--Geração de números (pseudo) aleatórios
meuBSD :: Int -> [Int]
meuBSD n = tail (iterate (\x -> (1103515245 * x + 12345) `mod` 2^31) n)

--ordena os Ability Scores do personagem baseado no que é importante para a classe celecionada
orderStatsByClass :: String -> [Int] -> [Int]
orderStatsByClass charClass abilityScoreArray
  | charClass == "Barbarian" = orderStats abilityScoreArray [5,2,4,0,1,3]
  | charClass == "Bard" = orderStats abilityScoreArray [1,4,3,2,0,5]
  | charClass == "Cleric" = orderStats abilityScoreArray [3,0,4,1,5,2]
  | charClass == "Druid" = orderStats abilityScoreArray [1,2,4,3,5,8]
  | charClass == "Fighter" = orderStats abilityScoreArray [5,3,4,2,1,0]
  | charClass == "Monk" = orderStats abilityScoreArray [0,5,3,1,4,2]
  | charClass == "Paladin" = orderStats abilityScoreArray [5,0,3,1,2,4]
  | charClass == "Ranger" = orderStats abilityScoreArray [2,5,3,0,4,1]
  | charClass == "Rogue" = orderStats abilityScoreArray [0,5,2,4,1,3]
  | charClass == "Sorcerer" = orderStats abilityScoreArray [0,2,4,1,3,5]
  | charClass == "Warlock" = orderStats abilityScoreArray [1,3,4,2,0,5]
  | charClass == "Wizard" = orderStats abilityScoreArray [0,4,3,5,1,2]

orderStats :: [Int] -> [Int] -> [Int]
orderStats abilityScoreArray order = [abilityScoreArray !! x | x <- order]

--aplica os bonus de Ability Score baseado na raça do personagem
raceASIs :: String -> [Int] -> [Int]
raceASIs race abilityScoreArray
  | race == "Hill Dwarf" = zipWith (+) abilityScoreArray [0,0,2,0,1,0]
  | race == "Mountain Dwarf" = zipWith (+) abilityScoreArray [2,0,2,0,0,0]
  | race == "High Elf" = zipWith (+) abilityScoreArray [0,2,0,1,0,0]
  | race == "Wood Elf" = zipWith (+) abilityScoreArray [0,2,0,0,1,0]
  | race == "Lightfoot Halfling" = zipWith (+) abilityScoreArray [0,2,0,0,0,1]
  | race == "Sout Halfling" = zipWith (+) abilityScoreArray [0,2,1,0,0,0]
  | race == "Human" = zipWith (+) abilityScoreArray [1,1,1,1,1,1]

--recebe os abilty scores e ability modifiers do personagem e retorna uma string listando eles com o seu nnme
writeAbilityScores :: [Int] -> [Int] -> String
writeAbilityScores scores mods = unwords (zipWith3 (writeAbilityScore) ["STR", "DEX","CON","INT","WIS","CHA"] scores mods) ++ "\n"

writeAbilityScore :: String -> Int -> Int -> String
writeAbilityScore statName statScore statMod = printf "%s: %d(%s)" statName statScore ((\x -> if x > 0 then ("+" ++ show x) else show x) statMod)