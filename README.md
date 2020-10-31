# ShaderV - VisualShader plugin for Godot Engine 3.2
<p>Adds many premade effects (such as noises, blur, emboss, zoom, custom shapes, etc.) to build-in VisualShader editor.
Fully compatible with GLES2 and canvas (2D) fragment shaders.</p>
<p>You can find basic usage examples in the <i>addons/shaderV/examples</i> folder. Note that plugin can work freely without <i>examples</i> folder, so this folder can be deleted.</p>
<p>Copy the contents of <i>addons/shaderV</i> into the same folder in your project. No activation needed. Custom visual shader nodes work the same way as standart visual shader nodes.</p>


<p align="center">
  <img src="https://github.com/arkology/ShaderV/blob/master/preview.gif?raw=true">
</p>

## List of provided nodes:

#### Color changing nodes (rgba folder):

<ul>
<li>Blur nodes:</li>
  <ul>
  <li>BlurBasic - Basic 8-directional blur with 9 samples</li>
  <li>BlurCustom - Custom 8-directional blur with ([amount]*2+1)^2 samples</li>
  <li>ZoomBlur</li>
  </ul>

<li>Shapes generation:</li>
  <ul>
  <li>CheckerboardShape - Creates checkerboard pattern</li>
  <li>CircleShape - Circle creation with adjusted position, scale, inner/outer radius, hardness and color</li>
  <li>CircleShape2 - Circle creation with adjusted position, scale, radius inner/outer width, and color</li>
  <li>RegularPolygonShape - Regular N-gon with 3+ sides</li>
  <li>SpiralShape - Spiral creation with adjusted position, size, lines amount, softness, speed and color</li>
  <li>GridShape - Creates 2D grid</li>
  <li>ScanLinesSharpShape - Sharp moving scanlines</li>
  <li>RandomStripesShape - Random horizontal lines creation</li>
  </ul>
</ul>

<ul>
<li>Glow:</li>
  <ul>
  <li>InnerGlow - Adds inner glow to color</li>
  <li>OuterGlow - Adds outer glow to color</li>
  <li>InnerGlowEmpty - Same as InnerGlow but without original texture (only contours)</li>
  <li>OuterGlowEmpty - Same as OuterGlow but without original texture (only contours)</li>
  <li>GlowEmpty - Combination of InnerGlowEmpty and OuterGlowEmpty</li>
  </ul>
</ul>

<ul>
<li>Noise:</li>
  <ul>
    <li>Fractal noise:</li>
      <ul>
      <li>FractalGenericNoise2D - Fractal GenericNoise using hash random function</li>
      <li>FractalPerlinNoise2D/3D/4D - Fractal 2D/3D/4D Perlin Noise</li>
      <li>FractalSimplexNoise2D/3D/4D - Fractal 2D/3D/4D Simplex Noise</li>
      <li>FractalWorleyNoise2D/3D - Fractal 2D/3D Worley (Voronoi) Noise</li>
      </ul>
    <li>GenericNoise2D - GenericNoise using hash random function</li>
    <li>PerlinNoise2D - Classic 2d perlin noise with ability to set period</li>
    <li>PerlinNoise3D - Classic 3d perlin noise</li>
    <li>PerlinPeriodicNoise3D - Classic 3d perlin noise with ability to set period</li>
    <li>PerlinNoise4D - Classic 4d perlin noise</li>
    <li>SimplexNoise2D/3D/4D - 2D/3D/4D simplex noise</li>
    <li>WorleyNoise2D/2x2/2x2x2/3D - 2D/2x2/2x2x2/3D worley noise</li>
  </ul>
</ul>
TODO
