// Só mostrar HUD nas rooms de jogo (não no menu)
if (room == rm_menu || room == rm_opcoes || room == rm_conquistas) {
    exit; 
    // Sair sem desenhar nada // Exit without drawing anything
}

if (game_over) {
    exit; 
    // Sair sem desenhar HUD durante game over // Exit without drawing HUD during game over
}

// Desenhar a quantidade de vidas no ecrã
var _x = 20; 
var _y = 40; 
var _qtd = 40; 
// Desenhar um coração por cada vida
repeat(global.vida)
{
    desenha_coracao(_x, _y); 
    // Desenha o coração na posição atual
    
    _x += _qtd; 
    // Incrementa a posição X para o próximo coração
}

// ===== POPUP DE SAVE =====
if (popup_save_ativo) {
    desenhar_popup_save(); 
    // Desenha o popup de save
}

draw_set_font(Font2); 
// Define a fonte para o texto

// Texto das moedas com sombra para melhor visibilidade
draw_set_color(c_black); 
draw_text(62, 102, "Moedas: " + string(global.moedas_total)); 
// Desenha sombra do texto das moedas

draw_set_color(c_white); 
draw_text(60, 100, "Moedas: " + string(global.moedas_total)); 
// Desenha o texto principal das moedas

draw_set_font(-1); 
// Resetar fonte para padrão
