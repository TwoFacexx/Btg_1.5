show_debug_message("Verificando posições..."); 
// Mostrar mensagem de debug que indica que está a verificar posições
// Show debug message indicating position checking

// Verificar se o jogador existe na instância
if (instance_exists(obj_player)) {
    // Mostrar a posição atual do jogador no ecrã (x, y)
    show_debug_message("Player em: " + string(obj_player.x) + ", " + string(obj_player.y));
}

// Inicializar contador de moedas encontradas
var moedas_encontradas = 0;

// Percorrer todas as instâncias do objeto obj_moeda
with (obj_moeda) {
    moedas_encontradas++; 
    // Incrementar contador para cada moeda encontrada
    
    // Mostrar a posição de cada moeda no ecrã (x, y)
    show_debug_message("Moeda " + string(moedas_encontradas) + " em: " + string(x) + ", " + string(y));
    
    // Verificar se o jogador existe para calcular distâncias
    if (instance_exists(obj_player)) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        // Calcular a distância da moeda até ao jogador
        
        show_debug_message("  Distância do player: " + string(dist));
        // Mostrar a distância no debug
        
        // Se a distância for menor que 32 pixels
        if (dist < 32) {
            show_debug_message("  MOEDA MUITO PERTO DO PLAYER!");
            // Aviso que a moeda está muito perto do jogador
        }
        
        // Verificar se a moeda está colidindo com o jogador
        if (place_meeting(x, y, obj_player)) {
            show_debug_message("  MOEDA COLIDINDO COM PLAYER!");
            // Aviso que a moeda está a colidir com o jogador
        }
    }
}

// Mostrar no debug o total de moedas encontradas na sala
show_debug_message("Total de moedas na room: " + string(moedas_encontradas));
// Mostrar no debug a quantidade global de moedas coletadas
show_debug_message("Moedas globais atual: " + string(global.moedas_total));
