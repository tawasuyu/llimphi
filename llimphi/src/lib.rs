//! # llimphi — native Rust UI framework (2D **and** 3D)
//!
//! Sovereign, retained-mode UI framework with an Elm-style loop
//! (`input → update → view → layout → raster → present`), built on
//! `vello` + `wgpu` + `taffy` + `parley`. This is the **facade** crate: it
//! re-exports the core ([`ui`]) plus the [`theme`] tokens and the 3D
//! [`engine3d`]. For widgets and modules, add the individual
//! `llimphi-widget-*` / `llimphi-module-*` crates.
//!
//! ```no_run
//! use llimphi::{App, View, Handle}; // re-exported from llimphi-ui
//! ```
//!
//! - **Core / Elm loop, `View<Msg>` DSL:** [`ui`] (`llimphi-ui`).
//! - **Theme tokens & palettes:** [`theme`] (`llimphi-theme`).
//! - **3D voxel + mesh engine:** [`engine3d`] (`llimphi-3d`).

#![doc(html_root_url = "https://docs.rs/llimphi")]

/// The framework core — Elm loop, `View<Msg>`, HAL/raster/layout/text re-exports.
pub use llimphi_ui as ui;
/// Semantic color themes (Dark/Light/Aurora/Sunset/Tawa) and tokens.
pub use llimphi_theme as theme;
/// The 3D engine: voxel ray-march + triangle meshes in a shared depth pass.
pub use llimphi_3d as engine3d;

// Convenience: the most-used core items (App, View, Handle, …) at the crate root.
pub use llimphi_ui::*;
