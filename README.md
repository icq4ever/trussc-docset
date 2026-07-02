# trussc-docset

Offline API docset (**Dash / Zeal**) for the [TrussC](https://github.com/TrussC-org/TrussC)
creative-coding framework — the full C++ API plus the guides, searchable offline.

- **Contents:** every public C++ symbol (types, methods, fields, operators, free
  functions, enums + values, constants, macros, type aliases) and the TrussC
  guides, as self-contained static HTML with a SQLite search index.
- **Generated**, not hand-written: built from TrussC's canonical `reference-data.json`
  by `docs/reference/emit-dash.js` on the `feat/zeal-document-generator` branch of the
  [`icq4ever/TrussC`](https://github.com/icq4ever/TrussC/tree/feat/zeal-document-generator)
  fork (this tooling is **not** in the official `TrussC-org/TrussC` repo yet).

---

## Install

Zeal and Dash have no "load this archive" dialog — you **can't** hand them the
`.zip`/`.tgz` directly. Extract it to a `TrussC.docset` folder, drop that folder
into the docsets folder below, and restart.

| App / OS | Docsets folder |
|----------|----------------|
| Zeal (Windows) | `%LOCALAPPDATA%\Zeal\Zeal\docsets\` |
| Zeal (Linux) | `~/.local/share/Zeal/Zeal/docsets/` |
| Dash (macOS) | double-click the extracted `TrussC.docset` (dragging into Preferences doesn't work) |

1. Grab `TrussC.zip` from the [Releases](../../releases) (or build it — see below).
   A `TrussC.tgz` is also provided for `tar` users.
2. Extract it so you get a `TrussC.docset` folder.
   - **Windows:** double-click `TrussC.zip` → *Extract All* (Explorer handles zip
     natively — no extra tool needed). If you grabbed the `.tgz` instead, Explorer
     can't open it; use [Bandizip](https://www.bandisoft.com/bandizip/) or 7-Zip.
   - **macOS:** double-click `TrussC.zip`.
   - **Linux:** `unzip TrussC.zip` (or `tar -xzf TrussC.tgz`).
3. Install the `TrussC.docset` folder:
   - **Zeal:** move it into the docsets folder above and restart. Make sure it's
     `…\docsets\TrussC.docset\Contents\…` — not double-nested as
     `…\docsets\TrussC.docset\TrussC.docset\…`.
   - **Dash:** double-click `TrussC.docset` — Dash adds it automatically.

"TrussC" then appears in the sidebar. Search e.g. `Color::fromHSB`, browse the
guides, and use the per-page table of contents.

### Updating to a new version

- **Zeal:** replace the `TrussC.docset` folder in the docsets folder and restart.
- **Dash:** in Preferences → Docsets, remove the old TrussC entry, then
  double-click the freshly downloaded `TrussC.docset` to add it.

---

## Build & package

The docset is produced from the **TrussC repo** (needs `clang` for the one AST
step), then packaged here.

> [!IMPORTANT]
> The docset tooling (`generate.js` / `emit-dash.js`) lives only on the
> `feat/zeal-document-generator` branch of the **[`icq4ever/TrussC`](https://github.com/icq4ever/TrussC/tree/feat/zeal-document-generator)**
> fork — it is **not** part of the official `TrussC-org/TrussC` repo (or its `main`).
> Clone that fork/branch first:
>
> ```bash
> git clone -b feat/zeal-document-generator https://github.com/icq4ever/TrussC.git
> ```

```bash
# 1) in the icq4ever/TrussC fork (feat/zeal-document-generator) — build the docset
cd /path/to/TrussC/docs
npm install
cd reference
node --max-old-space-size=8192 generate.js   # clang → reference-data.json
node emit-dash.js                            # → build/TrussC.docset
#   English only by default; use --lang all for en/ja/ko

# 2) in this repo — package it for distribution
cp -r /path/to/TrussC/docs/reference/build/TrussC.docset .
./package.sh                                  # → TrussC.zip + TrussC.tgz
```

Then attach both `TrussC.zip` and `TrussC.tgz` to a GitHub Release, and update
the install link above. Tag the release after the TrussC version the docset was
built from (e.g. `v0.6.2`).

Full build reference (clang setup incl. Windows, options, troubleshooting):
[`docs/reference/zeal-docgen-guide.md`](https://github.com/icq4ever/TrussC/blob/feat/zeal-document-generator/docs/reference/zeal-docgen-guide.md)
on the `feat/zeal-document-generator` branch of the `icq4ever/TrussC` fork.

---

## License

The documentation content is TrussC's; see the [TrussC license](https://github.com/TrussC-org/TrussC/blob/main/docs/LICENSE.md).
The packaging scripts in this repo are MIT.
