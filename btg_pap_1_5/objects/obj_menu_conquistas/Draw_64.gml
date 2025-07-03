var _old_font = draw_get_font();
var _old_halign = draw_get_halign();
var _old_valign = draw_get_valign();
var _old_color = draw_get_color();
var _old_alpha = draw_get_alpha();
// Guardar as definições de desenho atuais (fonte, alinhamento, cor, transparência)
// Save current drawing settings (font, alignment, color, alpha)

draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
// Definir fonte e alinhamento para o desenho do menu
// Set font and alignment for menu drawing

var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();
var _cx = _wgui / 2;
var _cy = 180;
// Obter dimensões da GUI e definir o centro do ecrã
// Get GUI dimensions and set screen center

// Título com sombra
// Title with shadow
draw_set_color(c_black);
draw_text(_cx + 2, 62, "CONQUISTAS"); 
draw_set_color(c_yellow);
draw_text(_cx, 60, "CONQUISTAS"); 
// Desenha o texto duas vezes para criar sombra / Draws text twice to create shadow effect

// Lista de conquistas
// Achievements list
var conquistas_lista = [
    ["primeiro_porco", "Primeiro Bacon!", "Mate seu primeiro porco"],
    ["10_porcos", "Caçador de Porcos!", "Mate 10 porcos"],
    ["explosivo", "Explosivo!", "Seja atingido por uma bomba"]
];
// Lista de conquistas: id, nome, descrição
// List of achievements: id, name, description

for (var i = 0; i < array_length(conquistas_lista); i++) {
    var _id = conquistas_lista[i][0];
    var _nome = conquistas_lista[i][1];
    var _desc = conquistas_lista[i][2];
    var _desbloqueada = save_tem_conquista(_id);
    // Verifica se a conquista está desbloqueada / Check if achievement is unlocked

    // Fundo da conquista
    // Achievement background
    var _box_y = _cy - 25;
    
    if (_desbloqueada) {
        // Fundo dourado para desbloqueadas
        // Gold background for unlocked achievements
        draw_set_alpha(0.3);
        draw_set_color(c_yellow);
        draw_roundrect(_cx - 300, _box_y, _cx + 300, _box_y + 70, false);
        draw_set_alpha(1);
        
        // Borda dourada
        // Gold border
        draw_set_color(c_yellow);
        draw_roundrect(_cx - 300, _box_y, _cx + 300, _box_y + 70, true);
        
        // Texto da conquista
        // Achievement text
        draw_set_color(c_white);
        draw_text(_cx, _cy - 5, _nome);
        draw_set_color(c_ltgray);
        draw_text(_cx, _cy + 20, _desc);
    } else {
        // Fundo escuro para bloqueadas
        // Dark background for locked achievements
        draw_set_alpha(0.2);
        draw_set_color(c_dkgray);
        draw_roundrect(_cx - 300, _box_y, _cx + 300, _box_y + 70, false);
        draw_set_alpha(1);
        
        // Borda escura
        // Dark border
        draw_set_color(c_gray);
        draw_roundrect(_cx - 300, _box_y, _cx + 300, _box_y + 70, true);
        
        // Texto bloqueado
        // Locked text
        draw_set_color(c_gray);
        draw_text(_cx, _cy - 5, "???");
        draw_text(_cx, _cy + 20, "Conquista bloqueada");
    }
    
    _cy += 90; 
    // Espaço vertical entre conquistas
    // Vertical spacing between achievements
}

// Instruções com sombra
// Instructions with shadow
draw_set_color(c_black);
draw_text(_cx + 1, _hgui - 49, "Pressione ENTER para voltar");
draw_set_color(c_white);
draw_text(_cx, _hgui - 50, "Pressione ENTER para voltar");
// Texto com sombra que informa o jogador como sair / Shadowed text instructing player how to exit

// Reset
// Restore previous drawing settings
draw_set_font(_old_font);
draw_set_halign(_old_halign);
draw_set_valign(_old_valign);
draw_set_color(_old_color);
draw_set_alpha(_old_alpha);
