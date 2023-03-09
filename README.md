# ShaderV - VisualShader plugin for Godot Engine 4.x
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
<li>Glow:</li>
  <ul>
  <li>InnerGlow - Adds inner glow to color</li>
  <li>OuterGlow - Adds outer glow to color</li>
  <li>InnerGlowEmpty - Same as InnerGlow but without original texture (only contours)</li>
  <li>OuterGlowEmpty - Same as OuterGlow but without original texture (only contours)</li>
  <li>GlowEmpty - Combination of InnerGlowEmpty and OuterGlowEmpty</li>
  </ul>
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
<li>BCSAdjustment - Full analog of BCS adjustment of environment in Godot</li>
<li>BlackAndWhite - Turns color to black and white</li>
<li>BlendAwithB - Blends colors basing on fade</li>
<li>Bloom</li>
<li>ChromaticAberration - Basic Chromatic Aberration with red and blue channels offset</li>
<li>ClampAlphaBorder - Clamp alpha to border vec4(0, 0, 1, 1) UV</li>
<li>ColorCorrectionAdjustment - Full analog of color correction adjustment of environment in Godot</li>
<li>Emboss - Emboss filter</li>
<li>FireFX - 3-step fire based on perling noise</li>
<li>Gradient4Corners - Generates gradient based on corners colors</li>
<li>GradientMapping - Remaps colors based on average color value using [gradient]</li>
<li>GrayscalePlus - Improved grayscale with gray factor</li>
<li>Hue - Outputs an RGB color given a HUE</li>
<li>InverseColor - Inverse color basing on intensity</li>
<li>MaskAlpha - Color masking based on mask alpha</li>
<li>NormalFromHeightmap - Create normal map from heightmap texture. You should provide actual size of heightmap (in pixels).</li>
<li>Posterize - Rounds values based on the value coming through [steps]</li>
<li>ShiftHSV - Changes hue, saturation and value of input color.</li>
<li>ShineFX - Adds shine effect in form of line</li>
<li>SobelEdge - Sobel edge filter. Returns detected edges as scalar.</li>
<li>TintRGBA - Tints RGBA with tint color (same as modulate property in editor)</li>
<li>Tonemap</li>
<li>TurnCGA4Palette - Swaps color to CGA 4-color palette</li>
<li>TurnGameBoyPalette - Swaps color to GameBoy palette</li>
</ul>

#### UV changing nodes (uv folder):

<ul>
  <li>Animated:</li>
  <ul>
    <li>DistortionUVAnimated - Animated wave-like UV distortion</li>
    <li>DoodleUV - Doodle UV effect</li>
    <li>RotateUVAnimated - Animated UV rotation by angle in radians relative to pivot point</li>
    <li>SwirlUV - Swirl UV effect</li>
    <li>TilingAndOffsetUVAnimated - Animated UV tiling with given [offset] speed</li>
  </ul>
  <li>DistortionUV - Wave-like UV distortion</li>
  <li>FlipUV - Flip UV horizontal and/or vertical</li>
  <li>LensDistortionUV - Lens distortion effect.</li>
  <li>PixelateUV - Pixelate UV by size factor</li>
  <li>RotateUV - Rotate UV by angle in radians relative to pivot vector</li>
  <li>ScaleUV - Scale UV relative to pivot point</li>
  <li>SphericalUV - Makes UV look like a sphere. Can be used to make 2d planets</li>
  <li>TileUV - Tile UV can be used to get UV position of tile within a tilemap</li>
  <li>TilingAndOffsetUV - Tiles UV with given offset</li>
  <li>TransformUV - Performs offset, scale and rotation of UV with custom pivots. Rotation is set in radians.</li>
  <li>TwirlUV - Twirl UV by value relative to pivot point</li>
</ul>

#### Tools nodes (tools folder):

<ul>
  <li>Random:</li>
  <ul>
    <li>HashRandom1d - Hash func with scalar input and scalar output</li>
    <li>HashRandom2d - Hash func with vector input and scalar output</li>
    <li>HashRandom2dVec - Hash func with vector input and vector output</li>
    <li>RandomFloat - Returns random float based on input value. UV is default input value.</li>
    <li>RandomFloatImproved - Improved version of classic random function. Classic random can produce artifacts. This one - doesn't.</li>
    <li>RandomGoldRatio - Random float based on golden ratio</li>
  </ul>
  <li>Coordinates transformation:</li>
  <ul>
    <li>CartesianToPolar - Cartesian (x, y) -> Polar (r, theta). By default (x, y) is UV</li>
    <li>CartesianToSpherical - Cartesian (x, y, z) -> Spherical (r, theta, phi). By default (x, y, z) is UV</li>
    <li>PolarToCartesian - Polar (r, theta) -> Cartesian (x, y)</li>
    <li>SphericalToCartesian - Spherical (r, theta, phi) -> Cartesian (x, y, z)</li>
  </ul>
  <li>ScaledTIME - Returns [scale] * TIME</li>
  <li>Relay - Outputs its input, may be useful for organizing node connections. Works with booleans, vectors and scalars. Also can be used as preview node</li>
  <li>Remap - Remaps input value from ( [inMin], [inMax] ) range to ( [outMin], [outMax] ). UV is default input value.</li>
  <li>SinTIME - Returns [amplitude] * sin([speed] * TIME)</li>
  <li>vec2Compose - Makes 2d vector from length and angle (in radians)</li>
</ul>












