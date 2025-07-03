draw_set_font(Font1);
// pt-PT: Define a fonte para o texto do menu  
// EN: Sets the font for the menu text

draw_set_halign(fa_center);
// pt-PT: Alinha o texto horizontalmente ao centro  
// EN: Aligns the text horizontally to center

draw_set_valign(fa_middle);
// pt-PT: Alinha o texto verticalmente ao meio  
// EN: Aligns the text vertically to middle

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
// pt-PT: Posição do rato convertida para coordenadas GUI  
// EN: Mouse position converted to GUI coordinates

var wgui = display_get_gui_width();
var hgui = display_get_gui_height();
// pt-PT: Largura e altura da área GUI do ecrã  
// EN: Width and height of the GUI display area

// ===== TÍTULO =====
// ===== TITLE =====
draw_set_color(c_white);
// pt-PT: Define a cor do texto como branco  
// EN: Sets text color to white

draw_text(wgui / 2, 80, "OPÇÕES");
// pt-PT: Desenha o título "OPÇÕES" centrado no topo  
// EN: Draws the title "OPTIONS" centered at the top

// ===== OPÇÕES DO MENU =====
// ===== MENU OPTIONS =====
var opcoes_completas = ["Volume Música", "Volume SFX", "Resolução", "Voltar"];
// pt-PT: Lista completa de opções para o menu  
// EN: Full list of options for the menu

for (var i = 0; i < array_length(opcoes_completas); i++) {
    var y_pos = 180 + i * 70; // Espaçamento de 70px  
    // pt-PT: Calcula a posição vertical para cada opção  
    // EN: Calculates vertical position for each option

    var hover = point_in_rectangle(mx, my, wgui / 2 - 150, y_pos - 25, wgui / 2 + 150, y_pos + 25);
    // pt-PT: Verifica se o rato está a "hover" sobre a opção  
    // EN: Checks if the mouse is hovering over the option
    
    if (hover) {
        // ===== OPÇÃO COM HOVER =====
        // ===== OPTION WITH HOVER =====
        draw_set_color(c_yellow);
        // pt-PT: Muda a cor do texto para amarelo quando em hover  
        // EN: Changes text color to yellow when hovered

        draw_text_transformed(wgui / 2, y_pos, opcoes_completas[i], 1.2, 1.2, 0);
        // pt-PT: Desenha o texto com escala aumentada para destacar  
        // EN: Draws the text scaled up to highlight

        // ===== PROCESSAR CLIQUE =====
        // ===== PROCESS CLICK =====
        if (mouse_check_button_pressed(mb_left)) {
            switch (i) {
                case 0: // Volume Música
                    global.volume_musica += 0.1;
                    if (global.volume_musica > 1.0) global.volume_musica = 0;
                    audio_master_gain(global.volume_musica);
                    save_update_stat("volume_musica", global.volume_musica, false);
                    save_game();
                    break;

                case 1: // Volume SFX
                    global.volume_sfx += 0.1;
                    if (global.volume_sfx > 1.0) global.volume_sfx = 0;
                    save_update_stat("volume_sfx", global.volume_sfx, false);
                    save_game();
                    break;

                case 2: // Resolução
                    resolucao_atual = (resolucao_atual + 1) % array_length(resolucoes);
                    var res = resolucoes[resolucao_atual];
                    var res_x = real(string_copy(res, 1, string_pos("x", res) - 1));
                    var res_y = real(string_copy(res, string_pos("x", res) + 1, string_length(res)));
                    window_set_size(res_x, res_y);
                    save_update_stat("resolucao", resolucoes[resolucao_atual], false);
                    save_game();
                    break;

                case 3: // Voltar
                    room_goto(rm_menu);
                    break;
            } // FECHAR switch  
            // CLOSE switch
        } // FECHAR if (mouse_check_button_pressed)  
        // CLOSE if (mouse_check_button_pressed)
    } else {
        // ===== OPÇÃO SEM HOVER =====
        // ===== OPTION WITHOUT HOVER =====
        draw_set_color(c_white);
        // pt-PT: Texto branco para opções não selecionadas  
        // EN: White text for non-hovered options
        draw_text(wgui / 2, y_pos, opcoes_completas[i]);
    } // FECHAR if (hover)
} // FECHAR for

// ===== VALORES ATUAIS DAS CONFIGURAÇÕES =====
// ===== CURRENT SETTINGS VALUES =====
draw_set_color(c_gray);
draw_set_font(Font2); // Fonte menor para os valores  
// pt-PT: Define fonte menor para mostrar os valores atuais  
// EN: Sets smaller font to display current values

draw_text(wgui / 2, hgui / 2 + 120, "Vol. Música: " + string(round(global.volume_musica * 100)) + "%");
draw_text(wgui / 2, hgui / 2 + 150, "Vol. SFX: " + string(round(global.volume_sfx * 100)) + "%");
draw_text(wgui / 2, hgui / 2 + 180, "Resolução: " + resolucoes[resolucao_atual]);
// pt-PT: Desenha os valores atuais das opções na parte inferior do ecrã  
// EN: Draws the current option values near the bottom of the screen

// ===== RESET CONFIGURAÇÕES DE DRAW =====
// ===== RESET DRAW SETTINGS =====
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
// pt-PT: Restaura as configurações de desenho para o padrão  
// EN: Resets drawing settings to default
