if (game_over) {
    contador = lerp(contador, 1, 0.01); 
    // Suaviza o valor do contador até 1 para a transição // Smooth the contador value toward 1 for transition
    
    draw_set_alpha(contador); 
    // Define a transparência do desenho conforme o contador // Set the draw alpha according to contador
    
    var x1 = camera_get_view_x(view_camera[0]); 
    // Posição X da vista da câmara principal // X position of the main camera view
    
    var w = camera_get_view_width(view_camera[0]); 
    // Largura da vista da câmara principal // Width of the main camera view
    
    var x2 = x1 + w; 
    // Posição final X da vista da câmara // End X position of the camera view
    
    var meio_w = x1 + w / 2; 
    // Ponto médio horizontal da vista da câmara // Horizontal midpoint of the camera view
    
    var y1 = camera_get_view_y(view_camera[0]); 
    // Posição Y da vista da câmara principal // Y position of the main camera view
    
    var h = camera_get_view_height(view_camera[0]); 
    // Altura da vista da câmara principal // Height of the main camera view
    
    var y2 = y1 + h; 
    // Posição final Y da vista da câmara // End Y position of the camera view
    
    var meio_h = y1 + h / 2; 
    // Ponto médio vertical da vista da câmara // Vertical midpoint of the camera view
    
    var quant = h * 0.15; 
    // Quantidade para barras superior e inferior, baseado na altura da câmara // Amount for top and bottom bars based on camera height
    
    valor = lerp(valor, 1, 0.1); 
    // Suaviza o valor até 1 para animação // Smooth value to 1 for animation
    
    // Fundo escuro
    draw_set_color(c_black); 
    // Define a cor preta para o fundo // Set black color for the background
    
    draw_set_alpha(valor - 0.3); 
    // Ajusta a transparência do fundo // Adjust background transparency
    
    draw_rectangle(x1, y1, x2, y2, false); 
    // Desenha um retângulo preenchido para o fundo // Draw a filled rectangle for the background
    
    // Barras superior e inferior
    draw_rectangle(x1, y1, x2, y1 + quant * valor, false); 
    // Desenha a barra superior // Draw the top bar
    
    draw_rectangle(x1, y2, x2, y2 - quant * valor, false); 
    // Desenha a barra inferior // Draw the bottom bar
    
    draw_set_alpha(1); 
    // Restaura a transparência para o máximo // Restore alpha to full
    
    draw_set_color(c_white); 
    // Define a cor branca para o texto // Set white color for the text
    
    if (valor > 0.5) {
        // Quando o valor está acima de 0.5, mostra o texto principal
        
        draw_set_font(fnt_gover); 
        // Define a fonte para o título de game over // Set font for the game over title
        
        draw_set_valign(fa_middle); 
        // Alinha verticalmente ao centro // Vertically center aligned
        
        draw_set_halign(fa_center); 
        // Alinha horizontalmente ao centro // Horizontally center aligned
        
        draw_set_color(c_black); 
        // Cor preta para a sombra do texto // Black color for text shadow
        
        draw_text(meio_w + 3, meio_h + 3, "G a m e - O v e r"); 
        // Desenha a sombra do texto com ligeiro deslocamento // Draw shadow text with slight offset
        
        draw_set_color(c_white); 
        // Cor branca para o texto principal // White color for the main text
        
        draw_text(meio_w, meio_h, "G a m e - O v e r"); 
        // Desenha o texto principal // Draw the main text
        
        draw_set_font(Font5); 
        // Define uma fonte menor para instruções // Set smaller font for instructions
        
        draw_set_color(c_ltgray); 
        // Cor cinza clara para o texto das instruções // Light gray color for instructions text
        
        if (instance_exists(obj_player)) {
            if (obj_player.modo_reinicio == "automatico") {
                var tempo_restante = ceil(obj_player.timer_reinicia / room_speed); 
                // Calcula o tempo restante para reinício automático
                
                draw_text(meio_w, meio_h + 50, "Reiniciando em " + string(tempo_restante) + "..."); 
                // Mostra o contador regressivo de reinício automático
            } else {
                var alpha_texto = 0.7 + sin(current_time * 0.005) * 0.3; 
                // Alpha variável para efeito de piscar no texto
                
                draw_set_alpha(alpha_texto); 
                // Define a transparência para o texto piscante
                
                draw_text(meio_w, meio_h + 50, "Pressione ENTER para recomeçar"); 
                // Mostra instrução para reinício manual
                
                draw_set_alpha(1); 
                // Restaura a transparência total
            }
        }
        
        // Resetar configurações de alinhamento e fonte
        draw_set_valign(fa_top); 
        draw_set_halign(fa_left); 
        draw_set_font(-1); 
        draw_set_color(c_white); 
        draw_set_alpha(1);
    }
} else {
    valor = 0; 
    contador = 0; 
    // Resetar variáveis quando não estiver em game over
}
