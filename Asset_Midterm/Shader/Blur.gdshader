shader_type canvas_item;

uniform float blur_size : hint_range(0.0, 20.0) = 5.0;

void fragment() {
    vec4 sum = vec4(0.0);
    vec2 pixel = blur_size * SCREEN_PIXEL_SIZE;

    // sample 16 จุดรอบพิกเซล
    sum += texture(TEXTURE, UV + pixel * vec2(-1.0, -1.0));
    sum += texture(TEXTURE, UV + pixel * vec2(-1.0,  0.0));
    sum += texture(TEXTURE, UV + pixel * vec2(-1.0,  1.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 0.0, -1.0));
    sum += texture(TEXTURE, UV);
    sum += texture(TEXTURE, UV + pixel * vec2( 0.0,  1.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 1.0, -1.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 1.0,  0.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 1.0,  1.0));

    // เพิ่ม sample ไกลออกไปอีกนิด
    sum += texture(TEXTURE, UV + pixel * vec2(-2.0,  0.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 2.0,  0.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 0.0, -2.0));
    sum += texture(TEXTURE, UV + pixel * vec2( 0.0,  2.0));

    COLOR = sum / 13.0; // หารด้วยจำนวน sample
}
