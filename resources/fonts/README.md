# Custom watch-face fonts

The primary time uses the FR970 system vector font `RobotoCondensedBold` at a
size derived from the display diameter. This directory is reserved for an
optional bitmap font if a future design iteration needs custom digit shapes.

When adding one, place its `.fnt` descriptor and bitmap atlas here, register it
in a resource XML file, and replace `_timeFont` in `WatchFaceView.mc`.
