# trussc-docset

Offline API docset (**Dash / Zeal**) for the [TrussC](https://github.com/TrussC-org/TrussC)
creative-coding framework — the full C++ API plus the guides, searchable offline.

- **Contents:** every public C++ symbol (types, methods, fields, operators, free
  functions, enums + values, constants, macros, type aliases) and the TrussC
  guides, as self-contained static HTML with a SQLite search index.
- **Generated**, not hand-written: built from TrussC's canonical `reference-data.json`
  by `docs/reference/emit-dash.js` in the TrussC repo.

---

## Install

Zeal has no "add local docset" dialog — drop the bundle into its docsets folder
and restart.

| App / OS | Docsets folder |
|----------|----------------|
| Zeal (Windows) | `%LOCALAPPDATA%\Zeal\Zeal\docsets\` |
| Zeal (Linux) | `~/.local/share/Zeal/Zeal/docsets/` |
| Dash (macOS) | Preferences → Docsets → drag `TrussC.docset` in |

1. Grab `TrussC.tgz` from the [Releases](../../releases) (or build it — see below).
2. Extract it so you get a `TrussC.docset` folder.
3. Move `TrussC.docset` into the docsets folder above and restart Zeal/Dash.

"TrussC" then appears in the sidebar. Search e.g. `Color::fromHSB`, browse the
guides, and use the per-page table of contents.

---

## Build & package

The docset is produced in the **TrussC repo** (needs `clang` for the one AST
step), then packaged here.

```bash
# 1) in the TrussC repo — build the docset
cd /path/to/TrussC/docs
npm install
cd reference
node --max-old-space-size=8192 generate.js   # clang → reference-data.json
node emit-dash.js                            # → build/TrussC.docset
#   English only by default; use --lang all for en/ja/ko

# 2) in this repo — package it for distribution
cp -r /path/to/TrussC/docs/reference/build/TrussC.docset .
./package.sh                                  # → TrussC.tgz   (Windows: pwsh ./package.ps1)
```

Then attach `TrussC.tgz` to a GitHub Release (or commit it), and update the
install link above.

Full build reference (clang setup incl. Windows, options, troubleshooting):
[`docs/reference/zeal-docgen-guide.md`](https://github.com/TrussC-org/TrussC/blob/main/docs/reference/zeal-docgen-guide.md)
in the TrussC repo.

---

## License

The documentation content is TrussC's; see the [TrussC license](https://github.com/TrussC-org/TrussC/blob/main/docs/LICENSE.md).
The packaging scripts in this repo are MIT.
