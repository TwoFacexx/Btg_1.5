persistent = true; // Tornar o objeto persistente entre rooms // Make the object persistent between rooms
window_set_fullscreen(true); // Definir o jogo para ecrã inteiro // Set the game to fullscreen

// INICIALIZAR VALORES PADRÃO PRIMEIRO // INITIALIZE DEFAULT VALUES FIRST
global.moedas_total = 0; // Total de moedas inicializado a 0 // Total coins set to 0
global.porcos_mortos_total = 0; // Total de porcos mortos inicializado a 0 // Total pigs killed set to 0
global.vida = global.max_vida; // Vida atual é definida com o valor máximo // Current life set to maximum

save_system_init(); // Inicializar o sistema de save // Initialize save system

// Tentar carregar save automático APENAS se não for novo jogo // Try to auto-load save ONLY if not a new game
if (save_exists() && !global.novo_jogo_flag) {
    show_debug_message("Carregando save existente..."); // Mensagem de debug a indicar carregamento de save // Debug message showing save loading
    load_game(); // Carregar dados do jogo // Load game data
    audio_master_gain(global.volume_musica); // Ajustar volume da música // Set music volume
} else {
    show_debug_message("Usando valores padrão (novo jogo ou sem save)"); // Mensagem de debug se for novo jogo ou sem save // Debug message for new game or no save
    // Garantir valores zerados // Ensure zeroed values
    global.moedas_total = 0; // Reiniciar total de moedas // Reset total coins
    global.porcos_mortos_total = 0; // Reiniciar total de porcos mortos // Reset total pigs killed
}

// Resetar flag após uso // Reset the flag after use
global.novo_jogo_flag = false;

// Debug para verificar se funcionou // Debug to check if it worked
show_debug_message("Save inicializado. Moedas finais: " + string(global.moedas_total)); // Mostrar total de moedas após inicialização // Show total coins after init
// Aguardar 1 frame para o player aparecer // Wait 1 frame for player to appear
alarm[0] = 1;

// Debug para verificar se funcionou // Debug to verify structure
show_debug_message("Save inicializado. Testando estrutura..."); // Testar estrutura do save // Test save structure
var jogador = global.save_data[? "jogador"]; // Obter dados do jogador guardado // Get saved player data
show_debug_message("Jogador existe após init: " + string(jogador != undefined)); // Verificar se jogador foi carregado // Check if player loaded

// Tentar carregar save automático // Try to auto-load save
if (save_exists()) {
    show_debug_message("Save existe, carregando..."); // Mensagem de debug a indicar que o save existe // Debug message indicating save exists
    load_game(); // Carregar dados do jogo // Load game data
} else {
    show_debug_message("Save não existe, usando dados padrão"); // Mensagem de debug caso não haja save // Debug message if no save exists
}

// Método de desenhar o coração // Method to draw the heart
desenha_coracao = function(_x, _y)
{
	draw_sprite_ext(spr_coracao, 8 * (get_timer() / 1000000), _x, _y, 2.5, 2.5, 0, c_white, 1); // Desenhar coração com animação rotativa // Draw heart with rotating animation
}

// Tentar carregar save automático // Try to auto-load save again
if (save_exists()) {
    load_game(); // Carregar save // Load save
}

global.vel_mult = 1; // Multiplicador de velocidade global (para slow motion) // Global speed multiplier (for slow motion)
game_over = false; // Indica se o jogo terminou // Indicates if the game is over
valor = 0; // Valor auxiliar usado em efeitos visuais // Auxiliary value for visual effects
contador = 0; // Contador para animações // Counter for animations

// Timer para save automático // Auto-save timer
save_timer = 0; // Reiniciar o temporizador // Reset timer
save_interval = room_speed * 60; // Salvar a cada 60 segundos // Save every 60 seconds

// Criar o pause manager automaticamente // Automatically create pause manager
if (!instance_exists(obj_pause_manager)) {
    instance_create_layer(0, 0, "Instances", obj_pause_manager); // Criar instância do gestor de pausa // Create pause manager instance
}

// Variáveis do popup de save // Save popup variables
popup_save_ativo = false; // Estado do popup (ativo ou não) // Popup state (active or not)
popup_save_alpha = 0; // Transparência do popup // Popup transparency
popup_save_y_offset = 50; // Deslocamento vertical do popup // Vertical offset of popup
popup_save_timer = 0; // Temporizador do popup // Popup timer
popup_save_duracao = 120; // 2 segundos a 60fps // 2 seconds at 60fps
