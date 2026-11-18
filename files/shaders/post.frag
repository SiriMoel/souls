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

// recycled Souldos code!!!
if (souls_trip.x > 0.0) { 
    vec3 trip_pixel = vec3(0.);

    vec2 souls_uv = tex_coord_.xy / world_viewport_size.xy;
    vec2 ofs = vec2(0.004 * (1. - sin(time) * 0.02), 0.004 * (1. - cos(time) * 0.03));

    vec2 souls_uv2 = souls_uv.xy - ofs.xy;

    float angle = time * 0.18;
    vec2 souls_uv3 = souls_uv2 * 350.;
    for (float i = 0.0; i < 20.0; i += 1.0) {
        souls_uv3 = abs(souls_uv3);
        souls_uv3 -= 0.5;
        souls_uv3 *= 1.1;
        souls_uv3 *= mat2(
            cos(angle), -sin(angle),
            sin(angle), cos(angle)
        );
    }

    trip_pixel = vec3(length(souls_uv3) * 0.15 * souls_trip.x);

    color.gb += trip_pixel.xy;
}