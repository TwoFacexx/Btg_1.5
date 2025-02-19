draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();
var _hstr = string_height("I");
var tam_menu = array_length(menu_inicial);
var offset_y = (_hstr * tam_menu) / 2;

// Desenhando as opções do menu
for (var i = 0; i < tam_menu; i++) {
    var _wstr = string_width(menu_inicial[i]);
    var x1 = _wgui / 2 - _wstr * 2;
    var y1 = (_hgui / 2 - offset_y) + _hstr * i;
    var x2 = _wgui / 2 + _wstr * 2;
    var y2 = y1 + _hstr;

    // Interação do mouse
    if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
        esc[i] = lerp(esc[i], 1.4, 0.15);
        
        if (mouse_check_button_pressed(mb_left)) {
            switch (menu_inicial[i]) {
                case "Jogar":
                    room_goto_next();
                    break;
                case "Opções":
                    room_goto(Room5);
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

// Créditos no rodapé
draw_set_font(Font2);
draw_text(1185, 670, "Mead Games"); 
draw_set_font(-1);
