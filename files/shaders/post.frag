vec3 souls_color_hsv = souls_rgb2hsv(color);
vec3 souls_color_rgb = souls_hsv2rgb(souls_color_hsv);

if (souls_boss_soul_effect_amount.x > 0.0) {
    color.r *= (1.0 - 0.1 * souls_boss_soul_effect_amount.x);
    color.g *= (1.0 + 0.2 * souls_boss_soul_effect_amount.x);
    color.b *= (1.0 + 0.2 * souls_boss_soul_effect_amount.x);
    souls_color_hsv = souls_rgb2hsv(color);

    /*souls_color_hsv.y += (0.5 * souls_boss_soul_effect_amount.x);
    souls_color_hsv.z += (0.1 * souls_boss_soul_effect_amount.x);
    souls_color_rgb = souls_hsv2rgb(souls_color_hsv);
    color = souls_color_rgb;*/
}

color = color;