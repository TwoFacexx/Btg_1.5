// Alinhamento do texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Pegando dimensões da GUI e posição do mouse
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();

// ===== TÍTULO =====
draw_set_font(fnt_titulo); // Fonte estilo Pirate One, tamanho ~70
draw_set_color(c_white);
draw_text(_wgui / 2, _hgui * 0.10, "Super Bogalho");

// ===== SUBTÍTULO =====
draw_set_font(ftn_sub); // Fonte estilo Bangers, tamanho ~36
draw_text(_wgui / 2, _hgui * 0.19, "Echoes of the Hat");

// ===== MENU =====
draw_set_font(Font1); // Fonte Bangers para opções, tamanho ~32
draw_set_color(c_white);

var tam_menu = array_length(menu_inicial);
var _hstr = string_height("I"); // Altura da fonte do menu
var _spacing = _hstr * 1.7;     // Espaçamento vertical aumentado
var offset_y = (_spacing * tam_menu) / 2;
var menu_top_y = (_hgui / 2 - offset_y - 60); // Sobe o menu 60px a mais

for (var i = 0; i < tam_menu; i++) {
    var _wstr = string_width(menu_inicial[i]);
    var x1 = _wgui / 2 - _wstr * 2;
    var y1 = menu_top_y + _spacing * i;
    var x2 = _wgui / 2 + _wstr * 2;
    var y2 = y1 + _hstr;

    // Interação com o mouse
    if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
        esc[i] = lerp(esc[i], 1.4, 0.15);

        if (mouse_check_button_pressed(mb_left)) {
            switch (menu_inicial[i]) {
                case "Jogar":
                    room_goto_next();
                    break;
                case "Opções":
                    room_goto(rm_opcoes);
                    break;
                case "Sair":
                    game_end();
                    break;
            }
        }
    } else {
        esc[i] = lerp(esc[i], 1, 0.15);
    }

    draw_text_transformed(_wgui / 2, y1 + _hstr / 2, menu_inicial[i], esc[i], esc[i], 0);
}

// ===== CRÉDITOS =====
draw_set_font(Font2); // Fonte pequena para créditos (16-20px)
draw_set_color(c_white);
draw_text(1185, 670, "Mead Games");

// Reset da fonte
draw_set_font(-1);
