// ========================================
// SISTEMA DE SAVE COMPLETO / COMPLETE SAVE SYSTEM
// Script: scr_save_system
// ========================================

// Variáveis globais do sistema de save / Global variables for the save system
global.save_data = ds_map_create();
global.save_file = "pigplatformer_save.dat";

// ========================================
// INICIALIZAÇÃO DO SISTEMA / SYSTEM INITIALIZATION
// ========================================

/// @function save_system_init()
/// @description Inicializa a estrutura de dados do save / Initializes the save data structure
function save_system_init() {
    // Criar estrutura base se não existir / Create base structure if it doesn't exist
    if (!ds_map_exists(global.save_data, "jogador")) {
        show_debug_message("Criando estrutura de save do zero...");
        
        // Dados do jogador / Player data
        var jogador = ds_map_create();
        
        // Estatísticas do jogador / Player stats
        var stats = ds_map_create();
        ds_map_add(stats, "moedas_total", 0);
        ds_map_add(stats, "porcos_mortos", 0);
        ds_map_add(stats, "tempo_jogado", 0);
        ds_map_add(stats, "pontos_record", 0);
        ds_map_add(stats, "mortes_total", 0);
        ds_map_add(stats, "vidas_atuais", global.max_vida);
        ds_map_add(stats, "nivel_atual", 1);
        
        // Lista de conquistas desbloqueadas / List of unlocked achievements
        var conquistas = ds_list_create();
        
        // ✅ NOVA: Lista de moedas coletadas permanentemente / New: List of permanently collected coins
        var moedas_coletadas = ds_list_create();
        
        // Configurações do jogo / Game settings
        var config = ds_map_create();
        ds_map_add(config, "volume_master", 1.0);
        ds_map_add(config, "volume_sfx", 1.0);
        ds_map_add(config, "volume_musica", 1.0);
        ds_map_add(config, "resolucao", "1920x1080");
        
        // Adicionar estruturas ao jogador / Add structures to player
        ds_map_add_map(jogador, "estatisticas", stats);
        ds_map_add_list(jogador, "conquistas", conquistas);
        ds_map_add_list(jogador, "moedas_coletadas", moedas_coletadas);
        ds_map_add_map(jogador, "configuracoes", config);
        
        // Adicionar jogador ao save_data principal / Add player to main save_data
        ds_map_add_map(global.save_data, "jogador", jogador);
        
        // Metadados do save / Save metadata
        ds_map_add(global.save_data, "data_criacao", date_datetime_string(date_current_datetime()));
        ds_map_add(global.save_data, "versao", "1.0");
        
        show_debug_message("Estrutura criada com sistema de moedas persistentes");
    } else {
        show_debug_message("Estrutura de save já existia");
    }
}

// ========================================
// SALVAR DADOS / SAVE DATA
// ========================================

/// @function save_game()
/// @description Salva todos os dados no arquivo / Saves all data to the file
function save_game() {
    show_debug_message("Salvando jogo - Moedas: " + string(global.moedas_total));
    
    // Atualizar data de último save / Update last save date
    ds_map_replace(global.save_data, "ultimo_save", date_datetime_string(date_current_datetime()));
    
    // Verificação de sanidade dos dados / Data sanity check
    if (global.moedas_total < 0) {
        show_debug_message("ERRO: Moedas negativas! Corrigindo...");
        global.moedas_total = 0;
    }
    
    // Atualizar estatísticas atuais no save / Update current stats in save
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var stats = jogador[? "estatisticas"];
        if (stats != undefined) {
            ds_map_replace(stats, "moedas_total", global.moedas_total);
            ds_map_replace(stats, "porcos_mortos", global.porcos_mortos_total);
            ds_map_replace(stats, "tempo_jogado", global.tempo_total_jogado);
            ds_map_replace(stats, "vidas_atuais", global.vida);
            ds_map_replace(stats, "nivel_atual", global.nivel_atual);
        }
    }
    
    try {
        // Converter para JSON / Convert to JSON string
        var json_string = json_encode(global.save_data);
        
        // Encriptar em Base64 / Encode to Base64
        var encoded_string = base64_encode(json_string);
        
        // Salvar no arquivo / Save to file
        var file = file_text_open_write(global.save_file);
        file_text_write_string(file, encoded_string);
        file_text_close(file);
        
        // Feedback visual / Visual feedback
        show_debug_message("Jogo salvo com sucesso! Moedas salvas: " + string(global.moedas_total));
        
        return true;
        
    } catch(_exception) {
        show_debug_message("ERRO ao salvar jogo: " + string(_exception.message));
        return false;
    }
}

// ========================================
// CARREGAR DADOS / LOAD DATA
// ========================================

/// @function load_game()
/// @description Carrega dados do arquivo / Loads data from the save file
function load_game() {
    if (file_exists(global.save_file)) {
        try {
            // Ler arquivo / Read file
            var file = file_text_open_read(global.save_file);
            var encoded_string = file_text_read_string(file);
            file_text_close(file);
            
            // Decodificar Base64 / Decode Base64
            var json_string = base64_decode(encoded_string);
            
            // Destruir dados antigos / Destroy old data
            if (ds_exists(global.save_data, ds_type_map)) {
                ds_map_destroy(global.save_data);
            }
            
            // Carregar novo JSON / Load new JSON data
            global.save_data = json_decode(json_string);
            
            if (global.save_data == -1) {
                show_debug_message("Erro ao carregar save - arquivo corrompido");
                global.save_data = ds_map_create();
                save_system_init();
                return false;
            }
            
            // Aplicar dados carregados às variáveis globais / Apply loaded data to globals
            aplicar_dados_carregados();
            
            show_debug_message("Jogo carregado com sucesso!");
            return true;
            
        } catch(_exception) {
            show_debug_message("Erro ao decodificar save: " + string(_exception.message));
            global.save_data = ds_map_create();
            save_system_init();
            return false;
        }
    } else {
        show_debug_message("Arquivo de save não encontrado");
        save_system_init();
        return false;
    }
}

// ========================================
// APLICAR DADOS CARREGADOS / APPLY LOADED DATA
// ========================================

/// @function aplicar_dados_carregados()
/// @description Aplica os dados carregados às variáveis globais / Applies loaded data to global variables
function aplicar_dados_carregados() {
    show_debug_message("=== APLICANDO DADOS CARREGADOS ===");
    
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var stats = jogador[? "estatisticas"];
        if (stats != undefined) {
            // Debug: Ver o que está sendo carregado / Debug: See what is loaded
            var moedas_save = stats[? "moedas_total"];
            show_debug_message("Moedas no save: " + string(moedas_save));
            
            // Aplicar estatísticas COM VALIDAÇÃO / Apply stats WITH VALIDATION
            global.vida = real(stats[? "vidas_atuais"]);
            
            // Se está carregando um "novo jogo", resetar moedas / If loading a new game, reset coins
            if (global.novo_jogo_flag) {
                show_debug_message("NOVO JOGO: Resetando moedas para 0");
                global.moedas_total = 0;
                global.novo_jogo_flag = false;
            } else {
                global.moedas_total = real(moedas_save);
            }
            
            show_debug_message("Moedas aplicadas: " + string(global.moedas_total));
            
            global.porcos_mortos_total = real(stats[? "porcos_mortos"]);
            global.pontos_record = real(stats[? "pontos_record"]);
            global.mortes_total = real(stats[? "mortes_total"]);
            global.nivel_atual = real(stats[? "nivel_atual"]);
            global.tempo_total_jogado = real(stats[? "tempo_jogado"]);
        }
        
        var config = jogador[? "configuracoes"];
        if (config != undefined) {
            // Aplicar configurações / Apply settings
            global.volume_master = real(config[? "volume_master"]);
            global.volume_sfx = real(config[? "volume_sfx"]);
            global.volume_musica = real(config[? "volume_musica"]);
            
            // Aplicar volumes / Apply audio volumes
            audio_master_gain(global.volume_master);
        }
    }
    
    show_debug_message("=== FIM APLICAR DADOS ===");
}

// ========================================
// FUNÇÕES DE ESTATÍSTICAS / STATISTICS FUNCTIONS
// ========================================

/// @function save_update_stat(stat_name, value, increment)
/// @description Atualiza uma estatística específica / Updates a specific stat
/// @param {string} stat_name Nome da estatística / Stat name
/// @param {real} value Valor a adicionar/definir / Value to add/set
/// @param {bool} increment Se true, incrementa; se false, define / If true, increments; if false, sets
function save_update_stat(_stat_name, _value, _increment = true) {
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var stats = jogador[? "estatisticas"];
        if (stats != undefined) {
            if (_increment) {
                var current = real(stats[? _stat_name]);
                ds_map_replace(stats, _stat_name, current + _value);
            } else {
                ds_map_replace(stats, _stat_name, _value);
            }
        }
    }
}

/// @function save_get_stat(stat_name)
/// @description Obtém uma estatística / Gets a stat
/// @param {string} stat_name Nome da estatística / Stat name
function save_get_stat(_stat_name) {
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var stats = jogador[? "estatisticas"];
        if (stats != undefined) {
            return stats[? _stat_name];
        }
    }
    return 0;
}

// ========================================
// SISTEMA DE CONQUISTAS / ACHIEVEMENTS SYSTEM
// ========================================

/// @function save_add_achievement(achievement_id)
/// @description Adiciona uma conquista / Adds an achievement
/// @param {string} achievement_id ID da conquista / Achievement ID
function save_add_achievement(_achievement_id) {
    show_debug_message("=== DEBUG save_add_achievement ===");
    show_debug_message("ID da conquista: " + string(_achievement_id));
    
    var jogador = global.save_data[? "jogador"];
    show_debug_message("Jogador existe: " + string(jogador != undefined));
    
    if (jogador != undefined) {
        var conquistas = jogador[? "conquistas"];
        show_debug_message("Lista conquistas existe: " + string(conquistas != undefined));
        
        if (conquistas != undefined) {
            // Verificar se já não tem / Check if achievement already unlocked
            if (ds_list_find_index(conquistas, _achievement_id) == -1) {
                ds_list_add(conquistas, _achievement_id);
                show_debug_message("Conquista adicionada!");
                
                // Salvar imediatamente / Save immediately
                save_game();
                
                return true;
            } else {
                show_debug_message("Conquista já existe na lista");
            }
        } else {
            show_debug_message("ERRO: Lista conquistas é undefined!");
        }
    } else {
        show_debug_message("ERRO: Jogador é undefined!");
    }
    return false;
}

/// @function save_tem_conquista(achievement_id)
/// @description Verifica se tem uma conquista / Checks if an achievement exists
/// @param {string} achievement_id ID da conquista / Achievement ID
function save_tem_conquista(_id) {
    // Verificar se save_data existe / Check if save_data exists
    if (!ds_exists(global.save_data, ds_type_map)) {
        return false;
    }
    
    var jogador = global.save_data[? "jogador"];
    if (jogador == undefined) {
        return false;
    }
    
    var conquistas = jogador[? "conquistas"];
    if (conquistas == undefined) {
        return false;
    }
    
    // Verificar se a conquista existe na lista / Check if achievement is in list
    var resultado = ds_list_find_index(conquistas, _id) != -1;
    return resultado;
}

// ========================================
// SISTEMA DE MOEDAS PERSISTENTES / PERSISTENT COINS SYSTEM
// ========================================

/// @function marcar_moeda_coletada(moeda_id)
/// @description Marca uma moeda como coletada permanentemente / Marks a coin as permanently collected
/// @param {string} moeda_id ID único da moeda / Unique coin ID
function marcar_moeda_coletada(_moeda_id) {
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        // Verificar se já existe lista de moedas coletadas / Check if coin list exists
        var moedas_coletadas = jogador[? "moedas_coletadas"];
        
        if (moedas_coletadas == undefined) {
            // Criar lista se não existir / Create list if missing
            moedas_coletadas = ds_list_create();
            ds_map_add_list(jogador, "moedas_coletadas", moedas_coletadas);
        }
        
        // Adicionar moeda à lista se ainda não estiver / Add coin if not present
        if (ds_list_find_index(moedas_coletadas, _moeda_id) == -1) {
            ds_list_add(moedas_coletadas, _moeda_id);
            show_debug_message("Moeda " + _moeda_id + " adicionada à lista permanente");
        }
    }
}

/// @function moeda_ja_coletada(moeda_id)
/// @description Verifica se uma moeda já foi coletada / Checks if a coin was already collected
/// @param {string} moeda_id ID único da moeda / Unique coin ID
function moeda_ja_coletada(_moeda_id) {
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var moedas_coletadas = jogador[? "moedas_coletadas"];
        
        if (moedas_coletadas != undefined) {
            return ds_list_find_index(moedas_coletadas, _moeda_id) != -1;
        }
    }
    
    return false; // Se não há lista, moeda não foi coletada / If no list, coin not collected
}

/// @function resetar_moedas_coletadas()
/// @description Reseta todas as moedas coletadas (para novo jogo) / Resets all collected coins (for new game)
function resetar_moedas_coletadas() {
    show_debug_message("Resetando todas as moedas coletadas...");
    
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var moedas_coletadas = jogador[? "moedas_coletadas"];
        
        if (moedas_coletadas != undefined) {
            ds_list_clear(moedas_coletadas);
            show_debug_message("Lista de moedas coletadas limpa");
        }
    }
    
    // Resetar contador também / Reset coin count also
    global.moedas_total = 0;
    save_update_stat("moedas_total", 0, false);
}

// ========================================
// FUNÇÕES UTILITÁRIAS / UTILITY FUNCTIONS
// ========================================

/// @function save_exists()
/// @description Verifica se existe arquivo de save / Checks if save file exists
function save_exists() {
    return file_exists(global.save_file);
}

/// @function delete_save()
/// @description Deleta o arquivo de save / Deletes the save file
function delete_save() {
    if (file_exists(global.save_file)) {
        file_delete(global.save_file);
        show_debug_message("Arquivo de save deletado");
    }
    
    // Reiniciar dados / Reset data
    if (ds_exists(global.save_data, ds_type_map)) {
        ds_map_destroy(global.save_data);
    }
    global.save_data = ds_map_create();
    save_system_init();
}

// ========================================
// FUNÇÕES DE DEBUG / DEBUG FUNCTIONS
// ========================================

/// @function debug_moedas_coletadas()
/// @description Debug - mostra todas as moedas coletadas / Debug - shows all collected coins
function debug_moedas_coletadas() {
    show_debug_message("=== MOEDAS COLETADAS PERMANENTEMENTE ===");
    
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var moedas_coletadas = jogador[? "moedas_coletadas"];
        
        if (moedas_coletadas != undefined) {
            var total = ds_list_size(moedas_coletadas);
            show_debug_message("Total de moedas coletadas: " + string(total));
            
            for (var i = 0; i < total; i++) {
                show_debug_message("  " + string(i + 1) + ": " + string(moedas_coletadas[| i]));
            }
        } else {
            show_debug_message("Nenhuma moeda coletada ainda");
        }
    }
    
    show_debug_message("=== FIM DEBUG MOEDAS ===");
}

/// @function debug_save_completo()
/// @description Debug completo do sistema de save / Full debug of the save system
function debug_save_completo() {
    show_debug_message("=== DEBUG SISTEMA SAVE COMPLETO ===");
    
    show_debug_message("1. Arquivo save existe: " + string(save_exists()));
    show_debug_message("2. Global moedas_total: " + string(global.moedas_total));
    show_debug_message("3. Global porcos_mortos: " + string(global.porcos_mortos_total));
    show_debug_message("4. Global vida atual: " + string(global.vida));
    show_debug_message("5. Global nível atual: " + string(global.nivel_atual));
    
    var jogador = global.save_data[? "jogador"];
    if (jogador != undefined) {
        var stats = jogador[? "estatisticas"];
        if (stats != undefined) {
            show_debug_message("6. Save moedas_total: " + string(stats[? "moedas_total"]));
            show_debug_message("7. Save porcos_mortos: " + string(stats[? "porcos_mortos"]));
        }
        
        var conquistas = jogador[? "conquistas"];
        if (conquistas != undefined) {
            show_debug_message("8. Total conquistas: " + string(ds_list_size(conquistas)));
        }
        
        var moedas_coletadas = jogador[? "moedas_coletadas"];
        if (moedas_coletadas != undefined) {
            show_debug_message("9. Total moedas coletadas: " + string(ds_list_size(moedas_coletadas)));
        }
    }
    
    show_debug_message("=== FIM DEBUG COMPLETO ===");
}

// ========================================
// FUNÇÕES DE LIMPEZA / CLEANUP FUNCTIONS
// ========================================

/// @function cleanup_save_system()
/// @description Limpa memória do sistema de save / Cleans save system memory
function cleanup_save_system() {
    if (ds_exists(global.save_data, ds_type_map)) {
        ds_map_destroy(global.save_data);
        show_debug_message("Sistema de save limpo da memória");
    }
}
