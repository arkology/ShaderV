# ShaderV - VisualShader plugin for Godot Engine 3.2
<p>Adds many premade effects (such as noises, blur, emboss, zoom, custom shapes, etc.) to build-in VisualShader editor.
Fully compatible with gles2 and canvas (2d) fragment shaders.</p>
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
<li>Glow:</li>
<ul>
  <li>InnerGlow - Adds inner glow to color</li>
  <li>OuterGlow - Adds outer glow to color</li>
  <li>InnerGlowEmpty - Same as InnerGlow but without original texture (only contours)</li>
  <li>OuterGlowEmpty - Same as OuterGlow but without original texture (only contours)</li>
  <li>GlowEmpty - Combination of InnerGlowEmpty and OuterGlowEmpty</li>
</ul>
</ul>
TODO
