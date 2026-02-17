shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec2 distortion_center = vec2(0.0, 0.0);
uniform float distortion_strength;
uniform vec2 uv_offset = vec2(0.0, 0.0);
uniform sampler2D texture_map;

vec2 Spherize(vec2 uv, vec2 center, float strength, vec2 offset)
{

// Вектор от центра искажения к текущим UV
vec2 delta = uv - center;

// Квадрат длины вектора delta (эквивалент length(delta)^2)
float delta2 = dot(delta.xy, delta.xy);

// delta4 — четвёртая степень расстояния (усиливает искажение ближе к краям)
float delta4 = delta2 * delta2;

// Смещение вектора delta в зависимости от delta4 и силы
vec2 delta_offset = vec2(delta4, delta4) * strength;

// Добавляем искажение и смещение
return uv + (delta * delta_offset) + offset;
}


void fragment() {
vec2 uv_with_offset = Spherize(UV, distortion_center, distortion_strength, uv_offset);
vec4 tex_color = texture(texture_map, uv_with_offset);
ALBEDO = tex_color.rgb;
}