# Night City: rules for agents

Night City is a canvas scene of a city at night. Each ticket adds one thing to it.

## One ticket, one new file

- Add your element as a new file `src/elements/<name>.js`, named for what it draws (`moon.js`, `cars.js`).
- Do not edit other elements, `src/city.js`, `src/main.js` or `index.html`. Several agents work in parallel, and new files never conflict. If a ticket can't be done without touching shared code, say so on the ticket instead.
- Add a test only when your element has logic worth testing; `test/elements.test.js` already checks that every element draws without errors.

## The element contract

```js
export const layer = 'sky'; // 'sky' (behind buildings), 'city' (on buildings), 'street', 'weather' (in front of everything)

export function draw(ctx, scene) {
  // Called every frame. ctx is a 2D canvas context, already saved and restored around you.
}

export function onClick(x, y, scene) {} // optional: the viewer clicked the canvas
```

`scene` holds:

| Field | What |
|---|---|
| `width`, `height` | Canvas size in CSS pixels |
| `time` | Seconds since the page loaded |
| `ground` | Y of the street line |
| `buildings` | `{ x, y, width, height }` for each building |
| `windows` | `{ x, y, width, height, building }` for each window, drawn dark by default |
| `lastMerge` | `{ number, title }` of the newest commit on main, or `null` |

Import `random(seed)` from `../city.js` for noise that stays the same on every reload. Size everything from `width` and `height`, so the city works on a laptop and on a projector.

## Before you open the PR

- `npm test` and `npm run build` pass.
- PR title is the ticket's title. The PR body says which ticket it closes.
