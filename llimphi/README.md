# llimphi

> Native UI framework for Rust — 2D **and** 3D. No web view, no Electron.

`llimphi` is a sovereign, retained-mode UI framework with an Elm-style loop
(`input → update → view → layout → raster → present`), built on **vello + wgpu +
taffy + parley**. This crate is the **facade**: it re-exports the core
(`llimphi-ui`) plus the theme tokens and the 3D engine, so `cargo add llimphi`
gets you the framework.

![llimphi widgets showreel](https://raw.githubusercontent.com/tawasuyu/llimphi/main/docs/showreel.gif)

## What you get

- One declarative API: `View<Msg>` driven by an Elm `update` / `view` loop.
- **vello 0.7** (GPU 2D) · **wgpu 27** · **taffy** (Flexbox + CSS Grid) · **parley 0.6** (text shaping) · **AccessKit**.
- ~44 widgets + ~10 stateful modules (the `llimphi-widget-*` / `llimphi-module-*` crates).
- Multi-platform HAL: Wayland · X11 · Win32 · Android · bare-metal — same scene tree everywhere.
- Headless, deterministic rendering (every frame a pure function of `t`) for CI screenshots and GIFs.

## Not just 2D — a 3D voxel engine

`llimphi-3d` composes voxels (a GPU ray-march) and triangle meshes in one shared
depth pass, and **mounts into the ordinary 2D `View` tree** (a 3D viewport right
next to regular widgets, same Elm loop).

![flying over an endless voxel world](https://raw.githubusercontent.com/tawasuyu/llimphi/main/docs/llimphi_voxel.gif)

## Quick start

```toml
[dependencies]
llimphi = "0.1"
```

```rust
use llimphi::{App, View, Handle};
// implement App: update(Msg) -> Model + view(&Model) -> View<Msg>
```

## Crate layout

- `llimphi::ui` — the core (`llimphi-ui`): the Elm loop, the `View<Msg>` DSL, and the HAL/raster/layout/text re-exports.
- `llimphi::theme` — semantic color themes (`llimphi-theme`).
- `llimphi::engine3d` — the 3D voxel + mesh engine (`llimphi-3d`).

Add individual widgets/modules as `llimphi-widget-*` / `llimphi-module-*` crates.

**Source & full manual:** <https://github.com/tawasuyu/llimphi> · **License:** MIT
