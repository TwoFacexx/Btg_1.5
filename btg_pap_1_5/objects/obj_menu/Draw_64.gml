// Alinhamento do texto
// Text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Pegando dimensões da GUI e posição do mouse
// Get GUI dimensions and mouse position
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();

// ===== TÍTULO =====
// ===== TITLE =====
draw_set_font(fnt_titulo); // Fonte estilo Pirate One, tamanho ~70 / Pirate One font, size ~70
draw_set_color(c_white);
draw_text(_wgui / 2, _hgui * 0.10, "Super Bogalho");

// ===== SUBTÍTULO =====
// ===== SUBTITLE =====
draw_set_font(ftn_sub); // Fonte estilo Bangers, tamanho ~36 / Bangers font, size ~36
draw_text(_wgui / 2, _hgui * 0.19, "Echoes of the Hat");

// ===== MENU =====
// ===== MENU =====
draw_set_font(Font1); // Fonte Bangers para opções, tamanho ~32 / Bangers font for options, size ~32
draw_set_color(c_white);

var tam_menu = array_length(menu_inicial); 
// Número de opções no menu / Number of menu options

var _hstr = string_height("I"); 
// Altura de uma letra, usado para medir o espaçamento / Character height, used for spacing

var _spacing = _hstr * 2;    
// Espaçamento vertical aumentado / Increased vertical spacing

var offset_y = (_spacing * tam_menu) / 2; 
// Centralizar o menu verticalmente / Center menu vertically

var menu_top_y = (_hgui / 2 - offset_y + 20); 
// Sobe o menu 20px a mais / Move menu 20px upwards

for (var i = 0; i < tam_menu; i++) {
    var _wstr = string_width(menu_inicial[i]); 
    // Largura do texto da opção atual / Width of current menu option text
    
    var x1 = _wgui / 2 - _wstr * 2;
    var y1 = menu_top_y + _spacing * i;
    var x2 = _wgui / 2 + _wstr * 2;
    var y2 = y1 + _hstr;

    // Interação com o mouse
    // Mouse hover interaction
    if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
        esc[i] = lerp(esc[i], 1.4, 0.15); 
        // Efeito de aumentar o botão ao passar o rato / Button grows when hovered
        
        if (mouse_check_button_pressed(mb_left)) {
            // Se clicar no botão esquerdo do rato / If left mouse button is pressed
            switch (menu_inicial[i]) {
                
                case "Continuar":
                    // Carregar dados
                    // Load saved data
                    if (load_game()) {
                        // Ir para o nível salvo
                        // Go to saved level
                        switch(global.nivel_atual) {
                            case 1: room_goto(rm_nivel01); break;
                            case 2: room_goto(rm_nivel02); break;
                            default: room_goto(rm_nivel01); 
                        }
                    }
                break;
                
                case "Novo Jogo":
                    // Se houver save, perguntar
                    // If save exists, show confirmation popup
                    if (save_exists()) {
                        popup_novo_jogo_ativo = true;
                        popup_novo_jogo_alpha = 0;
                        popup_novo_jogo_y_offset = 50;
                    } else {
                        // Novo jogo sem save existente
                        // Start new game without existing save
                        global.novo_jogo_flag = true;
                        global.moedas_total = 0;
                        global.porcos_mortos_total = 0;
                        global.vida = global.max_vida;
                        global.nivel_atual = 1;
                        
                        room_goto_next(); // Ir para o jogo / Go to next room
                    }
                break;
                
                case "Opções":
                    room_goto(rm_opcoes);
                    // Ir para o menu de opções / Go to options menu
                break;

                case "Conquistas":
                    room_goto(rm_conquistas);
                    // Ir para o menu de conquistas / Go to achievements menu
                break;
                
                case "Sair":
                    game_end();
                    // Fechar o jogo / Exit the game
                break;
            }
        }
    } else {
        esc[i] = lerp(esc[i], 1, 0.15); 
        // Efeito de reduzir o botão quando não está selecionado / Shrink button when not hovered
    }

    // Desenhar o texto do botão com escala / Draw button text with scale
    draw_text_transformed(_wgui / 2, y1 + _hstr / 2, menu_inicial[i], esc[i], esc[i], 0);
}

// ===== POPUP DE CONFIRMAÇÃO =====
// ===== CONFIRMATION POPUP =====
if (popup_novo_jogo_ativo) {
    desenhar_popup_novo_jogo();
    // Desenhar o popup de novo jogo se estiver ativo / Draw new game popup if active
}

// ===== CRÉDITOS =====
// ===== CREDITS =====
draw_set_font(Font2);
draw_set_color(c_white);
draw_text(1185, 690, "Mead Games");
// Nome da empresa criadora no canto inferior direito
// Company name in bottom-right corner

// Reset da fonte
// Reset font
draw_set_font(-1);

// Reset da fonte (linha duplicada mas sem problema técnico)
// Reset font (duplicated line but no technical issue)
draw_set_font(-1);
