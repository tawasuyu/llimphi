# llimphi

> Native UI framework: HAL · raster · layout · text · theme · ui — plus widgets and modules.

`llimphi` is a sovereign, retained-mode UI framework with an Elm-style loop (`input → update → view → layout → raster → present`). Declarative pipeline over `vello` + `wgpu` + `taffy` + `parley`, with `Dark/Light/Aurora/Sunset` themes and a multi-platform HAL (Wayland · X11 · Win32 · Android · Wawa bare-metal). It powers a full Rust application suite; this repository is the framework extracted to stand on its own.

<p align="center">
  <img src="docs/showreel.gif" alt="Llimphi showreel — real widgets (switch, slider, progress, segmented control, buttons, radial) animating live, then reflowing across layouts" width="900">
  <br>
  <sub>real widgets in motion — rendered headless, frame-by-frame, fully deterministic</sub>
</p>

<p align="center">
  <img src="docs/counter.gif" alt="counter example — the full Elm loop in ~124 LOC" width="480">
  <br>
  <sub>…and the entire Elm loop in ~124 LOC — <code>cargo run -p llimphi-ui --example counter</code></sub>
</p>

**Usage manual:** [MANUAL.md](MANUAL.md) — full reference (Elm loop, `View<Msg>` DSL, the ~44 widgets and 10 modules, GPU path, gotchas) for humans and AI. Design rationale and roadmap: [SDD.md](SDD.md).

Philosophy: **widgets aren't designed against mockups; they're designed with what `vello` and `taffy` can do.**

## Quick start

```sh
git clone https://git.tawasuyu.net/tawasuyu/llimphi.git
cd llimphi
cargo run -p llimphi-ui --example counter   # ~124 LOC: the full Elm loop on screen
```

## Install

```toml
[dependencies]
llimphi-ui    = { git = "https://git.tawasuyu.net/tawasuyu/llimphi.git" }
llimphi-theme = { git = "https://git.tawasuyu.net/tawasuyu/llimphi.git" }
# widgets are one crate each — pull only what you use:
llimphi-widget-button = { git = "https://git.tawasuyu.net/tawasuyu/llimphi.git" }
```

## Compatibility

- **Linux/Wayland** — primary backend.
- **Linux/X11** — via XWayland.
- **macOS / Windows** — `winit` + `wgpu`.
- **Android** — HAL via `android` crates.
- **Wawa bare-metal** — alternative framebuffer HAL.

Crates listed in [README.md](README.md) (framework, widgets, modules, android).

## Considerations

- **Single API: declarative `View<Msg>`.** No imperative, no foreign vDOM.
- **Same scene tree on Wayland and Wawa**: HAL abstracts the surface.
- Widgets are **purely visual**; modules encapsulate state + behavior.
