# Age of Dominion

A browser-based, turn-based hex strategy game with six playable realms, procedural maps, city expansion, research, diplomacy, armies, combat, and local saves.

## Play

Open `index.html` directly in a modern desktop browser. The page loads a generated classic-script bundle, so the game does not depend on ES module support for `file://` URLs or on an internet connection. If the browser restricts local-file storage, the game still starts; saving may be unavailable in that browser.

For source development, edit the modules in `js/`, then regenerate the browser bundle:

```sh
ruby build.rb
```

Alternatively, serve the project over HTTP with `ruby -run -e httpd . -p 8000` and open <http://localhost:8000>.

## Controls

- Left click selects units, cities, and tiles. Blue hexes show reachable army movement.
- Click a blue hex to move; click an adjacent rival army or city to preview/confirm an assault.
- Middle mouse drag, left mouse drag, or WASD pans; mouse wheel or `+`/`-` zooms.
- `Space` centers on the selected army; `Enter` ends the turn; `Esc` closes the current panel.
- `1` Empire, `2` Technology, `3` Diplomacy, `4` Armies.
- Use **MUSIC: ON/OFF** in the menu or top bar to toggle the generated ambient score.

Campaigns are saved in browser local storage with a versioned format.
