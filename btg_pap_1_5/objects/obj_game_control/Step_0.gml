if (game_over) {
    global.vel_mult = 0.5; // Aplicar efeito de slowmotion // Apply slow motion effect
    
    // APENAS controlo manual se esta opção estiver ativa // ONLY manual control if this option is active
    // Descomente APENAS se usar reinício manual no player // Uncomment ONLY if manual restart is used in player
    // if (keyboard_check_pressed(vk_enter)) {
    //     game_restart();
    // }
} else {
    global.vel_mult = 1; // Voltar à velocidade normal // Return to normal speed
}

// Verificar input para reiniciar // Check input to restart
if (game_over && keyboard_check_pressed(vk_enter)) {
    game_restart(); // Reiniciar o jogo // Restart the game
}

// Save automático // Auto save
save_timer++; // Incrementar o temporizador // Increase timer
if (save_timer >= save_interval) {
    save_game(); // Guardar o jogo // Save the game
    mostrar_popup_save(); // Mostrar popup de save // Show save popup
    save_timer = 0; // Reiniciar temporizador // Reset timer
}

// Atualizar tempo total de jogo // Update total play time
global.tempo_total_jogado += delta_time / 1000000; // Acrescentar tempo total jogado // Add to total play time
global.tempo_sessao += delta_time / 1000000; // Acrescentar tempo da sessão atual // Add to current session time

// Guardar jogo ao pressionar tecla "S" // Save game on pressing "S"
if (keyboard_check_pressed(ord("S"))) {
    save_game(); // Guardar o jogo // Save the game
    // Ativar popup ao invés de show_message // Activate popup instead of show_message
    popup_save_ativo = true;
    popup_save_alpha = 0;
    popup_save_y_offset = 50;
    popup_save_timer = 0;
}

// Processar popup de save // Handle save popup animation
if (popup_save_ativo) {
    popup_save_alpha = lerp(popup_save_alpha, 1, 0.1); // Aumentar alpha suavemente // Smoothly increase alpha
    popup_save_y_offset = lerp(popup_save_y_offset, 0, 0.1); // Suavizar movimento vertical // Smooth vertical movement
    
    popup_save_timer++; // Contar duração do popup // Count popup duration
    if (popup_save_timer >= popup_save_duracao) {
        popup_save_ativo = false; // Ocultar popup após o tempo limite // Hide popup after timeout
    }
}

// Carregar jogo ao pressionar tecla "L" // Load game on pressing "L"
if (keyboard_check_pressed(ord("L"))) {
    if (load_game()) {
        show_message("Jogo Carregado!"); // Mensagem de confirmação // Confirmation message
    }
}

// Resetar save ao pressionar tecla "R" // Reset save on pressing "R"
if (keyboard_check_pressed(ord("R"))) {
    if (show_question("Resetar save?")) { // Perguntar confirmação // Ask for confirmation
        delete_save(); // Apagar ficheiro de save // Delete save file
        show_message("Save deletado!"); // Mensagem de confirmação // Confirmation message
    }
}

// Função para ativar popup de save // Function to activate save popup
mostrar_popup_save = function() {
    popup_save_ativo = true; // Ativar popup // Activate popup
    popup_save_alpha = 0; // Iniciar com alpha zero // Start with zero alpha
    popup_save_y_offset = 50; // Começar deslocado verticalmente // Start vertically offset
    popup_save_timer = 0; // Reiniciar temporizador do popup // Reset popup timer
}

// Função para desenhar popup de save // Function to draw save popup
desenhar_popup_save = function() {
    // SALVAR configurações atuais // SAVE current draw settings
    var old_halign = draw_get_halign(); // Alinhamento horizontal anterior // Previous horizontal alignment
    var old_valign = draw_get_valign(); // Alinhamento vertical anterior // Previous vertical alignment
    var old_color = draw_get_color(); // Cor anterior // Previous color
    var old_alpha = draw_get_alpha(); // Transparência anterior // Previous alpha
    var old_font = draw_get_font(); // Fonte anterior // Previous font
    
    var cx = display_get_gui_width() / 2; // Centro horizontal do ecrã GUI // GUI screen horizontal center
    var cy = display_get_gui_height() / 2 + popup_save_y_offset; // Centro vertical ajustado // Adjusted vertical center
    
    // Fundo do popup // Popup background
    draw_set_alpha(popup_save_alpha * 0.9); // Definir transparência // Set transparency
    draw_set_color(c_black); // Cor preta de fundo // Black background color
    draw_roundrect(cx - 150, cy - 40, cx + 150, cy + 40, false); // Desenhar retângulo arredondado // Draw rounded rectangle
    
    // Borda verde (indicando sucesso) // Green border (indicates success)
    draw_set_alpha(popup_save_alpha); // Restaurar alpha // Restore alpha
    draw_set_color(c_lime); // Cor da borda verde // Lime border color
    draw_roundrect(cx - 150, cy - 40, cx + 150, cy + 40, true); // Desenhar borda do retângulo // Draw rectangle border
    
    // Texto // Text
    draw_set_color(c_white); // Cor branca do texto // White text color
    draw_set_halign(fa_center); // Alinhar ao centro horizontalmente // Horizontally center aligned
    draw_set_valign(fa_middle); // Alinhar ao centro verticalmente // Vertically center aligned
    draw_set_font(Font1); // Usar fonte definida // Use specific font
    draw_text(cx, cy, "Jogo Salvo!"); // Escrever mensagem de sucesso // Draw success message
    
    // RESTAURAR configurações originais // RESTORE original draw settings
    draw_set_halign(old_halign); // Restaurar alinhamento horizontal // Restore horizontal alignment
    draw_set_valign(old_valign); // Restaurar alinhamento vertical // Restore vertical alignment
    draw_set_color(old_color); // Restaurar cor anterior // Restore previous color
    draw_set_alpha(old_alpha); // Restaurar alpha anterior // Restore previous alpha
    draw_set_font(old_font); // Restaurar fonte anterior // Restore previous font
}
