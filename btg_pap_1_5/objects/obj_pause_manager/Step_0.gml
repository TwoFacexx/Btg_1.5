// Diminuir delay se existir  
// Decrease delay if it exists  
if (delay_input > 0) {
    delay_input--;
}

// Detectar tecla de pausa (ESC ou P) APENAS se delay acabou  
// Detect pause key (ESC or P) ONLY if delay ended  
if ((keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P"))) && delay_input <= 0) {
    
    // Se estiver na tela de opções, voltar para pause  
    // If currently in options screen, return to pause  
    if (pausado && tela_atual == "opcoes") {
        tela_atual = "pause";
        delay_input = 15;
    } else {
        // Lógica normal de pause/unpause  
        // Normal pause/unpause logic  
        var pode_pausar = true;
        
        if (instance_exists(obj_game_control) && obj_game_control.game_over) {
            pode_pausar = false;
        }
        
        if (room == rm_menu || room == rm_conquistas) {
            pode_pausar = false;
        }
        
        if (!pausado && pode_pausar) {
            pausar_jogo();
            delay_input = 15;
        } else if (pausado && tela_atual == "pause") {
            despausar_jogo();
            delay_input = 15;
        }
    }
}

// Se pausado, processar input baseado na tela atual  
// If paused, process input based on current screen  
if (pausado) {
    if (tela_atual == "pause") {
        processar_menu_pausa();
    } else if (tela_atual == "opcoes") {
        processar_menu_opcoes();
    }
}

// Processar popup se estiver ativo  
// Process popup if active  
if (popup_ativo) {
    processar_popup_confirmacao();
}

// ========================================
// FUNÇÕES
// ========================================

// Função para pausar o jogo  
// Function to pause the game  
pausar_jogo = function() {
    pausado = true;
    tela_atual = "pause";
    
    // Capturar frame atual  
    // Capture current frame  
    if (!surface_exists(surf_pause)) {
        var cam = view_camera[0];
        var cam_w = camera_get_view_width(cam);
        var cam_h = camera_get_view_height(cam);
        surf_pause = surface_create(cam_w, cam_h);
    }
    
    if (surface_exists(surf_pause)) {
        surface_set_target(surf_pause);
        draw_clear_alpha(c_black, 0);
        
        with (all) {
            if (visible && object_index != obj_pause_manager) {
                draw_self();
            }
        }
        
        surface_reset_target();
    }
    
    instance_deactivate_all(true);
    instance_activate_object(obj_pause_manager);
    audio_pause_all();
    
    alpha_fundo = 0;
    offset_menu = 100;
}

// Função para despausar o jogo  
// Function to unpause the game  
despausar_jogo = function() {
    pausado = false;
    tela_atual = "pause";
    
    instance_activate_all();
    audio_resume_all();
    
    if (surface_exists(surf_pause)) {
        surface_free(surf_pause);
        surf_pause = -1;
    }
}

// Processar input do menu de pausa  
// Process pause menu input  
processar_menu_pausa = function() {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var centro_x = gui_w / 2;
    var centro_y = gui_h / 2;
    
    var tam_menu = array_length(menu_pausa);
    var espacamento = 70;
    var inicio_y = centro_y - (tam_menu * espacamento) / 2 + offset_menu;
    
    for (var i = 0; i < tam_menu; i++) {
        var pos_y = inicio_y + i * espacamento;
        var wstr = string_width(menu_pausa[i]);
        var hstr = string_height(menu_pausa[i]);
        
        var x1 = centro_x - wstr;
        var y1 = pos_y - hstr/2;
        var x2 = centro_x + wstr;
        var y2 = pos_y + hstr/2;
        
        if (point_in_rectangle(mx, my, x1, y1, x2, y2)) {
            escala_opcoes[i] = lerp(escala_opcoes[i], 1.4, 0.15);
            
            if (mouse_check_button_pressed(mb_left)) {
                switch (i) {
                    case 0: // Continuar  
                        despausar_jogo();
                        break;
                    case 1: // Opções  
                        tela_atual = "opcoes";
                        break;
                    case 2: // Menu Principal                      
                        popup_ativo = true;
                        popup_texto = "Voltar ao menu principal?\n(Progresso será salvo)";
                        popup_alpha = 0;
                        popup_y_offset = 50;
                        popup_opcao_selecionada = 0;
                        break;
                }
            }
        } else {
            escala_opcoes[i] = lerp(escala_opcoes[i], 1, 0.15);
        }
    }
    
    alpha_fundo = lerp(alpha_fundo, 0.8, 0.1);
    offset_menu = lerp(offset_menu, 0, 0.15);
}

// Processar input do menu de opções  
// Process options menu input  
processar_menu_opcoes = function() {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var centro_x = gui_w / 2;
    var centro_y = gui_h / 2;
    
    var tam_menu = array_length(opcoes_menu);
    var espacamento = 70;
    var inicio_y = centro_y - (tam_menu * espacamento) / 2;
    
    for (var i = 0; i < tam_menu; i++) {
        var pos_y = inicio_y + i * espacamento;
        var wstr = string_width(opcoes_menu[i]);
        var hstr = string_height(opcoes_menu[i]);
        
        var x1 = centro_x - wstr;
        var y1 = pos_y - hstr/2;
        var x2 = centro_x + wstr;
        var y2 = pos_y + hstr/2;
        
        if (point_in_rectangle(mx, my, x1, y1, x2, y2)) {
            escala_opcoes_menu[i] = lerp(escala_opcoes_menu[i], 1.4, 0.15);
            
            if (mouse_check_button_pressed(mb_left)) {
                switch (i) {
                    case 0: // Volume Música
                        global.volume_musica += 0.1;
                        if (global.volume_musica > 1.0) global.volume_musica = 0;
                        
                        // Aplicar à música do menu se estiver tocando  
                        if (variable_global_exists("musica_menu_id") && audio_is_playing(global.musica_menu_id)) {
                            audio_sound_gain(global.musica_menu_id, global.volume_musica, 0);
                        }
                        
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
                        window_set_fullscreen(false);
                        window_set_size(res_x, res_y);
                        window_center();
                        save_update_stat("resolucao", resolucoes[resolucao_atual], false);
                        save_game();
                        break;
                        
                    case 3: // Voltar
                        tela_atual = "pause";
                        break;
                }
            }
        } else {
            escala_opcoes_menu[i] = lerp(escala_opcoes_menu[i], 1, 0.15);
        }
    }
}

// Processar popup de confirmação  
// Process confirmation popup  
processar_popup_confirmacao = function() {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var cx = display_get_gui_width() / 2;
    var cy = display_get_gui_height() / 2;
    
    // Animar popup  
    // Animate popup  
    popup_alpha = lerp(popup_alpha, 1, 0.15);
    popup_y_offset = lerp(popup_y_offset, 0, 0.15);
    
    // Processar botões  
    // Process buttons  
    var opcoes = ["SIM", "NÃO"];
    var botao_largura = 80;
    var botao_altura = 40;
    var espacamento = 20;
    
    for (var i = 0; i < 2; i++) {
        var bx = cx - botao_largura - espacamento/2 + i * (botao_largura * 2 + espacamento);
        var by = cy + 40;
        
        if (point_in_rectangle(mx, my, bx - botao_largura/2, by - botao_altura/2, 
                              bx + botao_largura/2, by + botao_altura/2)) {
            popup_escalas[i] = lerp(popup_escalas[i], 1.2, 0.15);
            
            if (mouse_check_button_pressed(mb_left)) {
                if (i == 0) { // SIM
                    save_game();
                    despausar_jogo();
                    global.vida = global.max_vida;
                    room_goto(rm_menu);
                }
                popup_ativo = false;
            }
        } else {
            popup_escalas[i] = lerp(popup_escalas[i], 1, 0.15);
        }
    }
    
    // ESC para cancelar  
    // ESC to cancel  
    if (keyboard_check_pressed(vk_escape)) {
        popup_ativo = false;
    }
}

// Desenhar popup de confirmação  
// Draw confirmation popup  
desenhar_popup_confirmacao = function() {
    // SALVAR configurações atuais  
    // SAVE current settings  
    var old_halign = draw_get_halign();
    var old_valign = draw_get_valign();
    var old_color = draw_get_color();
    var old_alpha = draw_get_alpha();
    var old_font = draw_get_font();
    
    var cx = display_get_gui_width() / 2;
    var cy = display_get_gui_height() / 2 + popup_y_offset;
    
    // Fundo escuro por trás  
    // Dark background behind  
    draw_set_alpha(popup_alpha * 0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // Fundo do popup  
    // Popup background  
    draw_set_alpha(popup_alpha * 0.9);
    draw_set_color(c_black);
    draw_roundrect(cx - 250, cy - 80, cx + 250, cy + 80, false);
    
    // Borda dourada  
    // Golden border  
    draw_set_alpha(popup_alpha);
    draw_set_color(c_yellow);
    draw_roundrect(cx - 250, cy - 80, cx + 250, cy + 80, true);
    
    // Texto da pergunta  
    // Question text  
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(Font1);
    draw_text(cx, cy - 20, popup_texto);
    
    // Botões  
    // Buttons  
    var opcoes = ["SIM", "NÃO"];
    var cores = [c_lime, c_red];
    var botao_largura = 80;
    var botao_altura = 40;
    var espacamento = 20;
    
    for (var i = 0; i < 2; i++) {
        var bx = cx - botao_largura - espacamento/2 + i * (botao_largura * 2 + espacamento);
        var by = cy + 40;
        var escala = popup_escalas[i];
        
        // Fundo do botão  
        // Button background  
        draw_set_color(cores[i]);
        draw_set_alpha(popup_alpha * 0.3);
        draw_roundrect(bx - botao_largura/2 * escala, by - botao_altura/2 * escala,
                      bx + botao_largura/2 * escala, by + botao_altura/2 * escala, false);
        
        // Borda do botão  
        // Button border  
        draw_set_alpha(popup_alpha);
        draw_roundrect(bx - botao_largura/2 * escala, by - botao_altura/2 * escala,
                      bx + botao_largura/2 * escala, by + botao_altura/2 * escala, true);
        
        // Texto do botão  
        // Button text  
        draw_set_color(c_white);
        draw_text_transformed(bx, by, opcoes[i], escala, escala, 0);
    }
    
    // RESTAURAR configurações originais  
    // RESTORE original settings  
    draw_set_halign(old_halign);
    draw_set_valign(old_valign);
    draw_set_color(old_color);
    draw_set_alpha(old_alpha);
    draw_set_font(old_font);
}
