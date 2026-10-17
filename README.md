# Night City

A city at night, drawn on a canvas. It starts dark and empty; every merged pull request adds one thing to it: a moon, lit windows, traffic, fireworks.

It is the demo app for a workshop on running a team of coding agents: you write the tickets, agents open the PRs, you review and merge, and the city changes on your screen within seconds.

## Run it

You need Node 20.19 or newer.

```sh
npm install
npm start
```

Open the address it prints. `npm start` also pulls the latest `main` every 5 seconds, so when a PR is merged on GitHub, the new element shows up on the page by itself. Run it in a clone you don't edit; if the pull can't fast-forward, it pauses and says why.

`npm run dev` serves the city without pulling.

## How it's built

Each thing in the city is one file in `src/elements/`. The app loads every file in that folder, so a new file is a new element, and agents working in parallel never touch the same file. `AGENTS.md` has the contract an element follows.

```sh
npm test        # every element draws without errors, plus the city layout
npm run build   # what CI also runs
```

## Starter tickets

Copy these into your tracker, one ticket each. Each one adds a single file.

1. **Add a rising moon.** A full moon rises from behind the buildings over about 3 seconds after the page loads and stays in the upper right of the sky. It has a soft glow and a couple of faint craters. Layer: `sky`.
2. **Light up the windows.** About half of the windows glow warm yellow, a few of them brighter than the rest. Every few seconds a handful switch off or on, so the city looks lived in. Use `scene.windows`. Layer: `city`.
3. **Show the last merged PR on a billboard.** A neon billboard stands on the roof of a tall building near the middle of the city. It shows `PR #<number> merged: <title>` from `scene.lastMerge`, scrolling if the text is too long. With no merge yet, it shows `Night City`. Layer: `city`.
4. **Add cars on the street.** Cars drive along two lanes in opposite directions, at different speeds, with headlights shining ahead and red tail lights. Layer: `street`.
5. **Add stars and shooting stars.** About 90 small stars twinkle in the upper part of the sky. Every few seconds a shooting star streaks across and fades. Layer: `sky`.
6. **Add a plane with blinking lights.** A small plane crosses the sky from left to right about every 25 seconds, with a red light blinking at its nose and a white light at its tail. Layer: `sky`.
7. **Add fireworks.** Fireworks burst in random colours above the buildings every 1 to 3 seconds. Clicking the sky starts a burst where the viewer clicked. Layer: `sky`.
8. **Add rain.** Light rain falls across the whole scene at a slight angle, and the sky gets a little darker. Layer: `weather`.
9. **Add a searchlight.** A searchlight beam sweeps slowly back and forth across the sky from a rooftop on the left. Layer: `sky`.
10. **Add a frame-rate counter.** The bottom-right corner shows the frames per second, updated twice a second, in small grey text. Layer: `weather`.
