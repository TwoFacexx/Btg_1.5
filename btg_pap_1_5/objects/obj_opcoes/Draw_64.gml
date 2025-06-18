draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(opcoes); i++) {
    var y_pos = display_get_gui_height() / 2 - 60 + i * 40;

    // Realça a opção se o cursor estiver sobre ela
    if (point_in_rectangle(_mx, _my, display_get_gui_width() / 2 - 100, y_pos - 20, display_get_gui_width() / 2 + 100, y_pos + 20)) {
        draw_text_transformed(display_get_gui_width() / 2, y_pos, opcoes[i], 1.2, 1.2, 0);
        if (mouse_check_button_pressed(mb_left)) {
            opcao_selecionada = i;
            switch (i) {
                case 0: // Ajuste de volume
                    volume = (volume + 1) % 11; // Aumenta o volume de 0 a 10
                    break;
                case 1: // Alterna resoluções
                    resolucao_atual = (resolucao_atual + 1) % array_length(resolucoes);
                    var res = resolucoes[resolucao_atual];
                    var res_x = real(string_copy(res, 1, string_pos("x", res) - 1));
                    var res_y = real(string_copy(res, string_pos("x", res) + 1, string_length(res)));
                    display_set_gui_size(res_x, res_y);
                    break;
                case 2: // Voltar ao menu principal
                    room_goto(rm_menu);
                    break;
				
					
            }
        }
    } else {
        draw_text(display_get_gui_width() / 2, y_pos, opcoes[i]);
    }
}

// Exibe o valor do volume e da resolução atual
draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2 + 80, "Volume: " + string(volume));
draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2 + 120, "Resolução: " + resolucoes[resolucao_atual]);

//draw_set_font(-1)
