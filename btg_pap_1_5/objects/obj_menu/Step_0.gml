// Processar popup se estiver ativo
// Process popup if it is active
if (popup_novo_jogo_ativo) {
    processar_popup_novo_jogo();
}

processar_popup_novo_jogo = function() {
    var mx = device_mouse_x_to_gui(0); // Posição X do rato em coordenadas GUI / Mouse X position in GUI coordinates
    var my = device_mouse_y_to_gui(0); // Posição Y do rato em coordenadas GUI / Mouse Y position in GUI coordinates
    var cx = display_get_gui_width() / 2; // Centro do ecrã em X / Screen center X
    var cy = display_get_gui_height() / 2; // Centro do ecrã em Y / Screen center Y
    
    // Animar popup (desvanecer e deslizar para posição final)
    // Animate popup (fade in and slide to final position)
    popup_novo_jogo_alpha = lerp(popup_novo_jogo_alpha, 1, 0.15);
    popup_novo_jogo_y_offset = lerp(popup_novo_jogo_y_offset, 0, 0.15);
    
    // Processar botões do popup
    // Process popup buttons
    var opcoes = ["SIM", "NÃO"]; // Opções disponíveis / Available options
    var botao_largura = 80;      // Largura dos botões / Button width
    var botao_altura = 40;       // Altura dos botões / Button height
    var espacamento = 20;        // Espaçamento entre botões / Spacing between buttons
    
    for (var i = 0; i < 2; i++) {
        // Calcular posição de cada botão / Calculate button position
        var bx = cx - botao_largura - espacamento/2 + i * (botao_largura * 2 + espacamento);
        var by = cy + 40;
        
        // Se o rato está em cima do botão / If mouse is over the button
        if (point_in_rectangle(mx, my, bx - botao_largura/2, by - botao_altura/2, bx + botao_largura/2, by + botao_altura/2)) {
            popup_novo_jogo_escalas[i] = lerp(popup_novo_jogo_escalas[i], 1.2, 0.15);
            
            if (mouse_check_button_pressed(mb_left)) {
                if (i == 0) { // SIM
                    global.novo_jogo_flag = true; // Marcar que é um novo jogo / Mark as new game
                    
                    // Resetar dados antes de iniciar o novo jogo / Reset game data before starting
                    global.moedas_total = 0;
                    global.porcos_mortos_total = 0;
                    global.vida = global.max_vida;
                    global.nivel_atual = 1;
                    
                    delete_save(); // Apagar o save anterior / Delete old save
                    
                    room_goto_next(); // Ir para o próximo nível / Go to next room
                }
                
                popup_novo_jogo_ativo = false; // Fechar o popup / Close popup
            }
        } else {
            popup_novo_jogo_escalas[i] = lerp(popup_novo_jogo_escalas[i], 1, 0.15); 
            // Resetar a escala visual do botão / Reset button scale
        }
    }
    
    // Se o jogador pressionar ESC, cancelar o popup
    // Cancel popup if player presses ESC
    if (keyboard_check_pressed(vk_escape)) {
        popup_novo_jogo_ativo = false;
    }
}

desenhar_popup_novo_jogo = function() {
    // Guardar configurações de desenho atuais
    // Save current drawing settings
    var old_halign = draw_get_halign();
    var old_valign = draw_get_valign();
    var old_color = draw_get_color();
    var old_alpha = draw_get_alpha();
    var old_font = draw_get_font();
    
    var cx = display_get_gui_width() / 2; // Centro do ecrã em X / Screen center X
    var cy = display_get_gui_height() / 2 + popup_novo_jogo_y_offset; // Centro Y ajustado com offset / Center Y adjusted with offset
    
    // Fundo escuro semi-transparente por trás
    // Semi-transparent dark background
    draw_set_alpha(popup_novo_jogo_alpha * 0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // Fundo do popup
    // Popup background
    draw_set_alpha(popup_novo_jogo_alpha * 0.9);
    draw_set_color(c_black);
    draw_roundrect(cx - 250, cy - 80, cx + 250, cy + 80, false);
    
    // Borda dourada do popup
    // Popup golden border
    draw_set_alpha(popup_novo_jogo_alpha);
    draw_set_color(c_yellow);
    draw_roundrect(cx - 250, cy - 80, cx + 250, cy + 80, true);
    
    // Texto da pergunta ao jogador
    // Confirmation text
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(Font1);
    draw_text(cx, cy - 20, "Isso apagará o progresso anterior.\nContinuar?");
    
    // Botões SIM e NÃO
    // YES and NO buttons
    var opcoes = ["SIM", "NÃO"];
    var cores = [c_lime, c_red];
    var botao_largura = 80;
    var botao_altura = 40;
    var espacamento = 20;
    
    for (var i = 0; i < 2; i++) {
        var bx = cx - botao_largura - espacamento/2 + i * (botao_largura * 2 + espacamento);
        var by = cy + 40;
        var escala = popup_novo_jogo_escalas[i];
        
        // Fundo do botão
        // Button background
        draw_set_color(cores[i]);
        draw_set_alpha(popup_novo_jogo_alpha * 0.3);
        draw_roundrect(bx - botao_largura/2 * escala, by - botao_altura/2 * escala, bx + botao_largura/2 * escala, by + botao_altura/2 * escala, false);
        
        // Borda do botão
        // Button border
        draw_set_alpha(popup_novo_jogo_alpha);
        draw_roundrect(bx - botao_largura/2 * escala, by - botao_altura/2 * escala, bx + botao_largura/2 * escala, by + botao_altura/2 * escala, true);
        
        // Texto do botão
        // Button text
        draw_set_color(c_white);
        draw_text_transformed(bx, by, opcoes[i], escala, escala, 0);
    }
    
    // Restaurar as configurações originais de desenho
    // Restore original drawing settings
    draw_set_halign(old_halign);
    draw_set_valign(old_valign);
    draw_set_color(old_color);
    draw_set_alpha(old_alpha);
    draw_set_font(old_font);
}
