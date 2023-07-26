# D3D11Max2DDriver module

This assumes you are familiar with the module building process of BlitzMax:

# Installation
To use this module download/clone to your pc and make this file structure:
```
'BlitzMaxInstall'/mod/srs.mod/d3d11graphics.mod/
'BlitzMaxInstall'/mod/srs.mod/d3d11max2d.mod/
'BlitzMaxInstall'/mod/srs.mod/directx11.mod/
'BlitzMaxInstall'/mod/srs.mod/dxgi.mod/
```

Hit 'Build modules' from the 'Program' menu in the standard MaxIDE to build the module.

# Example usage:
```
Strict

Import srs.d3d11max2d
SetGraphicsDriver D3D11Max2DDriver()
Local driver$ = GetGraphicsDriver().ToString()

Graphics 800, 600

While Not KeyDown(KEY_ESCAPE)
  DrawText driver, 0, 0
  Flip
Wend
```
