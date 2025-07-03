// SALVAR configurações atuais
var _old_halign = draw_get_halign();
var _old_valign = draw_get_valign();
var _old_color = draw_get_color();
var _old_alpha = draw_get_alpha();
var _old_font = draw_get_font();

// Posição centralizada
var _cx = display_get_gui_width() / 2;
var _cy = y_target + y_offset;

// Fundo da conquista
draw_set_alpha(alpha * 0.8);
draw_set_color(c_black);
draw_roundrect(_cx - 200, _cy - 30, _cx + 200, _cy + 30, false);

// Borda dourada
draw_set_color(c_yellow);
draw_roundrect(_cx - 200, _cy - 30, _cx + 200, _cy + 30, true);

// Texto
draw_set_alpha(alpha);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(Font1);
draw_text(_cx, _cy, texto);

// RESTAURAR configurações originais
draw_set_halign(_old_halign);
draw_set_valign(_old_valign);
draw_set_color(_old_color);
draw_set_alpha(_old_alpha);
draw_set_font(_old_font);