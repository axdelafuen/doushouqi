# TP1 

- [ ] commentaires

- [x] README.md -> faire des diagrammes

# TP2 

- [x] expliquer "techniquement" la difference `guard` et `if` -> **Est utilise car si on fait un `guard let x else return ERROR`, on peut donc utiliser x en dehors du bloc de test, contrairement a un `if`**

- [x] ajouter des nom differents sur des parametres de méthode, pour l appel -> **fait pour ajouter/supr piece**

- [x] savoir expliquer les méthodes d'extensions des collections (Closure, cf. Code#)

- [x] faire des tests plus "complet", vérifier si ca retourne bien "ok" pas sufisant

- [x] changer le equatable (trop complexe pour rien)

- [x] faire des tests paramétré

# TP3

- [x] Refactor and finish `checkboard()`

- [x] Handle the return value of `createBoard()`

- [x] Update class diagram with my own attributes names

- [x] Add tests to increase test coverage, up to 90%

- [x] Check if the return value of `isGameOver()`, are the corect one (noOne sometimes ??)

- [x] write both `getMoves()` methods

- [x] `Move` class should inherit from `CustomStringConvertible`, and have the `description` attributes

- [x] Check the dest cell, if it s possible to eat it (`isMoveValid()`)

# TP 4

- [x] Update class diagram

- [x] There is some bugs in the game function (some pieces are not moved corectly) -> cf. `main.swift`

- [x] Write `HumanePlayer` methods

- [x] Try `HumanPlayer` in console, with dependance injection of methods

- [x] Write test for `Model` (up to 90%)

- [ ] Sonar ? => IMPOSSIBLE (Soanr community ne prend pas en compte Swift)

- [x] IA ? => tres simple pour le moment

- `@escaping` devant une injection de dependance, permet de la stocker et de ne pas la détruire a la fin de l'init

# IA

- [x] Ajouter le nom des animaux sur les mouvements

- [x] Ajouter un "x" lorsqu'un animal en mange un autre

- [ ] Générer un csv cohérent, pour prédire le meilleur coup a venir

# TP 6

- [ ] Finish `Codable`, for `Game` and `Player`

- [ ] Re write README diagram
