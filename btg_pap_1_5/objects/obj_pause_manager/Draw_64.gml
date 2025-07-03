// Só mostrar HUD nas rooms de jogo (não no menu)  
// Only show HUD in game rooms (not in menu)  
if (room == rm_menu || room == rm_opcoes || room == rm_conquistas) {
    exit; // Sair sem desenhar nada  
          // Exit without drawing anything  
}
if (!pausado) exit; // Se não estiver pausado, sair  
                    // If not paused, exit

var gui_w = display_get_gui_width();  // Largura da GUI  
                                     // GUI width  
var gui_h = display_get_gui_height(); // Altura da GUI  
                                     // GUI height  
var centro_x = gui_w / 2;              // Centro horizontal  
                                     // Horizontal center  
var centro_y = gui_h / 2;              // Centro vertical  
                                     // Vertical center  

// Salvar configurações atuais de desenho  
// Save current drawing settings  
var old_font = draw_get_font();
var old_halign = draw_get_halign();
var old_valign = draw_get_valign();
var old_color = draw_get_color();
var old_alpha = draw_get_alpha();

// ===== JOGO PAUSADO DE FUNDO =====  
// ===== PAUSED GAME BACKGROUND =====  
if (surface_exists(surf_pause)) {
    draw_set_alpha(0.3);              // Definir alpha para 30%  
                                     // Set alpha to 30%  
    draw_surface(surf_pause, 0, 0);   // Desenhar a surface de pausa no canto superior esquerdo  
                                     // Draw pause surface at top-left corner  
}

// ===== FUNDO ESCURO =====  
// ===== DARK BACKGROUND =====  
draw_set_alpha(alpha_fundo * 0.7);   // Alpha do fundo multiplicado  
                                    // Background alpha multiplied  
draw_set_color(c_black);             // Cor preta  
                                    // Black color  
draw_rectangle(0, 0, gui_w, gui_h, false); // Desenhar rectângulo que cobre toda a tela  
                                           // Draw rectangle covering whole screen  

// ===== DESENHAR BASEADO NA TELA ATUAL =====  
// ===== DRAW BASED ON CURRENT SCREEN =====  
draw_set_alpha(1);                   // Reset alpha para 100%  
                                    // Reset alpha to 100%  
draw_set_halign(fa_center);          // Alinhamento horizontal centro  
                                    // Horizontal align center  
draw_set_valign(fa_middle);          // Alinhamento vertical meio  
                                    // Vertical align middle  

if (tela_atual == "pause") {
    // ===== TELA PAUSE =====  
    // ===== PAUSE SCREEN =====  
    draw_set_font(fnt_titulo);       // Fonte do título  
                                    // Title font  
    draw_set_color(c_black);         // Cor preta para sombra  
                                    // Black color for shadow  
    draw_text(centro_x + 3, centro_y - 180 + 3, "PAUSADO"); // Sombra  
                                                         // Shadow  
    draw_set_color(c_white);         // Cor branca para texto principal  
                                    // White color for main text  
    draw_text(centro_x, centro_y - 180, "PAUSADO"); // Texto "PAUSADO"  
                                                    // Text "PAUSADO"  

    draw_set_font(Font1);            // Fonte normal para opções  
                                    // Normal font for options  
    var tam_menu = array_length(menu_pausa); // Tamanho do menu  
                                             // Menu size  
    var espacamento = 70;            // Espaçamento vertical entre opções  
                                    // Vertical spacing between options  
    var inicio_y = centro_y - (tam_menu * espacamento) / 2 + offset_menu; // Posição inicial Y  
                                                                       // Initial Y position  

    for (var i = 0; i < tam_menu; i++) {
        var pos_y = inicio_y + i * espacamento; // Posição Y da opção  
                                               // Option Y position  
        var escala = escala_opcoes[i];          // Escala atual para animação  
                                               // Current scale for animation  

        if (escala > 1.2) {
            draw_set_color(c_yellow);           // Se em hover, cor amarela  
                                               // If hovered, yellow color  
        } else {
            draw_set_color(c_white);            // Caso contrário, branco  
                                               // Otherwise, white  
        }
        draw_text_transformed(centro_x, pos_y, menu_pausa[i], escala, escala, 0); // Desenhar texto com escala  
                                                                                 // Draw text with scale  
    }

} else if (tela_atual == "opcoes") {
    // ===== TELA OPÇÕES =====  
    // ===== OPTIONS SCREEN =====  
    draw_set_font(fnt_titulo);
    draw_set_color(c_black);
    draw_text(centro_x + 3, centro_y - 220 + 3, "OPÇÕES"); // Sombra  
                                                           // Shadow  
    draw_set_color(c_white);
    draw_text(centro_x, centro_y - 220, "OPÇÕES");         // Texto "OPÇÕES"  
                                                           // Text "OPÇÕES"  

    draw_set_font(Font1);
    var tam_menu = array_length(opcoes_menu);
    var espacamento = 70;
    var inicio_y = centro_y - (tam_menu * espacamento) / 2;

    for (var i = 0; i < tam_menu; i++) {
        var pos_y = inicio_y + i * espacamento;
        var escala = escala_opcoes_menu[i];

        if (escala > 1.2) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }
        draw_text_transformed(centro_x, pos_y, opcoes_menu[i], escala, escala, 0);
    }
    
    // ===== VALORES ATUAIS =====  
    // ===== CURRENT VALUES =====  
    draw_set_font(Font2);
    draw_set_color(c_gray);
    draw_text(centro_x, gui_h - 120, "Vol. Música: " + string(round(global.volume_musica * 100)) + "%");
    draw_text(centro_x, gui_h - 90, "Vol. SFX: " + string(round(global.volume_sfx * 100)) + "%");
    draw_text(centro_x, gui_h - 60, "Resolução: " + resolucoes[resolucao_atual]);
}

// ===== POPUP DE CONFIRMAÇÃO =====  
// ===== CONFIRMATION POPUP =====  
if (popup_ativo) {
    desenhar_popup_confirmacao();
}

// ===== INSTRUÇÕES =====  
// ===== INSTRUCTIONS =====  
draw_set_font(Font2);
draw_set_color(c_gray);
if (tela_atual == "pause") {
    draw_text(centro_x, gui_h - 40, "ESC/P - Pausar | Mouse - Navegar | Clique - Selecionar");
} else {
    draw_text(centro_x, gui_h - 40, "ESC - Voltar | Mouse - Navegar | Clique - Alterar");
}

// Restaurar configurações originais de desenho  
// Restore original drawing settings  
draw_set_font(old_font);
draw_set_halign(old_halign);
draw_set_valign(old_valign);
draw_set_color(old_color);
draw_set_alpha(old_alpha);
