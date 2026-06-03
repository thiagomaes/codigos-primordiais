# codigos-primordiais

Repositório único contendo o website e o jogo.

## Estrutura

```text
website/
  index.html
  package.json
  src/

game/
  project.godot
  Scenes/
  Scripts/
  Sprites/
  levels/
  GUI/
  00_Globals/
```

## Pastas

- `website/`: site institucional em React + Vite.
- `game/`: projeto Godot com código, cenas, sprites e exports relacionados ao jogo.

## Observações

- O ponto de entrada do site é `website/index.html`, com a aplicação React em `website/src/`.
- O ponto de entrada do jogo é `game/project.godot`.

## Website

Para rodar o site localmente:

```bash
cd website
npm install
npm run dev
```
